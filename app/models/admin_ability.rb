class AdminAbility
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :boulet
      can :manage, Type
    end
  end
end
