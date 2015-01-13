class Official < ActiveRecord::Base
  validates :official_type, :name, :tin, :phone, :email, presence: true

  belongs_to :company

  after_create { company.set_bank_account } if try(:company)
end
