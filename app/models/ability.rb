class Ability
  include CanCan::Ability
  
  def initialize(user)
    can :manage, :all if user.role == 'edit'
    can :read, :all if user.role == 'view'
  end
end
