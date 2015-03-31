class Bank < ActiveRecord::Base
  has_many :credits
  has_many :orders
  has_one :account
  has_many :counterparties
  has_one :bank_account

  validates :name, :lawyer_adress, presence: true
  validates_numericality_of :code_edrpo, :mfo

  def assigned?
    [credits, orders, account, counterparties, bank_account].any? {|a| a.present?}
  end
end
