class Counterparty < ActiveRecord::Base
  has_many :registers
  belongs_to :user

  validates :name, presence: true
  validates :start_date, presence: true
end
