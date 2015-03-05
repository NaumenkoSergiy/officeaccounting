class Article < ActiveRecord::Base
  has_many :money_registers
  has_many :payment_orders

  validates :name, presence: true
end
