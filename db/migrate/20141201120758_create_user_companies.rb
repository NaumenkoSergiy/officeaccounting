class CreateUserCompanies < ActiveRecord::Migration
  def change
    create_table :user_companies do |t|
      t.integer :company_id
      t.integer :user_id
    end
  end
end
