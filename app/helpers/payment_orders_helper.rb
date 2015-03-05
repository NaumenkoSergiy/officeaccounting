module PaymentOrdersHelper

  def render_payment_order_title(page = '')
    if page == 'out'
      t('money.currences_tran.payment_order_out')
    else
      t('money.currences_tran.payment_orders_in')
    end
  end

  def render_paument_orders_list(paument_orders)
    render partial: "money/currency_transactions/payment_orders/paument_orders_list" , collection: paument_orders, as: :paument_order
  end

  def load_account_namber
    InvoiceForm.pluck(:account_number, :id)
  end
end
