class CurrencyTransaction < ActiveRecord::Base
  belongs_to :company
  belongs_to :order

  validates :date, :order_id, :total_pf, presence: true

  delegate :currency, to: :order, prefix: true
  delegate :total, to: :order, prefix: true
  delegate :rate, to: :order, prefix: true
  delegate :commission, to: :order, prefix: true
  delegate :total_grn, to: :order, prefix: true
  delegate :grn_account_name, to: :order
  delegate :foreign_currency_account_name, to: :order

  scope :by_type, -> (type) { where('type = ?', type) }
end
