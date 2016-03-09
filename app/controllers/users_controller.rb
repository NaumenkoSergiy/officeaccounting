class UsersController < ApplicationController
  before_action :define_user_service

  def new
    redirect_to root_path if session[:user_id]
  end

  def create
    user = @user_service.create_user params
    if user[:error]
      redirect_to new_user_path, flash: { error: user[:error] }
    else
      redirect_to new_session_path, notice: I18n.t('session.notific_mail')
    end
  end

  def confirm_registration
    user = User.find_by_activate_token(params[:token])
    if user
      user.activate!
      redirect_to new_session_path, notice: I18n.t('session.account_act')
    else
      redirect_to :root, notice: I18n.t('session.error_registration')
    end
  end

  def recipients
    users = []
    users = current_company.users.by_email params[:q] if current_company
    render json: { data: users }
  end

  private

  def define_user_service
    @user_service ||= UserService.new session
  end
end
