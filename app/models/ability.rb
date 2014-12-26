class Ability
  include CanCan::Ability
  
  def initialize(user)
    can :manage, :all if user.role == "read-write"
    can :read, :all if user.role == "read"
  end
end
