class UserCompany < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  scope :user_companies, -> (user_id) {
    where(user_id: user_id)
  }

  scope :users_for, -> (company_id, current_user) {
    where(company_id: company_id).where.not(user_id: current_user)
  }

  scope :user_permission, -> (company_id, current_user_id) {
    find_by(company_id: company_id, user_id: current_user_id)
  }

  after_create :check_current_company

  def update_current value
    update_attribute(:current_company, value)
  end

  def check_current_company
    update_current(true) unless user.current_company
  end
end
