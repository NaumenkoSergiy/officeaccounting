class AddDeletedAtToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :deleted_at, :datetime
    add_index :contracts, :deleted_at
  end
end
