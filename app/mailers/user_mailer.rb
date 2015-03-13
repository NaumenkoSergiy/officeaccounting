# encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: 'activebooks.notification@gmail.com'

  def welcome_email(user)
    @user = user
    @url =  users_confirm_registration_url(token: user.activate_token)
    mail(to: @user.email, subject: 'Welcome to Active Books')
  end

  def host
    options = ActionMailer::Base.default_url_options
    "http://#{options[:host]}"
  end

  def password_reset(user)
    @user = user
    mail(to: user.email, subject: 'Відновлення паролю Active-books')
  end

  def create_delegate(user, company)
    @user = user
    user.generate_token(:password_reset_token)
    user.save!
    @company = company
    @url = "#{host}/password_resets/#{user.password_reset_token}/edit"
    mail(to: user.email, subject: 'Запрошення на делегування компанією').deliver!
  end

  def create_delegate_existing_user(user, company)
    @company = company.full_name
    @user = user
    @url = "#{host}#{setting_path(company)}"
    mail(to: user.email, subject: 'Запрошення на делегування компанією').deliver!
  end
end
