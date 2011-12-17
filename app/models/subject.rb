class Subject < ActiveRecord::Base

  validates :name,         :presence => true

  belongs_to :section, :class_name => "Subject", :foreign_key => "section_id"
  has_many :subjects, :foreign_key => "section_id"


  has_and_belongs_to_many :universities

  has_many :documents
  has_many :folders

  scope :sectionized, where(:section_id => nil)

  define_index do
    indexes name
    indexes abbreviation
    indexes universities.name, :as => :university_name
    has section_id
  end

end
