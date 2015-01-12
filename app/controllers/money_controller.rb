class MoneyController < ApplicationController
  before_filter :has_company?, only: [:index]
  before_filter :redirect_to_new_session

  def index
    @currencies = current_user.current_company.currencies
    @currency = Currency.new
  end
end
