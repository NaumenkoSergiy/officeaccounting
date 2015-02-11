module Purchases
  class CounterpartiesController < ApplicationController
    before_filter :redirect_to_new_session
    before_filter :has_company?, only: [:index]
    before_action :set_counterparty, only: [:update, :destroy]
    before_action :define_counterparty, only: [:index, :create]
    before_action :get_all_counterparties, only: [:index, :create]

    def index
      @banks = Bank.all
      respond_to do |format|
        format.js
      end
    end

    def create
      @banks = Bank.all
      @contract = Contract.new
      @register = MoneyRegister.new
      @contracts_counterparty = @counterparties.empty? ? {} : Contract.contracts_for_conterparty(@counterparties.first.id)
      @counterparty = Counterparty.new counterparty_params
      flash[:error] = 'Ви ввели не коректні данні' unless @counterparty.save
      respond_to do |format|
        format.js
      end
    end

    def update
      respond_to do |format|
        if @counterparty.update(counterparty_params)
          format.json { head :no_content }
        else
          format.json { render json: @counterparty.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @counterparty.destroy
      @counterparty_id = params[:id]
      respond_to do |format|
        format.js
      end
    end

    private

    def set_counterparty
      @counterparty = Counterparty.find(params[:id])
    end

    def counterparty_params
      params.require(:counterparty).permit(:name,
                                           :title,
                                           :resident,
                                           :edrpo,
                                           :adress,
                                           :account,
                                           :bank_id,
                                           :mfo).merge!(company_id: current_user.current_company.id)
    end
    
    def define_counterparty
      @counterparty ||= current_user.current_company.counterparties.new
    end

    def get_all_counterparties
      @accounts ||= current_user.current_company.try(:accounts)
      @articles = Article.all
      @registers = current_user.current_company.money_registers
      @counterparties ||= current_user.current_company.counterparties.order('counterparties.created_at DESC')
    end
  end
end
