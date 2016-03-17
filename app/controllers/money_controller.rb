class MoneyController < ApplicationController
  before_filter :redirect_to_new_session
  before_filter :company?, only: [:index]
  before_filter :build_search, only: [:index]

  def index
    @registers = @search.result.page(params[:page])
    @chart = MoneyChartService.new(@registers).column_chart

    respond_to do |format|
      format.html do
        @currency = Currency.new
        @currencies = current_user.currencies
      end
      format.js
    end
  end

  private

  def build_search
    @search = current_user.money_registers.search params[:q]
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
  end
end
