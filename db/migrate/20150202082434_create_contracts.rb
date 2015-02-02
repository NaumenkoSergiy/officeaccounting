class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.date :date
      t.string :number
      t.string :contract_type
      t.date :validity
      t.integer :counterparty_id

      t.timestamps
    end
  end
end
