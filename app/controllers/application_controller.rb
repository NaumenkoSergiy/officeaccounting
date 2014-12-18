class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token

  helper_method :current_user, :is_admin?

  def current_user
    session[:user_id] ? User.find(session[:user_id]) : nil
  end

  def has_company?
    if current_user && current_user.companies.empty?
      redirect_to new_settings_company_path
    end
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
end
