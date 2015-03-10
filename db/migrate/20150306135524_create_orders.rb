class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :date
      t.integer  :bank_id
      t.string   :currency
      t.float    :total
      t.float    :total_grn
      t.float    :rate
      t.float    :commission
      t.integer  :account_grn_id
      t.integer  :account_rate_id
      t.integer  :company_id
      t.string   :type_order
      t.timestamps
    end
  end
end
