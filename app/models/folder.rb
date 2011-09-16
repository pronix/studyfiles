class Folder < ActiveRecord::Base
  belongs_to :users
  has_many :subject_folders
  has_many :subjects, :through => :subject_folders
end
