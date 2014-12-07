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

      @companies = not_current_user_companies || {}
    end

    def create
      company = Company.new(company_params)
      if company.valid? && company.save
        current_user.user_companies.create(company: company)
        redirect_to new_settings_registration_path
      else
        render json: false
      end
    end

    def add_existing_company
      company = Company.find(params[:company].to_i)
      if current_user.user_companies.create(company: company)
        redirect_to settings_path
      else
        redirect_to new_settings_company_path
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

    def not_current_user_companies
      current_user_companies = UserCompany.where(user_id: current_user)
                                          .map {|r| r.company_id}
      UserCompany.where.not(user_id: current_user)
                 .map do |c|
                   unless current_user_companies.include?(c.company_id)
                     {
                       id: c.company.id,
                       company_name: "#{c.company.full_name} (#{c.company.short_name})"
                     }
                   end
                 end
    end
  end
end
