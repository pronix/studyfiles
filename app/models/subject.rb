class Subject < ActiveRecord::Base

  validates :name,         :presence => true
  #validates :section_id,   :presence => true

  belongs_to :section, :class_name => "Subject", :foreign_key => "section_id"
  has_many :subjects, :foreign_key => "section_id"

  has_many :subject_folders
  has_many :folders, :through => :subject_folders

  has_many :university_subjects
  has_many :universities, :through => :university_subjects

  has_many :subject_documents
  has_many :documents, :through => :subject_documents

  scope :sectionized, where(:section_id => nil)

  define_index do
    indexes name
    indexes abbreviation
    indexes universities.name, :as => :university_name
  end

end
