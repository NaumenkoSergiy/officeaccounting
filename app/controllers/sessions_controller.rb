class SessionsController < ApplicationController
  before_action :define_session_service

  def new
    redirect_to root_path if session[:user_id]
  end

  def create
    session = @session_service.create_session params
    flash.now[:error] = session[:error] if session[:error]
  end

  def destroy
    session[:user_id] = nil
    cookies[:language] = I18n.default_locale
    redirect_to new_session_path
  end

  def set_language
    if params[:locale]
      cookies[:language] = params[:locale]
    end
    I18n.locale = cookies[:language]
    redirect_to root_path
  end

  private

  def define_session_service
    @session_service ||= SessionService.new session
  end
end
