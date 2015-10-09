class ApplicationService

  def initialize; end

  def chat_params(user, company)
    current_user = user
    users = []
    online_users = []
    if company
      company.users.each do |company|
        users.push(company)
      end
    end
    if $redis
      $redis.keys.each do |key|
        online_users.push(key)
      end
    end
    return current_user, users, online_users
  end
end
