class AddUserIdToCounterparties < ActiveRecord::Migration
  def change
    add_column :counterparties, :user_id, :integer
  end
end
