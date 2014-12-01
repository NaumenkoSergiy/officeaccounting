class BankAccount < ActiveRecord::Base
  validates :account, :mfo, :bank, presence: true

  belongs_to :company
end
