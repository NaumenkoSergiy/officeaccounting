class Ability
  include CanCan::Ability

  def initialize(current_user, _params)
    if current_user.user_companies.find_by(company: current_user.current_company).role == 'edit'
      can :manage, :all
    else
      can :read, :all
    end
  end
end
