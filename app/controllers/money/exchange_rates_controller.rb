module Money
  class ExchangeRatesController < ApplicationController
    def index
      @currencies = current_user.current_company.currencies
      respond_to do |format|
        format.js
      end
    end
  end
end
