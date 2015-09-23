paymentOrders = undefined

window.CurrencyTransactions =
  load: (callback) ->
    $.ajax
      type: 'GET'
      dataType: 'json'
      async: false
      url: $('#path').data('orders')
      data: type: $('#currency_transaction_type').val()
      success: callback
    return

  loadOption: ->
    CurrencyTransactions.load (orders) ->
      $selector = $('.orders[data-type=new]')

      if $.isEmptyObject(orders)
        $('#select_order').html('')
      else
        for k,v of orders
          $selector.append '<option value=' + v.id + '>' + "№ (#{v.id}) #{v.date.slice(0,10)}" + '</option>'
        $selector.attr 'data-type', 'old'
        paymentOrders = orders
        CurrencyTransactions.loadValue($('#currency_transaction_order_id').val())

  loadPlugins: ->
    openForm('new_currency_transaction', 'add_new_transaction')
    $('#new_currency_transaction').hide()
    setDatatimePiker()
    CurrencyTransactions.changeOrger()
    CurrencyTransactions.totalGrn()
    $('input.number').numeric
      negative: false

  changeOrger: ->
    $('#currency_transaction_order_id').on 'change', () ->
      $('#currency_transaction_total_pf, #pf_grn').val("")
      CurrencyTransactions.loadValue(@value)

  loadValue: (id) ->
    order = undefined
    $.each paymentOrders, (k,v) ->
      order = paymentOrders[k] if @id == parseInt(id)
    if order
      $('#new_currency_transaction #transaction_bank').val order.bank
      $('#new_currency_transaction #transaction_currency').val order.currency
      $('#new_currency_transaction #transaction_total').val order.total
      $('#new_currency_transaction #transaction_commission').val order.commission
      $('#new_currency_transaction #transaction_total_grn').val order.total_grn
      $('#new_currency_transaction #transaction_rate').val order.rate
      $('#new_currency_transaction #transaction_account_grn').val order.account_grn
      $('#new_currency_transaction #transaction_account_rate').val order.account_rate

  totalGrn: ->
    $('#pf_grn').keyup ->
      commission = ($('#transaction_total_grn').val() * @value)/100
      $('#currency_transaction_total_pf').val commission
      return
    return
