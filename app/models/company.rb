class Company < ActiveRecord::Base
  validates :full_name,
            :short_name,
            :latin_name,
            :juridical_address,
            :numbering_format,
            presence: true

  has_many :user_companies
  has_many :users, through: :user_companies
  has_one  :registration
  has_many :officials
  has_one  :bank_account
  has_one  :bank, through: :bank_account
  has_many :currencies
  has_many :credits
  has_many :accounts
  has_many :cashiers
  has_many :counterparties
  has_many :contracts
  has_many :money_registers
  has_many :payment_orders
  has_many :orders
  has_many :currency_transactions
  has_many :main_tools
  has_many :nomenclatures
  has_many :departments
  has_many :positions
  has_many :employees
  has_many :products

  delegate :name, to: :bank, prefix: true
  delegate :account, :mfo, to: :bank_account, prefix: true

  after_create { set_registration }
  after_initialize :set_state # state initialize not works with rails 4.2

  scope :non_current_user, lambda { |id|
    company_ids = UserCompany.user_companies(id).pluck(:company_id)
    where('id not in (?)', company_ids.compact)
  }

  state_machine :state, initial: :step1 do
    event :set_registration do
      transition step1: :step2
    end

    event :set_official do
      transition step2: :step3
    end

    event :set_bank_account do
      transition step3_1: :step4
      transition step3: :step3_1
    end

    event :complite do
      transition step3_1: :complite
      transition step4: :complite
    end
  end

  def full_short_name
    "#{full_name} (#{short_name})"
  end

  def current_company(user_id)
    user_companies.where(user_id: user_id, company_id: id)
                  .first
                  .current_company
  end

  private

  def set_state
    self.state ||= :step1
  end
end
