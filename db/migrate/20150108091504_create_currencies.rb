class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.integer :company_id

      t.timestamps
    end
  end
end
