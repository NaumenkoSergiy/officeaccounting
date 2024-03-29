class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  helper_method :current_user, :admin?, :application_present, :current_company
  before_action :set_locale
  before_action :define_app_service, :chat_params

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def redirect_to_new_session
    redirect_to new_session_path unless session[:user_id]
  end

  def current_admin_user
    redirect_to root_url unless admin?
    current_user
  end

  def admin?
    current_user.try(:is_admin)
  end

  def check_creating_company_step
    @company = current_user.last_company
    unless params[:back]
      redirect_path = step_paths
      state = @company.state.to_sym
      redirect_to redirect_path[state] unless match_controller?(redirect_path[state]) || @company
    end
  end

  def current_company
    @current_company ||= current_user.current_company
  end

  def application_present
    @present ||= ApplicationPresenter.new
  end

  def company?
    if current_user && current_user.companies.empty?
      redirect_to new_settings_company_path(back: true)
    end
  end

  def page_not_found
    respond_to do |format|
      format.html { render file: 'public/404.html', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end

  def verifier
    @verify ||= ActiveSupport::MessageVerifier.new(Rails.application.secrets.secret_key_base)
  end

  private

  def match_controller?(state)
    %r{/\/.{1,}\/.{1,}\//}.match(state).to_s == "/#{params[:locale]}/#{params['controller']}/"
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, params)
  end

  def set_locale
    I18n.locale = params[:locale] || session[:language] || I18n.default_locale
  end

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end

  def default_serializer_options
    { root: false }
  end

  def chat_params
    if current_user
      gon.current_user, gon.users, gon.online_users = @app_service.chat_params(current_user, current_company)
    end
  end

  def define_app_service
    @app_service ||= ApplicationService.new
  end

  def set_online
    Redis.current.set(current_user.id, nil, ex: 10 * 60) if current_user
  end

  def step_paths
    {
      step1:    new_settings_company_path,
      step2:    new_settings_registration_path,
      step3:    new_settings_official_path,
      step3_1:  new_settings_official_path(official_type: 'bookeeper'),
      step4:    new_settings_bank_account_path,
      complite: new_settings_company_path
    }
  end
end
