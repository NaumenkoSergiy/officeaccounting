class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :account_type
      t.integer :number
      t.string :currency
      t.integer :bank_id
      t.integer :company_id

      t.timestamps
    end
  end
end
