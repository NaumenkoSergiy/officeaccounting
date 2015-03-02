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

  delegate :name, to: :article, prefix: true
  delegate :name, to: :counterparty_including_deleted, prefix: true
  delegate :name, to: :account_including_deleted, prefix: true
  delegate :number, to: :contract_including_deleted, prefix: true

  DOCUMENT_TYPE_COST = [:payment_pr, :refund_b, :payments_l, :payments_c , :calculation, :payments_a, :calculation_t, :write_offs]
  DOCUMENT_TYPE_INCOME = [:payment_fb, :refund_s, :osrhoene_l, :other_revenues, :return_s]

  scope :group_by_month, -> {
    select("month(date) as month,
      sum(case when money_registers.type_money = 'income' then total else 0 end) as income, '#04D215' as color1,
      date as month,
      sum(case when money_registers.type_money = 'costs' then total else 0 end) as costs, '#FF0F00' as color2"
    ).group("month(date)").sort_by(&:month)
  }
end
