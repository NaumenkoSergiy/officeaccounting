class CreateCashiers < ActiveRecord::Migration
  def change
    create_table :cashiers do |t|
      t.string :name
      t.string :currency
      t.integer :company_id

      t.timestamps
    end
  end
end
