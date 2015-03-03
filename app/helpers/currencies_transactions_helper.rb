module CurrenciesTransactionsHelper
  
  def render_type_of_transaction_link(page = '')
    if page == 'purchase'
      link_to t('buttons.buy_currency'), '#', class: 'btn  btn-primary btn-modal'
    else
      link_to t('buttons.currency_sale'), '#', class: 'btn  btn-primary btn-modal'
    end
  end

  def render_type_of_order_link(page= '')
    if page == 'purchase'
      link_to t('money.currences_tran.order_p_f_currency'), '#', class: 'btn  btn-primary btn-modal'
    else
      link_to t('money.currences_tran.order_s_f_currency'), '#', class: 'btn  btn-primary btn-modal'
    end    
  end
end
