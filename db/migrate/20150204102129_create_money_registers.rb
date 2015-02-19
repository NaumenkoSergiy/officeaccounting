class CreateMoneyRegisters < ActiveRecord::Migration
  def change
    create_table :money_registers do |t|
      t.date :date
      t.string :type_document
      t.integer :counterparty_id
      t.integer :contract_id
      t.integer :account_id
      t.float :total
      t.integer :article_id
      t.integer :company_id
      t.string :type_money

      t.timestamps
    end
  end
end
