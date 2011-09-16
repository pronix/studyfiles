class SubjectDocument < ActiveRecord::Base
  belongs_to :subjects
  belongs_to :documents
end
