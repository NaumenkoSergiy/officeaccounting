class AddDeletedAtToGuideUnits < ActiveRecord::Migration
  def change
    add_column :guide_units, :deleted_at, :datetime
    add_index :guide_units, :deleted_at
  end
end
