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
            :tax_system,
            presence: true
  validates_numericality_of :edrpou,
                            :risk_class,
                            :number_registered_in_revenue_commissioners,
                            :registration_number,
                            :code_registered_in_pension_fund, allow_blank: true
  belongs_to :company

  after_create { company.set_official }

  validate :validate_date

  def validate_date
    unless registered_in_pension_fund.is_a?(Date) || registered_in_pension_fund.nil?
      errors.add(:registered_in_pension_fund, 'must be a valid date')
    end
  end
end
