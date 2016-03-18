module Personnels
  class EmployeesController < ApplicationController
    before_action :redirect_to_new_session
    before_action :find_employee, only: [:destroy, :update]
    before_action :employees, only: [:index, :create]
    before_action :new_employee, only: [:index, :create]
    before_action :subclasses_of_employee, only: [:index, :create]
    before_action :personnel_number_of_employee, only: [:index, :create]

    def index
      respond_to { |format| format.js }
    end

    def create
      @employee.update(employee_params)
      flash.now[:error] = t('validation.errors.all_fields') unless @employee.save
      personnel_number_of_employee
      respond_to { |format| format.js }
    end

    def update
      respond_to do |format|
        if @employee.update(employee_params)
          format.json { head :no_content }
        else
          format.json { render json: @employee.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @employee.destroy
      respond_to { |format| format.js }
    end

    private

    def new_employee
      @employee = Employee.new
    end

    def find_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit!.merge(company_id: current_company.id)
    end

    def employees
      @employees = current_company.employees.order('employees.created_at DESC')
                                  .page(params[:page])
    end

    def subclasses_of_employee
      @subclasses = Employee.subclasses
    end

    def personnel_number_of_employee
      @personnel_number = current_company.employees.with_deleted.count
    end
  end
end
