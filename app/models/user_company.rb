class UserCompany < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  scope :user_companies, -> (user_id) {
    where(user_id: user_id)
  }

  def update_current value
    update_attribute(:current_company, value)
  end
end
