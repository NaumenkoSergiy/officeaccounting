module Purchases
  class CounterpartiesController < ApplicationController
    before_action :redirect_to_new_session
    before_action :has_company?, only: :new
    before_action :set_counterparty, only: [:update, :destroy]
    before_action :define_counterparty, only: [:new, :create]
    before_action :all_counterparties, only: [:new, :create]

    def index
      counterparties = Counterparty.where(company_id: params[:id])
      render json: { data: counterparties.order('counterparties.created_at DESC') }
    end

    def new
      @banks = Bank.all
      respond_to do |format|
        format.js
      end
    end

    def create
      @banks = Bank.all
      @contract = Contract.new
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

    def all_counterparties
      @counterparties ||= current_user.counterparties.order('counterparties.created_at DESC')
    end
  end
end
