class SubjectFolder < ActiveRecord::Base
  belongs_to :subject
  belongs_to :folder
end
