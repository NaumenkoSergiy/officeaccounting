module CurrencyTransactionsHelper

  def render_type_of_transaction_link(type = '')
    if type == 'purchase'
      link_to t('buttons.buy_currency'), '#', class: 'btn  btn-primary btn-modal'
    else
      link_to t('buttons.currency_sale'), '#', class: 'btn  btn-primary btn-modal'
    end
  end

  def render_type_of_order_link(type= '')
    if type == 'purchase'
      link_to t('money.currences_tran.order_p_f_currency'), money_currency_transactions_orders_path(type: type), remote: true, class: 'btn  btn-primary btn-modal'
    else
      link_to t('money.currences_tran.order_s_f_currency'), money_currency_transactions_orders_path(type: type), remote: true, class: 'btn  btn-primary btn-modal'
    end
  end
end
