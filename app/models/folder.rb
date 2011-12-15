# -*- coding: utf-8 -*-
class Folder < ActiveRecord::Base
  require 'zip/zipfilesystem'

  before_create :default_path_name

  after_create :create_log

  include Models::Path
  include Hierarchy

  belongs_to :user
  belongs_to :university

  belongs_to :subject
  has_many :documents

  scope :unsorted, where(:university_id => nil)
  scope :top, where(:path => "Top")
  scope :unsubjected, where(:subject_id => nil)


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

  def zip_name
    "#{name}.zip"
  end

  def create_folders_tree
    def create_subfolders(folders, path)
      folders.each do |f|
        current_path = File.join(path, f.name)
        FileUtils.mkdir current_path
        f.documents.each {|d| d.hard_copy_to(current_path)}
        if f.children.present?
          create_subfolders(f.children, current_path)
        end
      end
    end

    main_path = "tmp/ziped_clients/#{id}"
    FileUtils.mkdir File.join(main_path)
    create_subfolders(children, main_path)
    return main_path
  end

  #Создаем архив для скачки папки
  # OPTIMIZE: WTF:
  def zip_folder
    FileUtils.mkdir Rails.root.join('tmp/ziped_clients/') unless File.exist?('tmp/ziped_clients')
    # TODO: If zipped folder exists and folder not change
    # send it without zip
    file_name = "tmp/ziped_clients/#{id}.zip"
    if children.present?
      folder_path = create_folders_tree
      %x(cd #{Rails.root.join('tmp/ziped_clients')} && zip -r #{id} `basename #{folder_path}`)
      FileUtils.rm_r Rails.root.join(file_name).to_s.chomp(File.extname(Rails.root.join(file_name).to_s))
    else
      Zip::ZipFile.open(file_name, Zip::ZipFile::CREATE) do |zipfile|
        get_documents.each {|d| zipfile.add(d.item_file_name, d.item.path)}
      end
    end
    return Rails.root.join(file_name)
  end

  #Подсчет рейтинга папки
  def rating
    docs = self.get_documents
    docs.sum{|d| d.rating }
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
