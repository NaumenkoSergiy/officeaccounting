module Money
  class CashierController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_cashier, only: [:destroy, :update]

    def show
      @cashier = Cashier.find(params[:id])
      respond_to do |format|
        format.js
      end
    end

    def create
      cashier = Cashier.new cashier_params
      @cashiers = Cashier.all
      flash[:error] = 'Ви ввели не коректні данні' unless cashier.save
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
      cashier = Cashier.find(params[:id])
      render json:{ success: cashier.destroy }
    end

    private

    def set_cashier
      @cashier = Cashier.find(params[:id])
    end

    def cashier_params
      params.require(:cashier).permit(:name, :currency).merge!(company_id: current_user.current_company.id)
    end
  end
end
