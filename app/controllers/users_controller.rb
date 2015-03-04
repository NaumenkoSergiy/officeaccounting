class UsersController < ApplicationController
  before_action :define_user_service

  def new
    redirect_to root_path if session[:user_id]
  end

  def create
    user = @user_service.create_user params
    unless user[:error]
      redirect_to new_session_path,
                  flash: { :notice => I18n.t('session.notific_mail') }
    else
      redirect_to new_user_path, flash: { error: user[:error] }
    end
  end

  def confirm_registration
    user = User.find_by_activate_token(params[:token])
    user.activate!
    redirect_to new_session_path, flash: { :notice => I18n.t('session.account_act') }
  end

  private

  def define_user_service
    @user_service ||= UserService.new session
  end
end
