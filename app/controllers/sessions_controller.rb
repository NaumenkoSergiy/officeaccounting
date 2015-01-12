class SessionsController < ApplicationController
  before_action :define_session_service

  def new
    redirect_to root_path if session[:user_id]
  end

  def create
    session = @session_service.create_session params
    flash[:error] = session[:error] if session[:error]
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  def change_company
    company = current_user.user_companies.find_by(company_id: params[:company_id])
    old_company = current_user.user_companies.find_by(company_id: current_user.current_company.id) if current_user.current_company
    result = @session_service.change_current_company(old_company, company)
    render json: result
  end

  private

  def define_session_service
    @session_service ||= SessionService.new session
  end
end
