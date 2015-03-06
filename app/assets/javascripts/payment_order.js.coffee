window.PaymentOrder =

  validateFormForNewPaymentOrder: ->
    $('#new_payment_order').validate
      errorElement: 'div'
      errorPlacement: (error, element) ->
        error.insertBefore element
        return
      rules:
        'payment_order[total]': required: true
        'payment_order[date]': required: true
      messages:
        'contract[date]': required: I18n.t('validation.errors.cant_be_blank')
        'payment_order[total]': required: I18n.t('validation.errors.cant_be_blank')
    return

  LoadPlugins: ->
    $('#new_payment_order').hide();
    $('input.number').numeric
      negative: false
      decimal: false
    PaymentOrder.validateFormForNewPaymentOrder();
    openForm("new_payment_order", "add_new_payment_orders")
    PaymentOrder.AutoDateTime()

  AutoDateTime: ->
    curr_date = new Date()
    $('#payment_order_date').val $.datepicker.formatDate('dd.mm.yy.' + curr_date.getHours() + ':' + curr_date.getMinutes(), curr_date)
