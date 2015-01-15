class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token

  helper_method :current_user, :is_admin?, :application_present

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:activate_token]) if cookies[:activate_token]
    session[:user_id] ? User.find(session[:user_id]) : nil
  end

  def redirect_to_new_session
    redirect_to new_session_path unless session[:user_id]
  end

  def current_admin_user
    redirect_to root_url unless is_admin?
    current_user
  end

  def is_admin?
    current_user.try(:is_admin)
  end

  def check_creating_company_step
    company = current_user.companies.last
    @company = (!company || company.complite?) ? Company.new : company

    unless params[:back]
      redirect_path = {
        step1:    new_settings_company_path,
        step2:    new_settings_registration_path,
        step3:    new_settings_official_path,
        step3_1:  new_settings_official_path(official_type: 'bookeeper'),
        step4:    new_settings_bank_account_path,
        complite: new_settings_company_path
      }

      state = @company.state.to_sym
      redirect_to redirect_path[state] unless redirect_path[state].match(/\/.{1,}\/.{1,}\//).to_s == "/#{params['controller']}/"
    end
  end

  def current_company
    @current_company ||= current_user.user_companies.where(current_company: true).first.company
  end

  def application_present
    @present ||= ApplicationPresenter.new
  end
end
