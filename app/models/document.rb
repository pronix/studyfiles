# Класс для хранения документов
class Document < ActiveRecord::Base

  require 'zip/zip'
  require 'coderay'

  before_create :default_name

  after_create :check_for_archive

  has_many :votes
  has_many :user_votes, :through => :votes, :source => :user

  belongs_to :user
  belongs_to :university
  belongs_to :folder

  has_attached_file :item,
      :url  => "/assets/documents/:first_folder/:second_folder/:sha",
      :path => ":rails_root/public/assets/documents/:first_folder/:second_folder/:sha"

  #вытаскиваем первые два символа с хеша
  def first_folder
    self.sha[0..1]
  end

  #вытаскиваем вторую пару символов с хеша
  def second_folder
    self.sha[2..3]
  end

  #копируем файл в папку
  def copy_to_folder(folder)
    self.update_attributes(:path => folder.path + "." + folder.path_name)
  end

  #Копируем файл в университет
  def copy_to_university(univer)
    self.update_attributes(:path => univer.id.to_s)
  end

  #Копируем файл в предмет
  def copy_to_subject(subject)
    subject.documents << self
  end


  #проверка файла на архив
  def check_for_archive
    if self.item.content_type == 'application/zip'
      self.unzip_file "/public/zips"
    end
  end

  #Распаковка zip архива
  def unzip_file(destination)
    file = self.item.path
    user = self.user_id
    destination = Rails.root.to_s + destination
    files = Array.new
    Zip::ZipFile.open(file) { |zip_file|
     zip_file.each { |f|
       f_path=File.join(destination, f.name)
       FileUtils.mkdir_p(File.dirname(f_path))
       zip_file.extract(f, f_path) unless File.exist?(f_path)
       files.push(f_path)
     }
    }
    self.delete
    File.delete(file)
    until files.empty?
      document_path = files.pop
      if File.directory? document_path
        Dir.rmdir(document_path)
      else
        document = File.open(document_path)
        Document.create(:user_id => user, :item => document)
        File.delete(document_path)
      end
    end
  end

  handle_asynchronously :unzip_file, :run_at => Proc.new { 10.second.from_now }, :priority => 0

  #Увеличение рейтинга файла при скачке
  def to_download_file
    self.raiting += (self.raiting == -1 ? 2 : 1)
  end

  #увелчение рейтинга пользователем
  def increase_raiting_by(user)
    self.raiting += (self.raiting == -1 ? 2 : 1)
    user.user_votes << self
  end

  #уменьшение рейтинга пользователем
  def decrease_raiting_by(user)
    self.raiting -= (self.raiting == 1 ? 2 : 1)
    user.votes << Vote.new(:user_id => user.id, :document_id => self.id, :vote_type => false)
  end

  #Создаем архив для скачки файлов
  def zip_files(documents)
    file_name = "tmp/ziped_clients/#{documents.first.sha}.zip"
    file = Zip::ZipFile.open(file_name, Zip::ZipFile::CREATE) { |zipfile|
      documents.each {|current_document|
        zipfile.add(current_document.name, current_document.item.path)
      }
     }
     return file
     #send_file file_name, :size => file.size,  :filename => "#{documents.first.sha}.zip""
  end

  #определение разрешение файла (для вывода в html)
  def permission
    self.item_file_name.split(".").last
  end

  #предпросмотр текстового файла
  def text_to_html
    string = File.open(self.item.path, 'r'){ |file| file.read }
  end

  #конвертирование исходного кода в html
  def source_to_html
    type = ""
    case self.permission
    when "rb"
      type = "ruby"
    when "pl"
      type = "python"
    when "c"
      type = "c"
    when "php"
      type = "php"
    end
    source_file = File.expand_path(self.item.path)
    CodeRay.encode(File.read(source_file), type, :html, :css => :style, :wrap => :div)
  end

  #представление msofice документа кода в html
  def office_to_html
    unless File.exist? self.item.path + "html"
      cmd = "abiword --to=html #{self.item.path}"
      system(cmd)
    end
    return self.item.path + "html"
  end

  private

  #делаем интерполяцию, добавляем параметр первой папки
  Paperclip.interpolates :first_folder  do |attachment, style|
    attachment.instance.first_folder
  end

  #делаем интерполяцию, добавляем параметр второй папки
  Paperclip.interpolates :second_folder  do |attachment, style|
    attachment.instance.second_folder
  end

  #делаем интерполяцию, добавляем параметр имени файла
  Paperclip.interpolates :sha  do |attachment, style|
    attachment.instance.sha
  end

  #прописывает имя файла по умолчанию
  def default_name
    self.name = self.item_file_name
  end

end
