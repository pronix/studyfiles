class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    end

    can :add_subject, University do |univer|
      user.universities.include? univer
    end

  end
end
