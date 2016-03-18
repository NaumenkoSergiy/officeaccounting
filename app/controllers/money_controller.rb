class MoneyController < ApplicationController
  before_filter :redirect_to_new_session
  before_filter :company?, only: [:index]
  before_filter :build_search, only: [:index]

  def index
    @registers = @search.result.page(params[:page])
    build_charts

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

  def build_charts
    chart = MoneyChartService.new(MoneyChartDataDecorator.new(@registers))
    @main_chart = chart.main
    @article_income_chart = chart.article_income
    @article_costs_chart = chart.article_costs
    @account_money_chart = chart.account_money
  end
end
