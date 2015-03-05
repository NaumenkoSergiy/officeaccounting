class CreatePaymentOrders < ActiveRecord::Migration
  def change
    create_table :payment_orders do |t|
      t.datetime :date
      t.integer  :invoice_form_id
      t.integer  :account_id
      t.integer  :counterparty_id
      t.float    :total
      t.integer  :article_id
      t.string   :type_order
      t.integer  :company_id
      t.timestamps
    end
  end
end
