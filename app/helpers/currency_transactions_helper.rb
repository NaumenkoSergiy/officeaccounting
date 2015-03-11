module CurrencyTransactionsHelper

  def render_type_of_transaction_link(type)
    link = {
      'purchase' => "#{link_to t('buttons.buy_currency'), '#', class: 'btn  btn-primary btn-modal'}",
      'sale' => "#{link_to t('buttons.currency_sale'), '#', class: 'btn  btn-primary btn-modal'}"
    }
    link[type].html_safe
  end

  def render_type_of_order_link(type)
    link = {
      'purchase' => "#{link_to t('money.currences_tran.order_p_f_currency'), money_currency_transactions_orders_path(type: type), remote: true, class: 'btn  btn-primary btn-modal'}",
      'sale' => "#{link_to t('money.currences_tran.order_s_f_currency'), money_currency_transactions_orders_path(type: type), remote: true, class: 'btn  btn-primary btn-modal'}"
    }
    link[type].html_safe
  end
end
