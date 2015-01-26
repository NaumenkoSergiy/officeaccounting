class AddRoleToUserCompanies < ActiveRecord::Migration
  def change
    add_column :user_companies, :role, :string
    remove_column :users, :role
  end
end
