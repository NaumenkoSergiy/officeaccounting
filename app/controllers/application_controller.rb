class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    session[:user_id] ? User.find(session[:user_id]) : nil
  end

  def has_company?
    if current_user && current_user.companies.empty?
      redirect_to new_settings_company_path
    end
  end
end
