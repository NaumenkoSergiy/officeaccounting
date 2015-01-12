class UserCompany < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  scope :user_companies, -> (user_id) {
    where(user_id: user_id)
  }
end
