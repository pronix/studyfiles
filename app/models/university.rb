class University < ActiveRecord::Base
  has_many :university_subjects
  has_many :subjects, :through => :university_subjects
end
