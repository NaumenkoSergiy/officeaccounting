class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token

  helper_method :current_user, :is_admin?

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
    @company      = current_user.companies.last
    @company      = nil if @company && @company.complite?
    company       = new_settings_company_path
    registration  = new_settings_registration_path
    official      = new_settings_official_path
    redirect_path = nil
    if params[:back]
      @registration = @company.registration
    else
      if @company
        redirect_path = case params[:controller]
        when "settings/companies"
          registration if @company.registration.nil?
        when "settings/registrations"
          if @company.registration.present? &&
             @company.officials.empty? &&
             @company.bank_account.nil?
            official
          end
        when "settings/officials"
          registration if @company.registration.nil?
        end
        redirect_to redirect_path if redirect_path
      elsif params[:controller] != "settings/companies"
        redirect_to company
      else
        @company = Company.new
      end
    end
  end
end
