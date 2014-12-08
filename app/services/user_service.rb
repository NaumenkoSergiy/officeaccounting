class UserService < BaseService
  def create_user data
    data = parse_for_create data
    user = User.new data
    if user.valid?
      user if user.save
    else
      false
    end
  end

  private

  def parse_for_create data
    {
      email: data[:email],
      password: data[:password],
      confirm_password: data[:confirm_password]
    }
  end
end