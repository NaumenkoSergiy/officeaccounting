class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :company_id
      t.string :form_of_incorporation
      t.string :legal_form_code
      t.string :edrpou
      t.string :nace_codes
      t.integer :koatuu
      t.integer :risk_class
      t.integer :tin
      t.date :state_registration_date
      t.string :registration_number
      t.string :registered_by
      t.date :date_registered_in_revenue_commissioners
      t.string :number_registered_in_revenue_commissioners
      t.date :registered_in_pension_fund
      t.integer :code_registered_in_pension_fund
      t.string :tax_system
    end
  end
end
