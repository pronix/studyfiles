# -*- coding: utf-8 -*-
class University < ActiveRecord::Base

  validates :abbreviation, :presence => true
  validates :name,         :presence => true, :uniqueness => true
  validates :city,         :presence => true

  has_and_belongs_to_many :subjects, :uniq => true

  has_many :sections, :through => :subjects
  has_many :folders
  has_many :documents
  has_attached_file :logo, :styles => {:full => "130x130", :thumb => "60x60>", :icon => "32x32" }

  has_many :users

  has_many :user_universities, :dependent => :destroy
  has_many :users, :through => :user_universities, :uniq => true

  define_index do
    indexes [name, abbreviation], :as => :name
    indexes city
    indexes subjects.name, :as => :subject_name
    indexes folders.name, :as => :folder_name
    has rating, available
  end

  scope :availables, where(:available => true)

  # University is available if it has documents or subjects or folder
  # This check should be run before sphinx index
  def recheck_available
    update_attribute(:available, true) if
      documents.present? || subjects.present? || folders.present?
  end

  def self.top_universities(_limit=10)
    order('rating DESC').availables.first(_limit)
  end

  def quick_rating
    documents.map {|d| d.quick_rating }.sum
  end

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
  # def raiting
  #   Document.in_path(self.id.to_s).sum(:raiting)
  # end

  # Reculculate rating.
  # TODO: Create cron task to reculculate ratings for all
  def rating!
    update_attribute(:rating, documents.sum(:rating))
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

    self.update_attribute(:rating, new_rating)
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

  # Update user univeristy rank by univeristy
  def user_rank!
    r = 1
    users.order('rating DESC').each do |u|
      user_universities.find_by_user_id(u.id).update_attribute(:rank, r)
      r += 1
    end
  end

  class << self
    def rating!
      all.each do |u|
        u.recheck_available
        u.rating!
        u.user_rank!
      end
    end
  end
end
