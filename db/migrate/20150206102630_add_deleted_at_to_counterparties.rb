class AddDeletedAtToCounterparties < ActiveRecord::Migration
  def change
    add_column :counterparties, :deleted_at, :datetime
    add_index :counterparties, :deleted_at
  end
end
