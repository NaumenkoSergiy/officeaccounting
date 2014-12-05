class SessionsController < ApplicationController
  before_action :define_session_service

  def new; end

  def create
    @session_service.create_session params

    if current_user
      redirect_to root_path
    else
      redirect_to new_session_path, flash: { error: 'Введені неправильні креденшіали' }
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
