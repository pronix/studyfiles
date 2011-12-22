class UserUniversity < ActiveRecord::Base
  belongs_to :user
  belongs_to :university

  def in_top?
    return false unless rating.present?
    true if rating >= 1 and rating <= 3
  end
end
