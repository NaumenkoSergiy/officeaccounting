class RenameProfileConfirmedInUser < ActiveRecord::Migration
  def change
    rename_column :users, :profile_confirmed, :activate_token
  end
end
