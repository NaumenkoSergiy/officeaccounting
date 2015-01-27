class DelegatesController < ApplicationController
  before_filter :redirect_to_new_session, only: [:create]
  before_action :set_delegate, only: [:update, :destroy]
  before_action :define_session_service

  def create
    delegate = @delegate_service.create_delegate params
    flash.now[:error] = delegate[:error] if delegate[:error]
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
    params.require(:user_company).permit(:role)
  end

  def set_delegate
    @delegate_user = UserCompany.user_permission(params[:company_id], params[:id])
  end

  def define_session_service
    @delegate_service ||= DelegateService.new session
  end
end
