window.Order =

  validateFormForNewOrder: ->
    $('#new_order').validate
      errorElement: 'div'
      errorPlacement: (error, element) ->
        error.insertBefore element
        return
      rules:
        'order[total]': required: true
        'order[date]': required: true
        'order[rate]': required: true
      messages:
        'contract[date]': required: I18n.t('validation.errors.cant_be_blank')
        'order[total]': required: I18n.t('validation.errors.cant_be_blank')
        'order[rate]': required: I18n.t('validation.errors.cant_be_blank')
    return

  LoadPlugins: ->
    $('#new_order').hide()[0].reset()
    $('input.number').numeric
      negative: false
    $('#order_date').datetimepicker({lang: I18n.t('datePickerLocal'), format:'d.m.Y-H:i', mask:true})
    Order.validateFormForNewOrder()
    openForm("new_order", "add_new_order")
    Order.totalGrn()

  totalGrn: ->
    $('#order_rate, #order_commission, #order_total').keyup ->
      total = $('#order_rate').val() * $('#order_total').val()
      commission = ((total * $('#order_commission').val())/100)
      totalGrn = total + commission
      $('#order_total_grn').val totalGrn
      return
    return
