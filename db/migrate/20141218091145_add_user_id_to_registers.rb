class AddUserIdToRegisters < ActiveRecord::Migration
  def change
    add_column :registers, :user_id, :integer
  end
end
