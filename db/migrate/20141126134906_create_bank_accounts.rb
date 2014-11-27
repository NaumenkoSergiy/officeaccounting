class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.integer :company_id
      t.integer :account
      t.text :bank
      t.integer :mfo
    end
  end
end
