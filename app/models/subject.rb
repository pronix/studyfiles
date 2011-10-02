class Subject < ActiveRecord::Base

  validates :abbreviation, :presence => true
  validates :name,         :presence => true
  validates :section_id,   :presence => true

  belongs_to :section
  has_many :subject_folders
  has_many :folders, :through => :subject_folders

  has_many :university_subjects
  has_many :universities, :through => :university_subjects

  has_many :subject_documents
  has_many :documents, :through => :subject_documents

end
