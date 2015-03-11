module PaymentOrdersHelper

  def render_payment_order_title(type)
    title = {
      'purchaseOut' => t('money.currences_tran.payment_order_out'),
      'purchaseIn' => t('money.currences_tran.payment_orders_in'),
      'saleOut' => t('money.currences_tran.payment_order_out'),
      'saleIn' => t('money.currences_tran.payment_orders_in')
    }
    title[type]
  end

  def load_account_namber
    InvoiceForm.pluck(:account_number, :id)
  end
end
