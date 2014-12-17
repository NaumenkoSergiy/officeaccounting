class Counterparty < ActiveRecord::Base
  has_many :registers

  validates :name, presence: true
  validates :start_date, presence: true
end
