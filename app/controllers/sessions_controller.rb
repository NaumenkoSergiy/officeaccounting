class SessionsController < ApplicationController
  before_action :define_session_service

  def new
    redirect_to root_path if session[:user_id] != nil
  end

  def create
    @session_service.create_session params

    unless current_user
      flash[:error] = 'Введені невірні креденшіали'
    end
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
