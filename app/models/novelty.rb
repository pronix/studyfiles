class Novelty < ActiveRecord::Base

  validates :text, :presence => true
  validates :title, :presence => true

  def on_main
    self.update_attributes(:main => true)
  end

  def from_main
    self.update_attributes(:main => false)
  end

end
