module Settings
  class OfficialsController < ApplicationController
    before_filter :redirect_to_new_session
    before_filter :check_creating_company_step, only: [:new]
    before_filter :define_official

    def new
    end

    def create
      flash[:error] = 'Помилкові дані' unless @official.update_attributes(officials_params)
    end

    def update
      official = Official.find(params['id'])
      flash[:error] = 'Помилкові дані' unless official.update_attributes officials_params
    end

    private

    def officials_params
      params.require(:official).permit(:official_type, :name, :tin, :phone, :email)
    end

    def define_official
      @official = if params[:back]
                    if params[:official_type] == 'bookeeper'
                      @company.officials.find_by(official_type: :bookeeper) ||
                      current_user.companies.last.officials.new
                    else
                      @company.officials.find_by(official_type: :director)
                    end
                  else
                    current_user.companies.last.officials.new
                  end
    end
  end
end
