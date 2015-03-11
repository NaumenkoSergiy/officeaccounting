class Money::CurrencyTransactions::OrdersController < ApplicationController
  before_filter :redirect_to_new_session
  before_action :define_order, only: [:create, :index]
  before_action :all_orders, only: [:create, :index]
  before_action :order, only: :destroy

  def index
    respond_to do |format|
      format.js
    end
  end

  def create
    @order.update_attributes order_params
    flash.now[:error] = t('validation.errors.all_fields') unless @order.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def order
    @order = Order.find(params[:id])
  end

  def define_order
    @order = Order.new
  end

  def order_params
    params.require(:order).permit(:date,
                                  :bank_id,
                                  :currency,
                                  :total,
                                  :total_grn,
                                  :rate,
                                  :commission,
                                  :account_grn_id,
                                  :type_order,
                                  :account_rate_id).merge!(company_id: current_company.id)
  end

  def all_orders
    company_orders = current_user.orders.order('orders.created_at DESC')
    @orders = company_orders.orders_by_type(params[:type] || params[:order][:type_order])
  end
end
