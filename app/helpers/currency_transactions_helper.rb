module CurrencyTransactionsHelper
  def render_type_of_transaction_link(type)
    link = {
      'Purchase' => (link_to t('buttons.buy_currency'), new_money_currency_transaction_path(type: 'CurrencyTransaction::' + type), remote: true, class: 'btn btn-primary btn-modal').to_s,
      'Sale' => (link_to t('buttons.currency_sale'), new_money_currency_transaction_path(type: 'CurrencyTransaction::' + type), remote: true, class: 'btn btn-primary btn-modal').to_s
    }
    link[type].html_safe
  end

  def render_type_of_order_link(type)
    link = {
      'Purchase' => (link_to t('money.currences_tran.order_p_f_currency'), money_currency_transactions_orders_path(type: 'CurrencyTransaction::' + type), remote: true, class: 'btn btn-primary btn-modal').to_s,
      'Sale' => (link_to t('money.currences_tran.order_s_f_currency'), money_currency_transactions_orders_path(type: 'CurrencyTransaction::' + type), remote: true, class: 'btn btn-primary btn-modal').to_s
    }
    link[type].html_safe
  end

  def render_transaction_title(type)
    title = {
      'CurrencyTransaction::Purchase' => t('buttons.buy_currency'),
      'CurrencyTransaction::Sale' => t('buttons.currency_sale')
    }
    title[type]
  end

  def render_currency_transactions_list(currency_transactions)
    render partial: 'money/currency_transactions/list_transactions', collection: currency_transactions, as: :currency_transaction
  end
end
