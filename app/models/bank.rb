class Bank < ActiveRecord::Base
  has_many :credits
  has_one :account
  has_many :counterparties

  validates :name, :lawyer_adress, presence: true
  validates_numericality_of :code_edrpo, :mfo
end
