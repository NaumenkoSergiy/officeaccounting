class CreateIncorporationForm < ActiveRecord::Migration
  def change
    create_table :incorporation_forms do |t|
    	t.integer :number
      t.string  :name
    end
  end
end
