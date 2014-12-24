class UsersController < ApplicationController
  before_action :define_user_service

  def new
    redirect_to root_path if session[:user_id]
  end

  def create
    user = @user_service.create_user params
    unless user[:error]
      redirect_to new_session_path,
                  flash: { :notice => "На вашу електронну адресу відправленений лист з активацією." }
    else
      redirect_to new_user_path, flash: { error: user[:error] }
    end
  end

  def confirm_registration
    user = User.find_by_activate_token(params[:token])
    user.activate!
    redirect_to new_session_path, flash: { :notice => "Аккаунт активований" }
  end

  def create_delegate
    user = User.new(delegate_params)
    company = Company.find(params[:company_id])
    
    if user.save
      user.user_companies.create(company: company)
      UserMailer.create_delegate(user, company.full_name).deliver!
    else
    end
    redirect_to root_path
  end

  private

  def delegate_params
    {
      email: params[:email],
      password: 'empty_password',
      confirm_password: 'empty_password',
      activate_token: nil,
      password_reset_sent_at: Time.zone.now
    }
  end

  def define_user_service
    @user_service ||= UserService.new session
  end
end
