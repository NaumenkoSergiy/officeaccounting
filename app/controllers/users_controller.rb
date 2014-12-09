class UsersController < ApplicationController
  before_action :define_user_service

  def new; end

  def create
    user = @user_service.create_user params
    if user
      send_confirmation_email user
      redirect_to new_session_path,
                  flash: { :notice => "На вашу електронну пошту відправленений лист з активацією." }
    else
      redirect_to new_user_path, flash: { error: 'Введені неправильні дані' }
    end
  end

  def confirm_registration
    user = User.find_by_activate_token(params[:token])
    user.update_attributes(activate_token: nil)
    redirect_to new_session_path, flash: { :notice => "Аккаунт активований" }
  end

  private

  def define_user_service
    @user_service ||= UserService.new session
  end

  def send_confirmation_email user
    user.generate_token(:activate_token)
    UserMailer.welcome_email(user).deliver!
  end
end
