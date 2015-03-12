if '<%= flash[:error] %>'
  $('.notification.error').show().text('<%= flash[:error] %>').fadeOut(5000)
else
  $('#currency_purchases_list').html('<%= j(render "money/currency_transactions/list") %>')
  $('#new_currency_transaction').hide()
  $('#currency_transaction_total_pf, #pf_grn').val('')
