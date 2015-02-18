module Money
  class CashiersController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_cashier, only: [:destroy, :update, :show]
    before_action :define_cashier, only: [:index, :create]
    before_action :company_cashiers, only: [:index, :create]

    def index
      respond_to do |format|
        format.js
      end
    end

    def show
      respond_to do |format|
        format.js
      end
    end

    def create
      cashier = Cashier.new cashier_params
      flash[:error] = t('validation.errors.invalid_data') unless cashier.save
      respond_to do |format|
        format.js
      end
    end

    def update
      respond_to do |format|
        if @cashier.update(cashier_params)
          format.json { head :no_content }
        else
          format.json { render json: @cashier.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @cashier.destroy
        respond_to do |format|
        format.js
      end
    end

    private

    def set_cashier
      @cashier = Cashier.find(params[:id])
    end

    def cashier_params
      params.require(:cashier).permit(:name, :currency).merge!(company_id: current_user.current_company.id)
    end

    def define_cashier
      @cashier ||= Cashier.new
    end

    def company_cashiers
      @cashiers = current_user.cashiers
    end
  end
end
