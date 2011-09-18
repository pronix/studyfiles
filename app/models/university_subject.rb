class UniversitySubject < ActiveRecord::Base
  belongs_to :university
  belongs_to :subject
end
