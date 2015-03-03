module CurrenciesTransactionsHelper
  
  def type_of_transaction(page = '')
    if page == 'purchase'
      link_to t('money.currences_tran.order_p_f_currency'), '#', class: 'btn  btn-primary btn-modal'
      link_to t('buttons.buy_currency'), '#', class: 'btn  btn-primary btn-modal'
    else
      
      link_to t('buttons.currency_sale'), '#', class: 'btn  btn-primary btn-modal'
    end
  end

  def type_of_order(page= '')
    if page == 'purchase'
      link_to t('money.currences_tran.order_p_f_currency'), '#', class: 'btn  btn-primary btn-modal'
    else
      link_to t('money.currences_tran.order_s_f_currency'), '#', class: 'btn  btn-primary btn-modal'
    end    
  end
end
