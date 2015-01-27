class DelegateService < BaseService

  def create_delegate data
    existing_user = User.find_by_email data[:email]
    company = Company.find(data[:company_id])

    if existing_user.nil?
      user = User.new(parse_for_create data)
      if user.save
        user.user_companies.create(company: company, role: data[:role])
        UserMailer.create_delegate(user, company.full_name).deliver!
      else
        { error: 'Введений невалідний Email' }
      end
    else
      if is_user_delegate_to_company?(data, existing_user)
        existing_user.user_companies.create(company: company, role: data[:role])
        UserMailer.create_delegate_existing_user(existing_user, company).deliver!
      else
        { error: 'Даний користувач вже добавлений на делегування цієї компанії ви не можете додати його ще раз!' }
      end
    end
  end

  private

  def parse_for_create data
    {
      email: data[:email],
      password: 'empty_password',
      confirm_password: 'empty_password',
      activate_token: nil,
      password_reset_sent_at: Time.zone.now
    }
  end

  def is_user_delegate_to_company?(data, user)
    UserCompany.user_permission(data[:company_id], user.id).nil?
  end
end
