module Settings
  class OfficialsController < ApplicationController
    before_action :redirect_to_new_session
    before_action :check_creating_company_step, only: [:new]
    before_action :set_company, only: [:create]
    before_action :define_official
    before_action :set_officials, only: [:update]

    def new
    end

    def create
      if @official.update_attributes(officials_params)
        @bookkeeper = @official
      else
        flash[:error] = t('validation.errors.invalid_data')
      end
    end

    def update
      official = Official.find(params['id'])
      respond_to do |format|
        if official.update(officials_params)
          format.json { head :no_content } if params[:page]
          format.js unless params[:page]
        elsif params[:page]
          format.json { render json: @official.errors, status: :unprocessable_entity }
        else
          flash[:error] = t('validation.errors.invalid_data')
          format.js
        end
      end
    end

    private

    def officials_params
      params.require(:official).permit(:official_type, :name, :tin, :phone, :email)
    end

    def define_official
      @official = if params[:back]
                    company_officials_by_type(params[:official_type])
                  else
                    company_officials_by_id(params)
                  end
    end

    def set_officials
      @official = params[:id] ? Official.find(params[:id]) : Official.new
    end

    def set_company
      @company ||= current_user.companies.last
    end

    def company_officials_by_type(official_type)
      if official_type == 'bookeeper'
        @company.officials.find_by(official_type: :bookeeper) || @company.officials.new
      else
        @company.officials.find_by(official_type: :director)
      end
    end

    def company_officials_by_id(params)
      if params[:official] && params[:official][:company_id]
        Company.find(params[:official][:company_id]).officials.new
      else
        @company.officials.new
      end
    end
  end
end
