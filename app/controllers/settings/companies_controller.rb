module Settings
  class CompaniesController < ApplicationController
    before_filter :has_company?, only: [:new, :create]
    before_filter :redirect_to_new_session

    def new
      if current_user.companies.present? && current_user.companies.last.registration.nil?
        redirect_to new_settings_registration_path
      elsif current_user.companies.present? && current_user.companies.last.officials.empty?
        redirect_to new_settings_official_path
      end
    end

    def create
      company = current_user.companies.new(company_params)
      if company.valid? && company.save
        redirect_to new_settings_registration_path
      else
        redirect_to new_settings_company_path, flash: { error: 'Помилка створення компанії' }
      end
    end

    private

    def company_params
      params.permit(:full_name,
                    :short_name,
                    :latin_name,
                    :juridical_address,
                    :numbering_format)
    end

    def has_company?
      return
    end
  end
end
