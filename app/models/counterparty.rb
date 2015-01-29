class Counterparty < ActiveRecord::Base
  belongs_to :company

  validates :name, presence: true
  validates :start_date, presence: true
end
