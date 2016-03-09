class ApplicationService
  def initialize; end

  def chat_params(current_user, company)
    current_user = current_user
    redis = Redis.current
    users = company&.users
    online_users = redis&.keys

    [current_user, users, online_users]
  end
end
