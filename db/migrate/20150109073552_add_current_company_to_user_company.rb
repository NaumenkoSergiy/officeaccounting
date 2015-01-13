class AddCurrentCompanyToUserCompany < ActiveRecord::Migration
  def change
    add_column :user_companies, :current_company, :boolean
  end
end
