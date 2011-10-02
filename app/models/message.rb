class Message < ActiveRecord::Base
  belongs_to :user

  validates :text, :presence => true

  def my_message?(user)
    self.user_id == user.id
  end
end