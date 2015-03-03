module Money
  class CurrenciesTransactionsController < ApplicationController
    before_filter :redirect_to_new_session

    def index
      respond_to do |format|
        format.js
      end
    end
  end
end
