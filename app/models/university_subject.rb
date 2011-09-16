class UniversitySubject < ActiveRecord::Base
  belongs_to :universities
  belongs_to :subjects
end
