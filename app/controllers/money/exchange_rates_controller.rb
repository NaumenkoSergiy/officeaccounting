module Money
  class ExchangeRatesController < ApplicationController
    before_filter :redirect_to_new_session

    def index
      @currencies = current_user.currencies
      respond_to do |format|
        format.js
      end
    end
  end
end
