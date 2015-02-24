class Ability
  include CanCan::Ability
  
  def initialize(current_user, params)
    if current_user.user_companies.for_company(current_user.current_company.id).first.role == "edit"
      can :manage, :all
    else
      can :read, :all
    end
  end
end
