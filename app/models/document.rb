# Класс для хранения документов
class Document < ActiveRecord::Base
  
  include Hierarchy

  before_create :add_default_path
  
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
    self.update_attributes(:path => folder.path + "." + folder.name)
  end

  #Копируем файл в университет
  def copy_to_university(univer)
    self.update_attributes(:path => univer.id.to_s)
  end

  #Копируем файл в предмет
  def copy_to_subject(subject)
    subject.documents << self
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

  #Перед созданием ставим path = 'Top'
  def add_default_path
    self.path = 'Top'
    self.name = self.item_file_name
  end
end
