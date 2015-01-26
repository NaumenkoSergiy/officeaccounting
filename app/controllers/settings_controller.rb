class SettingsController < ApplicationController
  before_filter :redirect_to_new_session

  def index
    redirect_to new_session_path unless current_user
  end

  def show
    @company    = current_user.companies.find(params[:id])
    @bookkeeper = @company.officials.find_by(official_type: :bookeeper)
    @director   = @company.officials.find_by(official_type: :director)
    @incorporation_forms = get_incorporation_forms
    @search_users = UserCompany.users_for(params[:id], current_user.id)
    search_company_parent_user = UserCompany.find(params[:id])
    @company_parent_user = search_company_parent_user.user_id == current_user.id
  end

  def get_incorporation_forms
    IncorporationForm.all
                     .sort_by{|f| f.name}
                     .collect do |f|
                       {
                         value: "#{f.number} #{f.name}", 
                         text:  "#{f.number} #{f.name}"
                       }
                     end
  end
end
