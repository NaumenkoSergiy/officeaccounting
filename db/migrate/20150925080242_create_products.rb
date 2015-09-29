class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :number
      t.integer :amount
      t.float :price
      t.float :total
      t.date :date
      t.date :document_date
      t.boolean :conducted, default: false
      t.string :title
      t.string :document_type
      t.string :document_number
      t.string :currency
      t.references :guide_unit, index: true
      t.references :counterparty, index: true
      t.references :department, index: true
      t.references :company, index: true

      t.timestamps null: false
    end

    add_column :departments, :deleted_at, :datetime
    add_index :departments, :deleted_at
  end
end
