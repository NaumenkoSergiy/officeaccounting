module PaymentOrdersHelper

  def render_payment_order_title(type)
    title = {
      out: t('money.currences_tran.payment_order_out'),
      in: t('money.currences_tran.payment_orders_in')
    }
    title[type.to_sym]
  end

  def load_account_namber
    InvoiceForm.pluck(:account_number, :id)
  end
end
