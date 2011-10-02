class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :document

  def positive?
    self.vote_type
  end

  def positiv
    self.vote_type = true
    self.save
  end
end
