# Класс для хранения документов
class Document < ActiveRecord::Base

  require 'zip/zip'

  include Hierarchy

  before_create :add_default_path

  after_create :check_for_archive
  
  belongs_to :users
  
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
  def unzip_file (destination)
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

  #Перед созданием ставим path = 'Top'
  def add_default_path
    self.path = 'Top'
    self.name = self.item_file_name
  end

end
