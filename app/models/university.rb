# -*- coding: utf-8 -*-
class University < ActiveRecord::Base

  validates :abbreviation, :presence => true
  validates :name,         :presence => true, :uniqueness => true
  validates :city,         :presence => true

  has_and_belongs_to_many :subjects
  
  has_many :sections, :through => :subjects
  has_many :folders
  has_many :documents
  has_many :users

  define_index do
    indexes name
    indexes abbreviation
    indexes city
    indexes subjects.name, :as => :subject_name
    indexes folders.name, :as => :folder_name
  end

  has_attached_file :logo, :styles => { :thumb => "60x60>", :icon => "32x32" }

  # Return university documents without folder
  def documents_without_folder
    documents.unfolded
  end

  def full_title
    "#{self.abbreviation} - #{self.name}"
  end

  def sections
    return self.subjects if self.subjects.sectionized.empty?
    self.subjects.sectionized
  end

  def stats
    "#{subjects.count} предметов, #{documents.count} файлов, #{((documents.sum(:item_file_size).to_f / (1024**2)).round(1))} Мб" #FIXME прикрутить pluralize
  end

  #Подсчет рейтинга университета
  def raiting
    Document.in_path(self.id.to_s).sum(:raiting)
  end

  #Количество файлов
  def files_count
    Document.in_path(self.id).count
  end

  #сумарный размер файлов
  def files_size
    Document.in_path(self.id).sum(:item_file_size)
  end

  #количество предметов
  def subject_count
    self.subjects.size
  end

  #Список разделов в алфавитном порядке
  def sections_order
    self.sections.order(:name)
  end

  #Первые пять пердметов университета
  def short_subjects_list
    self.subjects.limit(5)
  end

  def update_user_rating!
    users.sort_by{ |elem| elem.raiting }.each do |u|
      r = 1
      u.update_attribute(:university_rating, r)
      r += 1
    end
  end
end
