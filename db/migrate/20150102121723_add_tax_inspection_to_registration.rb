class AddTaxInspectionToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :tax_inspection, :string
  end
end
