module PaymentOrdersHelper

  def render_payment_order_title(type)
    title = {
      'PurchaseOut' => t('money.currences_tran.payment_order_out'),
      'PurchaseIn' => t('money.currences_tran.payment_orders_in'),
      'SaleOut' => t('money.currences_tran.payment_order_out'),
      'SaleIn' => t('money.currences_tran.payment_orders_in')
    }
    title[type]
  end

  def load_account_namber
    InvoiceForm.pluck(:account_number, :id)
  end
end
