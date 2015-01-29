class AddCompanyIdToCounterparties < ActiveRecord::Migration
  def change
    add_column :counterparties, :company_id, :integer
    remove_column :counterparties, :user_id
  end
end
