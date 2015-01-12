module Settings
  class OfficialsController < ApplicationController
    before_filter :redirect_to_new_session
    before_filter :check_creating_company_step, only: [:new]
    before_filter :define_official
    before_action :set_officials, only: [:update]
    before_action :set_company, only: [:create]
    load_and_authorize_resource

    def new
    end

    def create
      if @official.update_attributes(officials_params)
        @bookkeeper = @official
      else
        flash[:error] = 'Помилкові дані'
      end
    end

    def update
      official = Official.find(params['id'])
      respond_to do |format|
        if official.update(officials_params)
            format.json { head :no_content } if params[:page]
            format.js unless params[:page]
        else
          if params[:page]
            format.json { render json: @official.errors, status: :unprocessable_entity }
          else
            flash[:error] = 'Помилкові дані'
            format.js
          end
        end
      end
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
                    if params[:official] && params[:official][:company_id]
                      Company.find(params[:official][:company_id]).officials.new
                    else
                      current_user.companies.last.officials.new
                    end
                  end
    end
    
    def set_officials
      @official = params[:id] ? Official.find(params[:id]) : Official.new
    end

    def set_company
      @company ||= current_user.companies.last
    end
  end
end
