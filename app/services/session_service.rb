class SessionService < BaseService
  def create_session data
    user = User.find_by(email: data[:email], password: data[:password])
    if user && !user.activated?
      {error: 'Акаунт не активований! Перегляньте електронну пошту і перейдіть за посиланню для активації акаунта!'}
    elsif user
      @session[:user_id] = user.id
      {success: true}
    else
      {error: 'Введені неправильні дані'}
    end
  end

  def change_current_company old_current_company, new_current_company
    old_current_company.update_current(false) if old_current_company
    new_current_company.update_current(true)
  end
end
