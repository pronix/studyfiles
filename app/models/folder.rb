class Folder < ActiveRecord::Base
  
  before_create :add_default_path

  belongs_to :users
  has_many :subject_folders
  has_many :subjects, :through => :subject_folders
  
  #Копирум  из одной папки в другую
  def copy_to_folder(folder)
    #строим новый путь
    new_path = folder.path + "." + folder.path_name
    #запоминаем старый путь
    old_path = self.path + "." + self.path_name
    #находим файлы в этой папке
    documents = Document.all(:conditions => ["user_id = ? AND (path = ? or path ~ ?)", self.user_id, old_path, old_path + ".*"])
    #находим папки в этой папке
    folders = Folder.all(:conditions => ["user_id = ? AND (path = ? or path ~ ?)", self.user_id, old_path, old_path + ".*"])
    #изменяем путь этой папки
    self.update_attributes(:path => new_path)
    #строим новый путь для файлов
    new_path = new_path + "." + self.path_name
    #прописываем новый пути
    puts documents.size
    puts folders.size
    folders.each do |current_folder|
      current_folder.update_attributes(:path => current_folder.path.sub(old_path, new_path))
    end
    documents.each do |document|
      document.update_attributes(:path => document.path.sub(old_path, new_path))
    end
  end

  #Копируем папку в университет
  def copy_to_university(univer)
    old_path = self.path
    splited = old_path.split(".")
    splited[0] = univer.id.to_s
    new_path = splited.join(".")
    old_path = old_path + "." + self.name
    documents = Document.all(:conditions => ["path = ? or path ~ ?", old_path, old_path + ".*"])
    folders = Folder.all(:conditions => ["path = ? or path ~ ?", old_path, old_path  + ".*"])
    puts documents.size
    puts folders.size
    self.update_attributes(:path => new_path)
    new_path = new_path + "." + self.name
    folders.each do |current_folder|
      current_folder.update_attributes(:path => current_folder.path.sub(old_path, new_path))
    end
    documents.each do |document|
      document.update_attributes(:path => document.path.sub(old_path, new_path))
    end
  end

  #Копируем папку в предмет
  def copy_to_subject(subject)
    subject.folders << self
  end

  private
  
  #Перед созданием ставим path = 'Top' и генерируем имя для пути
  def add_default_path
    self.path = 'Top'
    self.path_name = self.name.gsub(" ", "_")
  end
end