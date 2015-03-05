class PaymentOrder < ActiveRecord::Base
  belongs_to :invoice_form
  belongs_to :account
  belongs_to :counterparty
  belongs_to :company
  belongs_to :article

  validates :date, :invoice_form_id, :account_id, :counterparty_id, :total, :article_id, presence: true

  delegate :name, to: :article, prefix: true
  delegate :name, to: :counterparty, prefix: true
  delegate :name, to: :account, prefix: true
  delegate :account_number, to: :invoice_form, prefix: true
end
