module Money  
  class CurrencyController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_currency, only: [:destroy]

    def create
      currency = current_company.currencies.new currency_params
      flash[:error] = 'Більше немає валют для вибору' unless currency.save
      @currencies = current_company.currencies
      respond_to do |format|
        format.js
      end
    end

    def destroy
      @currency_id = params[:id]
      render json:{ success: @currency.destroy }
    end


    private

    def set_currency
      @currency = Currency.find(params[:id])
    end

    def currency_params
      params.require(:currency).permit(:name).merge!(company_id: current_company.id)
    end
  end
end
