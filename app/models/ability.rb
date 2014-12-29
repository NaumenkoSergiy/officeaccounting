class Ability
  include CanCan::Ability
  
  def initialize(user)
    can :manage, :all if user.role == "Редагування"
    can :read, :all if user.role == "Перегляд"
  end
end
