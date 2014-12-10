module Settings
  class RegistrationsController < ApplicationController
    before_filter :redirect_to_new_session

    def new
      redirect_to new_settings_official_path if !current_user.companies.empty? &&
                                                current_user.companies.last.registration &&
                                                current_user.companies.last.officials.empty?

      @incorporation_forms = get_incorporation_forms
    end

    def create
      registration = current_user.companies.last.create_registration registration_params
      if registration.valid? && registration.save
        redirect_to new_settings_official_path
      else
        render json: false
      end
    end

    private

    def registration_params
      params.permit(:form_of_incorporation,
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
                    )
    end

    def get_incorporation_forms
      IncorporationForm.all
                       .sort_by{|f| f.name}
                       .collect do |f|
                         [ "#{f.number} #{f.name}", "#{f.number} #{f.name}" ]
                       end
    end
  end
end
