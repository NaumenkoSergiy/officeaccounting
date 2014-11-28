class Registration < ActiveRecord::Base
  validates :form_of_incorporation,
            :edrpou,
            :nace_codes,
            :koatuu,
            :risk_class,
            :tin,
            :state_registration_date,
            :registration_number,
            :registered_by,
            :date_registered_in_revenue_commissioners,
            :number_registered_in_revenue_commissioners,
            :registered_in_pension_fund,
            :code_registered_in_pension_fund,
            :tax_system,
            presence: true

  belongs_to :company
end
