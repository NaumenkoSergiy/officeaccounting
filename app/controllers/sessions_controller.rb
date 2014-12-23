class SessionsController < ApplicationController
  before_action :define_session_service

  def new; end

  def create
    session = @session_service.create_session params
    flash[:error] = session[:error] if session[:error]
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  private

  def define_session_service
    @session_service ||= SessionService.new session
  end
end
