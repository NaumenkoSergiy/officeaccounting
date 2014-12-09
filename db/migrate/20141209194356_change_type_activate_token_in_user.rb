class ChangeTypeActivateTokenInUser < ActiveRecord::Migration
  def change
    change_column :users, :activate_token, :string, default: nil
  end
end
