class SessionsController < ApplicationController
  before_action :define_session_service

  def new
    if params[:id]
      user = User.find(params[:id])
      @email = user[:email]
      @password = user[:password]
    end
  end

  def create
    @session_service.create_session params

    if current_user
      if is_admin?
        redirect_to admin_root_path
      else
        redirect_to root_path
      end
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
