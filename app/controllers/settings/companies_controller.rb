module Settings
  class CompaniesController < ApplicationController
    before_action :redirect_to_new_session
    before_action :check_creating_company_step, only: [:new]
    before_action :set_company, only: [:update, :new, :create]

    def new
      @companies = not_current_user_companies || {}
    end

    def create
      company = Company.new(company_params)

      if company.save
        current_user.user_companies.create(company: company, role: 'edit')
      else
        flash[:error] = t('validation.errors.invalid_data')
      end
    end

    def update
      respond_to do |format|
        if @company.update(company_params)
          params[:page] ? format.json { head :no_content } : format.js
        elsif params[:page]
          format.json { render json: @company.errors, status: :unprocessable_entity }
        else
          flash[:error] = t('validation.errors.invalid_data')
          format.js
        end
      end
    end

    def add_existing_company
      company = Company.find(params[:company])

      if !current_user_company?(company.id) &&
         current_user.user_companies.create(company: company)
        redirect_to settings_path
      else
        redirect_to new_settings_company_path
      end
    end

    def change_company
      company = current_user.find_company(params[:company_id])
      old_company = current_user.find_company if current_user.current_company
      change_current_company(old_company, company) unless company.id == old_company.id
      redirect_to root_path
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
      companies.collect { |c| [c.full_short_name, c.id] }
    end

    def current_user_company?(company_id)
      user_companies = UserCompany.user_companies(current_user.id).pluck(:company_id).compact
      user_companies.include? company_id
    end

    def set_company
      @company = params[:id] ? Company.find(params[:id]) : Company.new
    end

    def change_current_company(old_current_company, new_current_company)
      old_current_company.update_current(false) if old_current_company
      new_current_company.update_current(true)
    end
  end
end
