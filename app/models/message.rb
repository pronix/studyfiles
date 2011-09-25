class Message < ActiveRecord::Base
  belongs_to :user

  validates :text, :presence => true

  def my_message?(user)
    if self.user_id == user.id
      return true
    else
      return false
    end
  end
end
