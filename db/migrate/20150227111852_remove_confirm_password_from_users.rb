class RemoveConfirmPasswordFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :confirm_password, :string
  end
end
