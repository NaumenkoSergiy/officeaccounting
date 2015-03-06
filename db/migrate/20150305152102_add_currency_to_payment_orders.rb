class AddCurrencyToPaymentOrders < ActiveRecord::Migration
  def change
    add_column :payment_orders, :currency, :string
    remove_column :payment_orders, :invoice_form_id
  end
end
