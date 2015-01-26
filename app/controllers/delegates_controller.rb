class DelegatesController < ApplicationController
  before_filter :redirect_to_new_session, only: [:create]
  before_action :set_delegate, only: [:update, :destroy]

  def create
    existing_user = User.find_by_email params[:email]
    company = Company.find(params[:company_id])

    if existing_user.nil?
      user = User.new(delegate_params)
      if user.save
        user.user_companies.create(company: company, role: params[:role])
        UserMailer.create_delegate(user, company.full_name).deliver!
      else
        flash[:error] = 'Введений невалідний Email'
      end
    else
      existing_user.user_companies.create(company: company, role: params[:role])
      UserMailer.create_delegate_existing_user(existing_user, company).deliver!
    end

    @search_users = UserCompany.users_for(params[:company_id], current_user.id)
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @delegate_user.update(delegate_params)
        format.json { head :no_content }
      else
        format.json { render json: delegate_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @delegate_user.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def delegate_params
    if params[:page].nil?
      {
        email: params[:email],
        password: 'empty_password',
        confirm_password: 'empty_password',
        activate_token: nil,
        password_reset_sent_at: Time.zone.now
      }
    else
      params.require(:user_company).permit(:role)
    end
  end

  def set_delegate
    @delegate_user = UserCompany.user_permission(params[:company_id], params[:id])
  end
end
