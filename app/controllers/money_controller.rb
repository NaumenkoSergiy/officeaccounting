class MoneyController < ApplicationController
  before_filter :redirect_to_new_session

  def index
    @currency = Currency.new
    @currencies = current_user.current_company.currencies
  end
end
