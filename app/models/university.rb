class University < ActiveRecord::Base

  validates :abbreviation, :presence => true
  validates :name,         :presence => true
  validates :city,         :presence => true

  has_many :university_subjects
  has_many :subjects, :through => :university_subjects

  #Подсчет рейтинга университета
  def raiting
    Document.where(["path = ? or path ~ ?", self.id.to_s, self.id.to_s + ".*" ]).sum(:raiting)
  end
end
