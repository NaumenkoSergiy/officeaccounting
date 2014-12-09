class ChangeColumnsTypeForCompaniesTables < ActiveRecord::Migration
  def change
    change_column :registrations, :koatuu, :string
    change_column :registrations, :tin, :string
    change_column :registrations, :code_registered_in_pension_fund, :string
    change_column :officials, :tin, :string
    change_column :bank_accounts, :account, :string
    change_column :bank_accounts, :mfo, :string
  end
end
