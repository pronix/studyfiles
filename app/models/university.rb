class University < ActiveRecord::Base

  validates :abbreviation, :presence => true
  validates :name,         :presence => true
  validates :city,         :presence => true

  has_many :university_subjects
  has_many :subjects, :through => :university_subjects
  has_many :sections, :through => :subjects
  has_many :user_universities
  has_many :users,    :through => :user_universities

  has_attached_file :logo, :styles => {:thumb => "100x100>" }

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

end