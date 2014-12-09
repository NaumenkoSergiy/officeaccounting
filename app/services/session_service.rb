class SessionService < BaseService
  def create_session data
    user = User.find_by(email: data[:email], password: data[:password])

    if user && !user[:activate_token]
      @session[:user_id] = user.id
    end
  end
end
