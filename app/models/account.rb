class Account < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :company
  belongs_to :bank
  has_many :money_registers
  has_many :payment_orders

  validates :name, presence: true
  validates_numericality_of :number

  ACCOUNT = {
    'Поточний рахунок' => :current,
    'Вкладний (депозитний) рахунок' => :deposit,
    'Поточний рахунок типу «Н»' => :current_n,
    'Поточний рахунок типу «П»' => :current_p,
    'Рахунок іноземного представництва' => :foreign_missions,
    'Інвестиційний рахунок нерезидента-інвестора' => :IANRI,
    'Рахунок виборчого фонду' => :electoral_fund,
    'Поточний рахунок УЄФА' => :UEFA
  }

  scope :acconts_on_type, -> (currency) {
    currency == 'UAH' ? where(currency: currency) : where.not(currency: 'UAH')
  }
end
