class PaymentOrder < ActiveRecord::Base
  belongs_to :invoice_form
  belongs_to :account
  belongs_to :counterparty
  belongs_to :company
  belongs_to :article

  validates :date, :account_id, :counterparty, :total, :article, presence: true

  delegate :name, to: :article, prefix: true
  delegate :name, to: :counterparty, prefix: true
  delegate :name, to: :account, prefix: true

  scope :by_type, -> (type_order) {
    where('type_order = ?', type_order)
  }
end
