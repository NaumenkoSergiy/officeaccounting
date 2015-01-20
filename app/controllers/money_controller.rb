class MoneyController < ApplicationController
  before_filter :redirect_to_new_session
  before_filter :has_company?, only: [:index]

  def index
    @currency = Currency.new
    @currencies = current_user.current_company.try(:currencies) || {}
    @banks = Bank.all
  end
end
