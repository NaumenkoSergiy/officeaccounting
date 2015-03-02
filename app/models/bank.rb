class Bank < ActiveRecord::Base
  has_many :credits
  has_one :account
  has_many :counterparties
  has_one :bank_account

  validates :name, :lawyer_adress, presence: true
  validates_numericality_of :code_edrpo, :mfo
end
