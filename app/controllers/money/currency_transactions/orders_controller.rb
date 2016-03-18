class Money::CurrencyTransactions::OrdersController < ApplicationController
  before_action :redirect_to_new_session
  before_action :define_order, only: [:create, :index]
  before_action :all_orders, only: [:create, :index]
  before_action :order, only: :destroy

  def index
    respond_to do |format|
      format.js
      format.json do
        render json: ActiveModel::ArraySerializer.new(@orders,
                                                      each_serializer: OrderSerializer,
                                                      root: nil), status: 200
      end
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
    params.require(:order).permit!.except(:path).merge(company_id: current_company.id)
  end

  def all_orders
    company_orders = current_user.orders.order('orders.created_at DESC')
    @orders = company_orders.orders_by_type(params[:type] || params[:order][:type_order])
  end
end
