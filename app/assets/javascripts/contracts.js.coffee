window.Contracts = 
  load: (callback, id) ->
    $.ajax
      type: 'GET'
      async: false
      url: $('#path').data('contracts')
      data: contract: counterparty_id: id
      success: callback
    return

  loadContract: ->
    $('#money_register_counterparty_id').change ->
      page = $('#money_register_contract_id').data('page')
      path = $('#money_register_contract_id').data('path')
      $('.contract_select').html '<select class="counterparty_contracts" data-path=' + path + ' data-page="'+
        page + '" data-select="false" id="money_register_contract_id" name="money_register[contract_id]"></select>'
      return
    return

  loadPlugins: ->
    $('#contract_date, #contract_validity').datepicker(
      changeMonth: true
      changeYear: true
      yearRange: 'c-100:c+1').change 'changeDate', ->
      $(this).valid()
      return
    $('input.number').numeric
      negative: false
      decimal: false
    $('#contract_contract_type').select2 minimumResultsForSearch: -1
    Contracts.validateFormForNewContract()
    return

  ForCounterparty: ->
    $counterpartyContracts = $('#money_register_counterparty_id')
    id = $counterpartyContracts.val()
    Contracts.load ((contracts) ->
      page = $counterpartyContracts.data('page')
      path = $('#money_register_contract_id').data('path')
      if $.isEmptyObject(contracts)
        $('.contract_select').html '<a data-remote=\'true\' href=' + path + '?page=' + page + ' type=\'get\'>' + I18n.t('contract.contract_info') + '</a>'
      else
        $.each contracts, ->
          $('.counterparty_contracts').append '<option value=' + @value + '>' + @text + '</option>'
          return
        $('.contract_select').prepend '<a data-remote=\'true\' href=' + path + '?page=' + page + ' type=\'get\'>' + I18n.t('contract.counterparty_add') + '</a>'
      return
    ), id
    return

  ForRegisterTable: ->
    registerId = $('form#contract_popover').attr('data-id')
    contractDefault = $('#contract_' + registerId).attr('data-contract')
    id = $('select.counterparty_reg').val()
    Contracts.load ((contracts) ->

      if $.isEmptyObject(contracts)
        $('.register_contract').html(I18n.t('contract.contract_empty')).css 'color': 'red'
      else
        $.each contracts, ->
          $('.contract_reg[data-status=new]').append '<option value=' + @value + '>' + @text + '</option>'
          return
        $('.contract_reg[data-status=new]').attr 'data-status', 'old'
        $('.contract_reg[data-status=old]').select2 'width': '130px'

        if !$('.contract_reg[data-status=old]').hasClass('change')
          $('.contract_reg').select2 'val', contractDefault
      return
    ), id
    return

  validateFormForNewContract: ->
    $('#new_contract').validate
      errorElement: 'div'
      errorPlacement: (error, element) ->
        error.insertBefore element
        return
      rules:
        'contract[date]': required: true
        'contract[number]': required: true
        'contract[validity]': required: true
      messages:
        'contract[date]': required: I18n.t('validation.errors.cant_be_blank')
        'contract[number]': required: I18n.t('validation.errors.cant_be_blank')
        'contract[validity]': required: I18n.t('validation.errors.cant_be_blank')
    return
    
  hideContract: ->
    if $('#counterparty_info').length
      $('#contract_select').hide()
    else
      $('#contract_select').show()
    return
