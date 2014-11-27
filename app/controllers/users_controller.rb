class UsersController < ApplicationController
  before_action :define_user_service

  def new; end

  def create
    if @user_service.create_user params
      redirect_to new_session_path(email: params[:email], password: params[:password])
    else
      redirect_to new_user_path
    end
  end

  private

  def define_user_service
    @user_service ||= UserService.new session
  end
end
