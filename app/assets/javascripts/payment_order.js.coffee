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
    $('#payment_order_date').datetimepicker();
    $('input.number').numeric
      negative: false
      decimal: false
    PaymentOrder.validateFormForNewPaymentOrder();
    openForm("new_payment_order", "add_new_payment_orders");
