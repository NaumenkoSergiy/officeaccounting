class Contract < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company
  belongs_to :counterparty
  has_many :money_registers

  validates :date, :counterparty_id, :validity, :number, presence: true

  scope :contracts_for_conterparty, -> (id) {
    where(counterparty_id: id)
  }

  scope :contract_one_record, -> (id) {
    Contract.with_deleted.find(id).number
  }
  
  CONTRACT_TYPE = {
    :product_s => :product,
    :service_s => :service
  }
end
