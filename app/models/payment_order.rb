class PaymentOrder < ActiveRecord::Base
  belongs_to :invoice_form
  belongs_to :account
  belongs_to :counterparty
  belongs_to :company
  belongs_to :article
  belongs_to :counterparty_including_deleted, class_name: 'Counterparty', foreign_key: 'counterparty_id', with_deleted: true
  belongs_to :account_including_deleted, class_name: 'Account', foreign_key: 'account_id', with_deleted: true

  validates :date, :account_id, :counterparty_id, :total, :article_id, presence: true

  delegate :name, to: :article, prefix: true
  delegate :name, to: :counterparty_including_deleted, prefix: true
  delegate :name, to: :account_including_deleted, prefix: true

  scope :by_type, -> (type_order) {
    where('type_order = ?', type_order)
  }
end
