class MoneyController < ApplicationController
  before_filter :redirect_to_new_session
  before_filter :has_company?, only: [:index]

  def index
    @search = current_user.money_registers.search params[:q]
    @registers = @search.result.page(params[:page])
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?

    respond_to do |format|
      format.html {
        @currency = Currency.new
        @currencies = current_user.currencies
      }
      format.js
    end
  end
end
