class UsersController < ApplicationController
  before_action :define_user_service

  def new; end

  def create
    if @user_service.create_user params
      send_confirmation_email
      redirect_to new_session_path,
                  flash: { :notice => "На вашу електронну пошту відправленений лист з активацією." }
    else
      redirect_to new_user_path, flash: { error: 'Введені неправильні дані' }
    end
  end

  def confirm_registration
    user = User.find_by(email: params[:email], password: params[:password])
    user.update_attributes(profile_confirmed: true)
    redirect_to new_session_path(email: params[:email], password: params[:password]),
                flash: { :notice => "Аккаунт активований" }
  end

  private

  def define_user_service
    @user_service ||= UserService.new session
  end

  def send_confirmation_email
    UserMailer.welcome_email(params).deliver!
  end
end
