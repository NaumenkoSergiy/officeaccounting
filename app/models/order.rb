class Order < ActiveRecord::Base
  belongs_to :company
  belongs_to :bank
  belongs_to :grn_account, class_name: 'Account', foreign_key: 'account_grn_id'
  belongs_to :foreign_currency_account, class_name: 'Account', foreign_key: 'account_rate_id'
  has_many :curency_transaction

  delegate :name, to: :bank, prefix: true
  delegate :name, to: :grn_account, prefix: true
  delegate :name, to: :foreign_currency_account, prefix: true

  validates :date, :bank_id, :currency, :total, :total_grn, :rate, :account_grn_id, :type_order, :account_rate_id, presence: true

  scope :orders_by_type, lambda { |type_order|
    where('type_order = ?', type_order)
  }
end
