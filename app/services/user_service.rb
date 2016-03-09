class UserService < BaseService
  def create_user(data)
    if user_not_existing?(data[:email])
      data = parse_for_create data
      user = User.new data
      user.save ? user : { error: I18n.t('validation.errors.invalid_data') }
    else
      { error: I18n.t('validation.errors.user_exists') }
    end
  end

  private

  def parse_for_create(data)
    {
      email: data[:email],
      password: data[:password],
      password_confirmation: data[:confirm_password],
      activate_token: SecureRandom.hex
    }
  end

  def user_not_existing?(email)
    User.where(email: email).empty?
  end
end
