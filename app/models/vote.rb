class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :document

  after_save :update_rating

  def positive?
    self.vote_type
  end

  def update_rating
    if Rails.env.production?
    else
      update_rating!
    end
  end

  def update_rating!
    return unless grade.present?
    vote = 0
    vote = vote_type ? vote + grade : vote - grade
    document.update_attribute(:rating, document.rating + vote)
    if document.folder.present?
      document.folder.update_attribute(:rating, document.folder.rating + vote)
      document.folder.ancestors.each {|p| p.update_attribute(:rating, p.rating + vote)}
    end
    if document.university.present?
      document.university.update_attribute(:rating, document.university.rating + vote)
    end
    if document.user.present?
      document.user.update_attribute(:rating, document.user.rating + vote)
    end
  end

end
