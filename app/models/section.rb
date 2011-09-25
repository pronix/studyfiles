class Section < ActiveRecord::Base
  has_many :subjects

  validates :name, :presence => true
end
