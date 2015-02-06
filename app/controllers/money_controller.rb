class MoneyController < ApplicationController
  before_filter :redirect_to_new_session
  before_filter :has_company?, only: [:index]

  def index
    @currency = Currency.new
    @currencies = current_user.current_company.try(:currencies) || {}
    @banks = Bank.all
    @registers = current_user.current_company.money_registers.order('money_registers.created_at DESC').limit(7)
  end
end
