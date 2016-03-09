class SessionService < BaseService
  def create_session(data)
    user = User.find_by(email: data[:email])
    if user && !user.activated?
      { error: I18n.t('sesion.account_not_act') }
    elsif user && user.authenticate(data[:password])
      @session[:user_id] = user.id
      { success: true }
    else
      { error: I18n.t('validation.errors.invalid_data') }
    end
  end
end
