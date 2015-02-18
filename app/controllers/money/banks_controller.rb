module Money
  class BanksController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_bank, only: [:destroy, :update, :show]
    before_action :define_bank, only: [:index, :create]
    before_action :all_banks, only: [:index, :create]

    def index
      if params[:page]
        respond_to do |format|
          format.js
        end
      else
        banks = application_present.options_for_select2(Bank.pluck(:name, :id))
        render json: banks, status: 200
      end
    end

    def show
      respond_to do |format|
        format.js
      end
    end

    def create
      bank = Bank.new bank_params
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
      @bank.destroy
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

    def all_banks
      @banks = Bank.all
    end
  end
end
