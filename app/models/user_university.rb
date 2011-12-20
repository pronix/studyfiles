class UserUniversity < ActiveRecord::Base
  belongs_to :user
  belongs_to :university

  def in_top?
    true if rating >= 1 and rating <= 3
  end
end
