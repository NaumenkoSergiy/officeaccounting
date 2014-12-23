class CreateInvoiceForms < ActiveRecord::Migration
  def change
    create_table :invoice_forms do |t|
      t.integer :account_number
      t.string :name
      t.string :invoice_type
      t.string :subcount1
      t.string :subcount2
    end
  end
end
