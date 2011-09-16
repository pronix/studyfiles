class SubjectFolder < ActiveRecord::Base
  belongs_to :subjects
  belongs_to :folders
end
