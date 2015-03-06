class Money::CurrencyTransactions::PaymentOrdersController < ApplicationController
  before_filter :redirect_to_new_session
  before_action :define_payment_order, only: [:create, :index]
  before_action :payment_order, only: :destroy
  before_action :all_payment_orders, only: [:index, :create]

  def index
    respond_to do |format|
      format.js
    end
  end

  def create
    @payment_order.update_attributes payment_order_params
    flash.now[:error] = t('validation.errors.all_fields') unless @payment_order.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @payment_order.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def payment_order
    @payment_order = PaymentOrder.find(params[:id])
  end

  def define_payment_order
    @payment_order = PaymentOrder.new
  end

  def payment_order_params
    params.require(:payment_order).permit(:date,
                                          :account_id,
                                          :counterparty_id,
                                          :total,
                                          :article_id,
                                          :currency,
                                          :number,
                                          :type_order).merge!(company_id: current_company.id)
  end

  def all_payment_orders
    company_payment_orders = current_user.payment_orders.order('payment_orders.created_at DESC')
    @payment_orders = company_payment_orders.payment_orders(params[:type_order] || params[:payment_order][:type_order])
  end
end
