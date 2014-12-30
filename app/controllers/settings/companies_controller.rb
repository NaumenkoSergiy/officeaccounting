module Settings
  class CompaniesController < ApplicationController
    before_filter :redirect_to_new_session
    before_filter :check_creating_company_step, only: [:new]
    before_action :set_company, only: [:update, :new, :create]
    load_and_authorize_resource

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
      respond_to do |format|
        if @company.update(company_params)
          format.json { head :no_content }
        else
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      company = Company.find(params['id'])
      flash[:error] = 'Помилкові дані' unless company.update_attributes company_params
    end

    def add_existing_company
      company = Company.find(params[:company])

      if !current_user_has_company?(company.id) &&
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
      companies = Company.non_current_user(current_user.id)
      companies.collect{ |c| [c.full_short_name, c.id] }
    end

    def current_user_has_company? company_id
      user_companies = UserCompany.user_companies(current_user.id).pluck(:company_id).compact
      user_companies.include? company_id
    end

    def set_company
      @company = params[:id] ? Company.find(params[:id]) : Company.new
    end
  end
end
