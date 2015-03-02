class SessionService < BaseService
  def create_session data
    user = User.find_by(email: data[:email])
    if user && !user.activated?
      {error: 'Акаунт не активований! Перегляньте електронну пошту і перейдіть за посиланню для активації акаунта!'}
    elsif user && user.authenticate(data[:password])
      @session[:user_id] = user.id
      {success: true}
    else
      {error: 'Введені неправильні дані'}
    end
  end
end
