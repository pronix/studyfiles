# -*- coding: utf-8 -*-
class Folder < ActiveRecord::Base

  before_create :default_path_name

  after_create :create_log

  include Models::Path
  include Hierarchy

  belongs_to :user
  belongs_to :university
  has_many :subject_folders
  has_many :subjects, :through => :subject_folders

  has_many :documents

  scope :unsorted, where(:university_id => nil)
  scope :top, where(:path => "Top")


  def level
    index_path.size
  end

  def top_level?
    path == 'Top'
  end

  def ext_ancestors(options={})
    return [] if top_level?
    objects = self.class.ancestors_of(self).scoped(options).group_by(&:id)
    index_path.delete_if{|x| x == 0}.map { |id| objects[id].first }
  end


  #Копирум  из одной папки в другую
  def copy_to_folder(folder)
    #строим новый путь
    self.parent = folder
    self.save
  end

  #Копируем папку в университет
  def copy_to_university(university)
    self.update_attributes(:university_id => university.id)
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
  def zip_folder
    file_name = "tmp/ziped_clients/#{self.name}.zip"
    docs = self.get_documents #получаем документы детей
    file = Zip::ZipFile.open(file_name, Zip::ZipFile::CREATE) { |zipfile|
     docs.each {|current_document|
        zipfile.add(current_document.name, current_document.item.path)
     }
    }
    return file_name
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
    docs = self.get_documents
    docs.size
  end

  def get_documents
    docs = []
    docs.concat(self.documents)
    self.descendants.each do |folder|
      docs.concat(folder.documents)
    end
    docs
  end

  private


  #Перед созданием генерируем path_name
  def default_path_name
    path_name = name.gsub(" ", "_")
  end

  # OPTIMIZE: move it to observer

  def create_log
    SiteLog.create_foler(self)
  end


end
