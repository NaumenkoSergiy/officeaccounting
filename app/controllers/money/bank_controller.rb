module Money
  class BankController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_bank, only: [:destroy, :update]

    def show
      @banks = Bank.find(params[:id])
      respond_to do |format|
        format.js
      end
    end

    def create
      bank = Bank.new bank_params
      @banks = Bank.all
      flash[:error] = 'Ви ввели е коректні данні' unless bank.save
      respond_to do |format|
        format.js
      end
    end

    def update
      respond_to do |format|
        if @bank.update(bank_params)
          format.json { head :no_content }
        else
          format.json { render json: @bank.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      bank = Bank.find(params[:id])
      render json:{ success: bank.destroy }
    end

    private

    def set_bank
      @bank = Bank.find(params[:id])
    end

    def bank_params
      params.require(:bank).permit(:name, :code_edrpo, :mfo, :lawyer_adress)
    end
  end
end
