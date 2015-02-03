module Money
  class BanksController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_bank, only: [:destroy, :update]
    before_action :define_bank, only: [:index, :create]

    def index
      @banks = Bank.all
      respond_to do |format|
        format.js
      end
    end

    def show
      @bank = Bank.find(params[:id])
      @banks = Bank.all
      respond_to do |format|
        format.js
      end
    end

    def create
      bank = Bank.new bank_params
      @banks = Bank.all
      flash[:error] = t('validation.errors.invalid_data') unless bank.save
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
      bank.destroy
      respond_to do |format|
        format.js
      end
    end

    private

    def set_bank
      @bank = Bank.find(params[:id])
    end

    def bank_params
      params.require(:bank).permit(:name, :code_edrpo, :mfo, :lawyer_adress)
    end

    def define_bank
      @bank ||= Bank.new
    end
  end
end
