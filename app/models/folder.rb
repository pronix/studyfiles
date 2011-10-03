class Folder < ActiveRecord::Base

  before_create :add_default_path


  belongs_to :user
  has_many :subject_folders
  has_many :subjects, :through => :subject_folders

  scope :in_path, lambda { |path| where(["path = ? or path ~ ?", path.to_s, path.to_s + ".*" ])}

  #Копирум  из одной папки в другую
  def copy_to_folder(folder)
    #строим новый путь
    new_path = folder.path + "." + folder.path_name
    #запоминаем старый путь
    old_path = self.path + "." + self.path_name
    self.update_folders_path new_path, old_path
  end

  #Копируем папку в университет
  def copy_to_university(univer)
    old_path = self.path
    splited = old_path.split(".")
    splited[0] = univer.id.to_s
    new_path = splited.join(".")
    old_path = old_path + "." + self.name
    self.update_folders_path new_path, old_path
  end

  #обновляему пути папки, подпапок и дочерних файлов
  def update_folders_path(new_path, old_path)
    #находим файлы в этой папке
    documents = self.user.documents.in_path(old_path)
    #находим папки в этой папке
    folders = self.user.folders.in_path(old_path)
    #изменяем путь этой папки
    self.update_attributes(:path => new_path)
    #строим новый путь для файлов
    new_path = new_path + "." + self.path_name
    #прописываем новый пути
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

  #Создаем архив для скачки папки
  def zip_folder(folder)
    file_name = "tmp/ziped_clients/#{folder.name}.zip"
    documents = Documents.in_path(folder.path)
    file = Zip::ZipFile.open(file_name, Zip::ZipFile::CREATE) { |zipfile|
      documents.each {|current_document|
        zipfile.add(current_document.name, current_document.item.path)
      }
     }
     return file
     #send_file file_name, :size => file.size,  :filename => "#{folder.name}.zip"
  end

  #Подсчет рейтинга папки
  def raiting
    Document.in_path(self.children_path).sum(:raiting)
  end

  #Путь у вложеных объектов
  def children_path
    self.path + "." + self.path_name
  end

  #Количество файлов
  def files_count
    Document.in_path(self.children_path).count(:raiting)
  end

  private

  #Перед созданием ставим path = 'Top' и генерируем имя для пути
  def add_default_path
    self.path = 'Top'
    self.path_name = self.name.gsub(" ", "_")
  end
end