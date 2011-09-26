class University < ActiveRecord::Base

  validates :abbreviation, :presence => true
  validates :name,         :presence => true
  validates :city,         :presence => true

  has_many :university_subjects
  has_many :subjects, :through => :university_subjects
  has_many :sections, :through => :subjects

  #Подсчет рейтинга университета
  def raiting
    Document.where(["path = ? or path ~ ?", self.id.to_s, self.id.to_s + ".*" ]).sum(:raiting)
  end

  #Количество файлов
  def files_count
    Document.where(["path = ? or path ~ ?", self.id, self.id + ".*" ]).count
  end

  #сумарный размер файлов
  #TODO: в хелпере перевод в мегабайты
  def files_size
    Document.where(["path = ? or path ~ ?", self.id, self.id + ".*" ]).sum(:item_file_size)
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