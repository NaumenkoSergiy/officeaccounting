class Counterparty < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company
  belongs_to :bank
  has_many :contracts
  has_many :money_registers

  validates :name, :title, :adress, presence: true
  validates_numericality_of :edrpo, :mfo, :account
end
