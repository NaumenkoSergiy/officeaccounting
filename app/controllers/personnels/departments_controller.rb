module Personnels
  class DepartmentsController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :find_department, only: [:destroy, :update]
    before_action :departments, only: [:index, :create]
    before_action :define_department, only: [:index, :create]

    def index
      respond_to do |format|
        format.js
        format.json { render json: @departments.select(:id, :name)
                                               .map { |department| { value: department.id, text: department.name } }, status: 200 }
      end
    end

    def create
      @department.update(department_params)
      flash.now[:error] = t('validation.errors.all_fields') unless @department.save
      respond_to { |format| format.js }
    end

    def update
      respond_to do |format|
        if @department.update(department_params)
          format.json { head :no_content }
        else
          format.json { render json: @department.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      if @department.assigned?
        flash.now[:error] = t('validation.errors.department_error')
      else
        @department.destroy
      end
      respond_to { |format| format.js }
    end

    private

    def define_department
      @department = Department.new
    end

    def find_department
      @department = Department.find(params[:id])
    end

    def department_params
      params.require(:department).permit!.merge(company_id: current_company.id)
    end

    def departments
      @departments = current_company.departments.order('departments.created_at DESC')
                                                .page(params[:page])
    end
  end
end
