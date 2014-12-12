class CreateRegisters < ActiveRecord::Migration
  def change
    create_table :registers do |t|
      t.date :date
      t.integer :counterparty_id
      t.string :operations
      t.integer :value
      t.boolean :holding
      t.text :notes

      t.timestamps
    end
  end
end
