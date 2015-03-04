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
    redirect_to new_session_path
  end

  def set_language
    I18n.locale = params[:locale]
    url_hash = Rails.application.routes.recognize_path URI(request.referer).path
    url_hash[:locale] = params[:locale]
    redirect_to url_hash
  end

  private

  def define_session_service
    @session_service ||= SessionService.new session
  end
end
