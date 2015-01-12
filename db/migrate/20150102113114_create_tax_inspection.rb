class CreateTaxInspection < ActiveRecord::Migration
  def change
    create_table :tax_inspections do |t|
      t.string :name
    end
  end
end
