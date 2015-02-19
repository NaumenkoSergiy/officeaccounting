class MoneyRegister < ActiveRecord::Base
  belongs_to :company
  belongs_to :counterparty
  belongs_to :counterparty_including_deleted, class_name: 'Counterparty', foreign_key: 'counterparty_id', with_deleted: true
  belongs_to :article
  belongs_to :account
  belongs_to :account_including_deleted, class_name: 'Account', foreign_key: 'account_id', with_deleted: true
  belongs_to :contract
  belongs_to :contract_including_deleted, class_name: 'Contract', foreign_key: 'contract_id', with_deleted: true

  validates :total, :type_document, :contract_id, :counterparty_id, presence: true

  DOCUMENT_TYPE_COST = [:payment_pr, :refund_b, :payments_l, :payments_c , :calculation, :payments_a, :calculation_t, :write_offs]
  DOCUMENT_TYPE_INCOME = [:payment_fb, :refund_s, :osrhoene_l, :other_revenues, :return_s]
end
