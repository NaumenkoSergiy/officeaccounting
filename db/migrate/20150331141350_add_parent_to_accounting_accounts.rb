class AddParentToAccountingAccounts < ActiveRecord::Migration
  def change
    add_column :accounting_accounts, :parent_id, :integer
    add_column :accounting_accounts, :directory, :boolean
    change_column_default :accounting_accounts, :directory, false
  end
end
