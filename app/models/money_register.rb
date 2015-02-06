class MoneyRegister < ActiveRecord::Base
  belongs_to :company
  belongs_to :counterparty
  belongs_to :article
  belongs_to :account
  belongs_to :contract

  validates :total, :type_document, :contract_id, :counterparty_id, presence: true

  DOCUMENT_TYPE = [
    :payment_pr,
    :refund_b,
    :payments_l,
    :payments_c ,
    :calculation,
    :payments_a,
    :calculation_t,
    :write_offs
  ]
end
