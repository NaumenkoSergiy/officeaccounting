class PasswordResetsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "На вашу електронну адресу відправленений лист з інструкцією по відновленню пароля."
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Час на відновлення пароля закінчився!"
    elsif @user.update_attributes(password_resets_params)
      redirect_to root_url, :notice => "Пароль був змінений успішно!"
    else
      render :edit
    end
  end
 
  private

  def password_resets_params
    params.require(:user).permit(:password, :confirm_password)
  end
end

