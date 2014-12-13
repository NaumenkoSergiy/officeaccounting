class Registration < ActiveRecord::Base
  validates :form_of_incorporation,
            :edrpou,
            :nace_codes,
            :koatuu,
            :risk_class,
            :state_registration_date,
            :registration_number,
            :registered_by,
            :date_registered_in_revenue_commissioners,
            :number_registered_in_revenue_commissioners,
            :registered_in_pension_fund,
            :code_registered_in_pension_fund,
            :tax_system,
            presence: true
  validates_numericality_of :edrpou,
                            :koatuu,
                            :risk_class,
                            :number_registered_in_revenue_commissioners,
                            :code_registered_in_pension_fund

  belongs_to :company
end
