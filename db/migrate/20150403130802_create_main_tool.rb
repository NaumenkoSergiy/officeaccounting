class CreateMainTool < ActiveRecord::Migration
  def change
    create_table :main_tools do |t|
      t.string :title
      t.string :type
      t.string :serial_number
      t.string :passport_number
      t.date   :date
      t.string :brand
      t.integer :company_id
      t.timestamps
    end
  end
end
