class SubjectDocument < ActiveRecord::Base

  belongs_to :subject
  belongs_to :document

end
