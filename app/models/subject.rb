class Subject < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  belongs_to :section, :class_name => "Subject", :foreign_key => "section_id"

  has_many :subjects, :foreign_key => "section_id"
  has_many :documents
  has_many :folders

  has_and_belongs_to_many :universities, :uniq => true
  has_and_belongs_to_many :users, :uniq => true

  scope :sectionized, where(:section_id => nil)

  define_index do
    indexes :name
    indexes :abbreviation
    indexes universities.name, :as => :university_name
    has :section_id, :created_at
  end

end
