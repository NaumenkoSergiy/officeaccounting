module OrdersHelper

  def render_order_title(type)
    title = {
      'purchase' => t('money.currences_tran.order_p_f_currency'),
      'sale' => t('money.currences_tran.order_s_f_currency')
    }
    title[type]
  end

  def load_currency
    Currency::AVAILABLE_CURRENCIES.clone - [:UAH]
  end
end
