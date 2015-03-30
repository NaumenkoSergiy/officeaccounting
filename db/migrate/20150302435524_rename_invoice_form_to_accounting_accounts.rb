class RenameInvoiceFormToAccountingAccounts < ActiveRecord::Migration
  def change
    rename_table :invoice_forms, :accounting_accounts
    add_column :accounting_accounts, :ap, :string
    add_column :accounting_accounts, :subcount3, :string
  end
end
