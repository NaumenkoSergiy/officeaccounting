class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to root_url, :notice => I18n.t('session.reset_pass_notific')
    else
      redirect_to root_url, :notice => I18n.t('session.not_found_account_notific')
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])

    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => I18n.t('session.time_out_reset_pass')
    elsif @user.update_attributes(password_resets_params)
      redirect_to root_url, :notice => I18n.t('session.change_pass_notific')
    else
      render :edit
    end
  end

  private

  def password_resets_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end

