class Novelty < ActiveRecord::Base

  validates :text, :presence => true
  validates :title, :presence => true

end
