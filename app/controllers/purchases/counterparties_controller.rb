module Purchases
  class CounterpartiesController < ApplicationController
    before_action :redirect_to_new_session
    before_action :company?, only: :new
    before_action :set_counterparty, only: [:update, :destroy]
    before_action :define_counterparty, only: [:new, :create]
    before_action :all_counterparties, only: [:index, :new, :create]

    def index
      counterparties = @counterparties.map { |counterparty| { value: counterparty.id, text: counterparty.name } }
      render json: counterparties, status: 200
    end

    def new
      respond_to do |format|
        format.js
      end
    end

    def create
      @counterparty = Counterparty.new counterparty_params
      flash.now[:error] = t('validation.errors.all_fields') unless @counterparty.save
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
      @counterparty ||= Counterparty.new
    end

    def all_counterparties
      @counterparties ||= current_user.counterparties.order('counterparties.created_at DESC')
    end
  end
end
