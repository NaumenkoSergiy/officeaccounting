module OrdersHelper

  def render_order_title(type = '')
    if type == 'purchase'
      t('money.currences_tran.order_p_f_currency')
    else
      t('money.currences_tran.order_s_f_currency')
    end
  end

  def load_currency
    Currency::AVAILABLE_CURRENCIES.clone - [:UAH]
  end
end
