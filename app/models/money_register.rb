class MoneyRegister < ActiveRecord::Base
  belongs_to :company
  belongs_to :counterparty
  belongs_to :article
  belongs_to :account, -> { with_deleted }
  belongs_to :contract

  validates :total, :type_document, :contract_id, :counterparty_id, presence: true

  delegate :name, to: :article, prefix: true
  delegate :name, to: :counterparty, prefix: true
  delegate :name, to: :account, prefix: true
  delegate :number, to: :contract, prefix: true

  DOCUMENT_TYPE_COST = [:payment_pr, :refund_b, :payments_l, :payments_c, :calculation, :payments_a, :calculation_t, :write_offs]
  DOCUMENT_TYPE_INCOME = [:payment_fb, :refund_s, :osrhoene_l, :other_revenues, :return_s]

  scope :by_type, -> (type) { where(type_money: type) }
  scope :by_month, -> (number) { where('date > ?', number.month.ago) }

  def self.ransackable_attributes(_auth_object = nil)
    %w(date type_document total type_money) + _ransackers.keys
  end
end
