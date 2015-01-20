class AddCredit < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.string  :name
      t.string  :credit_type
      t.string  :account_number
      t.integer :bank_id
      t.integer :company_id
    end
  end
end
