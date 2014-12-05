class AddConfirmationToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_confirmed, :boolean, default: false
  end
end
