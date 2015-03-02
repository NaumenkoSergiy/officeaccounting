class AddBankIdToBankAccounts < ActiveRecord::Migration
  def change
    add_column :bank_accounts, :bank_id, :integer
    remove_column :bank_accounts, :bank
  end
end
