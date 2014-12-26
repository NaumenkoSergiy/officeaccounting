class UserService < BaseService
  def create_user data
    if is_user_not_existing data[:email]
      data = parse_for_create data
      user = User.new data
      if user.valid?
        user if user.save
      else
        {error: 'Введені неправильні дані'}
      end
    else
      {error: 'Користувач існує будь ласка скористуйтеся відновленням паролю!'}
    end
  end

  private

  def parse_for_create data
    {
      email: data[:email],
      password: data[:password],
      confirm_password: data[:confirm_password],
      activate_token: SecureRandom.hex,
      role: data[:role]
    }
  end

  def is_user_not_existing email
    User.where(email: email).empty?
  end
end
