# Класс для хранения документов
class Document < ActiveRecord::Base

  require 'zip/zip'
  require 'coderay'

  before_save :default_name

  validates :item,         :presence => true
 
  after_save :queue_process_item

  has_many :votes
  has_many :user_votes, :through => :votes, :source => :user

  belongs_to :user
  belongs_to :university
  belongs_to :folder

  scope :unsorted, where(:university_id => nil)


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
    self.update_attributes(:folder_id => folder.id)
  end

  #Копируем файл в университет
  def copy_to_university(university)
    self.update_attributes(:university_id => university.id)
  end

  #Копируем файл в предмет
  def copy_to_subject(subject)
    subject.documents << self
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
    #self.delete
    #File.delete(file)
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

  def queue_process_item
    send_later(:file_processing) if !self.item_processed
  end
  
  def file_processing
    self.process
    self.item_processed = true
    self.save!
  end

  #handle_asynchronously :unzip_file, :run_at => Proc.new { 10.second.from_now }, :priority => 0

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

  #определение разрешение файла (для вывода в html)
  def extension
    self.item_file_name.split(".").last
  end

  def item_html
    return self.item.path + ".html" if item_processed
  end

  #конвертирование исходного кода в html

  protected
    def default_name
      self.name = self.item_file_name if self.name.blank?
    end

    def process
      file_type = self.item.content_type
      case file_type
        when 'application/zip'
          self.unzip_file "/public/zips"
        when 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/rtf'
          self.office_to_html
        else 
          self.source_to_html
      end
    end

    def source_to_html
      type = ""
      case self.extension
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
      highlighted = CodeRay.encode(File.read(source_file), type, :html, :css => :style, :wrap => :div)
      File.open(self.item.path + ".html", "w"){ |f| f.write(highlighted) }
    end

    #представление msofice документа кода в html
    def office_to_html
      unless File.exist? self.item.path + "html"
        cmd = "abiword --to=html #{self.item.path}"
        system(cmd)
      end
      return self.item.path + "html"
    end

    #предпросмотр текстового файла
    def text_to_html
      string = File.open(self.item.path, 'r'){ |file| file.read }
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
end
