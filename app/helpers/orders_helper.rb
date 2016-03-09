module OrdersHelper
  def render_order_title(type)
    title = {
      'CurrencyTransaction::Purchase' => t('money.currences_tran.order_p_f_currency'),
      'CurrencyTransaction::Sale' => t('money.currences_tran.order_s_f_currency')
    }
    title[type]
  end

  def load_currency
    Currency::AVAILABLE_CURRENCIES.clone - [:UAH]
  end
end
