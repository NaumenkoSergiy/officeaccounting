class BankAccount < ActiveRecord::Base
  validates :account, :mfo, :bank_id, presence: true

  belongs_to :company
  belongs_to :bank

  after_create { company.complite }
end
