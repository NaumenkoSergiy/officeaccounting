class Ability
  include CanCan::Ability
  
  def initialize(current_user, params)
    if UserCompany.user_permission(params[:id], current_user.id).role  == 'edit'
      can :manage, :all
    else
      can :read, :all
    end
  end
end
