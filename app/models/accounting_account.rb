class AccountingAccount < ActiveRecord::Base
  validates :name, :account_number, presence:true

  GROUPS = [:assets, :capital, :obligations, :income_a, :costs_a]
end
