class AddNameToGuideUnits < ActiveRecord::Migration
  def change
    create_table :guide_units do |t|
      t.string  :name
      t.integer :user_id
      t.timestamps
    end
  end
end
