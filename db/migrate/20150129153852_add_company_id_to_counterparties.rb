class AddCompanyIdToCounterparties < ActiveRecord::Migration
  def change
    add_column :counterparties, :company_id, :integer
    add_column :counterparties, :title, :string
    add_column :counterparties, :resident, :boolean
    add_column :counterparties, :edrpo, :string
    add_column :counterparties, :adress, :string
    add_column :counterparties, :account, :string
    add_column :counterparties, :bank_id, :integer
    add_column :counterparties, :mfo, :integer
    remove_column :counterparties, :start_date
    remove_column :counterparties, :user_id
  end
end
