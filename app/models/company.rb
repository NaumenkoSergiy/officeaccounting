class Company < ActiveRecord::Base
  belongs_to :user

  has_one :registration
  has_many :officials
  has_one :bank_account
end
