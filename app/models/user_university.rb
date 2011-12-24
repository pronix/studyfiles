class UserUniversity < ActiveRecord::Base
  belongs_to :user
  belongs_to :university

  def in_top?
    return false unless rank.present?
    true if rank >= 1 and rank <= 3
  end
end
