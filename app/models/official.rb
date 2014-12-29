class Official < ActiveRecord::Base
  validates :official_type, :name, :tin, :phone, :email, presence: true
  validates_numericality_of :tin
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  belongs_to :company

  after_create { company.set_bank_account }
end
