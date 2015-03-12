class CreateCurrencyTransactions < ActiveRecord::Migration
  def change
    create_table :currency_transactions do |t|
      t.datetime :date
      t.integer  :order_id
      t.float    :total_pf
      t.integer  :company_id
      t.string   :type
      t.timestamps
    end
  end
end
