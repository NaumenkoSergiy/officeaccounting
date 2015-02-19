module Money  
  class CurrenciesController < ApplicationController
    before_filter :redirect_to_new_session
    before_action :set_currency, only: [:destroy]

    def create
      currency = current_user.currencies.new currency_params
      flash.now[:error] = t('validation.errors.all_fields') unless currency.save
      @currencies = current_user.currencies
      respond_to do |format|
        format.js
      end
    end

    def destroy
      currency = Currency.find(params[:id])
      render json:{ success: currency.destroy }
    end

    private

    def set_currency
      @currency = Currency.find(params[:id])
    end

    def currency_params
      params.require(:currency).permit(:name).merge!(company_id: current_user.current_company.id)
    end
  end
end
