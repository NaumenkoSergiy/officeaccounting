class AddDeletedAtToAccountingAccounts < ActiveRecord::Migration
  def change
    add_column :accounting_accounts, :deleted_at, :datetime
    add_index :accounting_accounts, :deleted_at
  end
end
