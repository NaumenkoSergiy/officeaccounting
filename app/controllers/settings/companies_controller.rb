module Settings
  class CompaniesController < ApplicationController
    before_filter :redirect_to_new_session
    before_filter :check_creating_company_step, only: [:new]

    def new
      @companies = not_current_user_companies || {}
    end

    def create
      company = Company.new(company_params)

      if company.save
        current_user.user_companies.create(company: company) #ToDo move it to the model in the after_save
      else
        flash[:error] = 'Помилкові дані'
      end
    end

    def update
      company = Company.find(params['id'])
      flash[:error] = 'Помилкові дані' unless company.update_attributes company_params
    end

    def add_existing_company
      company = Company.find(params[:company])

      if current_user_has_not_company?(company.id) &&
         current_user.user_companies.create(company: company)
        redirect_to settings_path
      else
        redirect_to new_settings_company_path
      end
    end

    private

    def company_params
      params.require(:company).permit(:full_name,
                                      :short_name,
                                      :latin_name,
                                      :juridical_address,
                                      :actual_address,
                                      :numbering_format)
    end

    def not_current_user_companies
      current_user_companies = UserCompany.where(user_id: current_user)
                                          .map {|r| r.company_id}
      companies= UserCompany.where.not(user_id: current_user)
                            .map do |c|
                              if c.company && !current_user_companies.include?(c.company_id)
                                {
                                  id: c.company_id,
                                  company_name: "#{c.company.full_name} (#{c.company.short_name})"
                                }
                              end
                            end
      companies.try(:compact)
    end

    def current_user_has_not_company? company_id
      user_companies = UserCompany.where(user_id: current_user)
      !user_companies.map {|c| c.company_id == company_id }.include? true
    end
  end
end
