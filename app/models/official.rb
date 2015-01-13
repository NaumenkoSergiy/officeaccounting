class Official < ActiveRecord::Base
  validates :official_type, :name, :tin, :phone, :email, presence: true

  belongs_to :company

  after_create :set_bank_account

  def set_bank_account
    company.set_bank_account if company
  end
end
