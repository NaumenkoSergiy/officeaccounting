class SessionService < BaseService
  def create_session data
    current_user = User.find_by(email: data[:email], password: data[:password])

    if current_user
      @session[:user_id] = current_user.id
    end
  end
end