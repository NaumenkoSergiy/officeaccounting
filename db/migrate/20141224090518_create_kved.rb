class CreateKved < ActiveRecord::Migration
  def change
    create_table :kveds do |t|
      t.string :section
      t.string :number
      t.string :name
    end
  end
end
