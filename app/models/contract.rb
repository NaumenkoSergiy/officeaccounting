class Contract < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company
  belongs_to :counterparty
  has_many :money_registers

  validates :counterparty, :date, :validity, :number, presence: true

  CONTRACT_TYPE = [:product, :service]
end
