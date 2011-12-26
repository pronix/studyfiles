# -*- coding: utf-8 -*-
class Folder < ActiveRecord::Base
  include Hierarchy

  has_many :documents, :dependent => :destroy

  belongs_to :user
  belongs_to :university
  belongs_to :subject

  scope :unsorted, where(:university_id => nil)
  scope :top, where(:path => '')
  scope :unsubjected, where(:subject_id => nil)
  scope :by_univer, lambda{|univer| where(:university_id => univer.id)}

  after_create :create_log
  before_create :default_path_name
  before_destroy :delete_sub_folder

  define_index do
    indexes :name
    indexes :description
    has :rating, :created_at
  end

  def delete_sub_folder
    children.destroy_all
  end

  def level
    level = index_path.size <= 5 ? index_path.size + 2 : 7
    level
  end

  def top_level?
    path == ''
  end

  def ext_ancestors(options={})
    return [] if top_level?
    objects = self.class.ancestors_of(self).scoped(options).group_by(&:id)
    index_path.delete_if{|x| x == 0}.map { |id| objects[id].first }
  end

  def move_files(folder_ids, document_ids)
    if folder_ids
      folder_ids.each do |i|
        folder = Folder.find(i)
        folder.documents.each do |doc|
          doc.rollback_rating(true)
        end
        folder.copy_to_folder(self)
        folder.documents.each do |doc|
          folder.ancestors.each {|p| p.update_attribute(:rating, p.rating + doc.rating)}
        end
      end
    end
    if document_ids
      document_ids.each do |i|
          doc = Document.find(i)
          doc.rollback_rating
          doc.copy_to_folder(self)
          self.update_attribute(:rating, self.rating + doc.rating)
          ancestors.each {|p| p.update_attribute(:rating, p.rating + doc.rating)}
      end
    end
  end


  #Копирум  из одной папки в другую
  def copy_to_folder(folder)
    #строим новый путь
    self.parent = folder
    self.save
  end


  def rollback_vote(type)
    sign = false
    new_rating = 0
    sign = true if rating >= 0

    if (type)
      new_rating = rating.abs - 1
      new_rating = sign ? new_rating : -new_rating
    elsif (!type)
      new_rating = rating - 1
    end

    ancestors.each {|p| p.rollback_vote(type)}

    self.update_attribute(:rating, new_rating)
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

    main_path = "public/system/ziped_clients/#{id}"
    FileUtils.mkdir File.join(main_path)
    documents.each {|d| d.hard_copy_to(main_path)}
    create_subfolders(children, main_path)
    return main_path
  end

  #Создаем архив для скачки папки
  # OPTIMIZE: WTF:
  def zip_folder
    FileUtils.mkdir Rails.root.join('public/system/ziped_clients/') unless File.exist?('public/system/ziped_clients')
    # TODO: If zipped folder exists and folder not change
    # send it without zip
    file_name = "public/system/ziped_clients/#{id}.zip"
    if children.present?
      folder_path = create_folders_tree
      %x(cd #{Rails.root.join('public/system/ziped_clients')} && zip -r #{id} `basename #{folder_path}`)
      FileUtils.rm_r Rails.root.join(file_name).to_s.chomp(File.extname(Rails.root.join(file_name).to_s))
    else
      Zip::ZipFile.open(file_name, Zip::ZipFile::CREATE) do |zipfile|
        get_documents.each {|d| zipfile.add(d.item_file_name, d.item.path)}
      end
    end
    return Rails.root.join(file_name)
  end

  #Подсчет рейтинга папки
  def quick_rating
    docs = self.get_documents
    docs.sum{|d| d.quick_rating }
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

  def files_size
    docs = self.get_documents
    docs.sum{|d| d.item_file_size}
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
