window.Counterparties = 
  load: (callback) ->
    $.ajax
      type: 'GET'
      async: false
      url: $('#path').data('counterparties')
      success: callback
    return

  loadPluginsCounterparty: ->
    $('input.number').numeric
      negative: false
      decimal: false
    Counterparties.validateFormForNewCounterparty()
    return

  loadOption: ->
    Counterparties.load (counterparties) ->
      selector = $('.company_counterparties[data-type=new]')
      id = selector.data('id')
      page = selector.data('page')
      path = selector.data('path')
      if $.isEmptyObject(counterparties)
        selector.parent().html '<a data-remote=\'true\' href=' + path + '?page=' + page + ' type=\'get\'>' + I18n.t('contract.counterparty_info') + '</a>'
      else
        $.each counterparties, ->
          selector.append '<option value=' + @value + '>' + @text + '</option>'
          return
        selector.before '<a data-remote=\'true\' href=' + path + '?page=' + page + ' type=\'get\'>' + I18n.t('contract.counterparty_add') + '</a>'
        if $('#contracts').length and $('#costs').hasClass('fade in')
          $('#contracts a[data-remote]').remove()
        selector.attr 'data-type', 'old'
        Contracts.loadContract()
      return
    return

  validateFormForNewCounterparty: ->
    $('#new_counterparty').validate
      errorElement: 'div'
      errorPlacement: (error, element) ->
        error.insertBefore element
        return
      rules:
        'counterparty[title]': required: true
        'counterparty[name]': required: true
        'counterparty[edrpo]': required: true
        'counterparty[adress]': required: true
        'counterparty[account]': required: true
        'counterparty[mfo]': required: true
      messages:
        'counterparty[title]': required: I18n.t('validation.errors.cant_be_blank')
        'counterparty[name]': required: I18n.t('validation.errors.cant_be_blank')
        'counterparty[edrpo]': required: I18n.t('validation.errors.cant_be_blank')
        'counterparty[adress]': required: I18n.t('validation.errors.cant_be_blank')
        'counterparty[account]': required: I18n.t('validation.errors.cant_be_blank')
        'counterparty[mfo]': required: I18n.t('validation.errors.cant_be_blank')
    return

  checkResident: ->
    $('.counterparty_resident').click ->
      id = $(this).data('id')
      $.ajax
        type: 'PUT'
        url: $('#path').data('counterparties') + '/' + id
        data: counterparty: resident: $(this).is(':checked')
      return
    return

  forRegister: ->
    Counterparties.load (counterparties) ->
      id = $('.counterparty_reg[data-type=new]').data('id')
      $selector = $('.counterparty_reg[data-type=new]')
      $.each counterparties, ->
        $selector.append '<option value=' + @value + '>' + @text + '</option>'
        return
      $selector.attr 'data-type', 'old'
      $('.counterparty_reg[data-type=old]').select2 'width': '130px'
      $('.counterparty_reg[data-type=old]').select2 'val', id
      return
    return

  clickEditable: ->
    idContract = undefined
    idCounterparty = undefined
    idRegister = undefined

    $('.conterparty_popover').popover(
      html: true
      placement: 'bottom'
      trigger: 'manual'
      content: ->
        '<form id="contract_popover"  data-remote="true" data-counterparty=' + idCounterparty + ' data-contract=' + idContract + 
        ' data-id=' + idRegister + ' action="" role="form">
          <div class="row">
            <div class="col-lg-4">
              <lable>' + I18n.t('contract.counterparty') + '</lable>
            </div>
            <div class="col-lg-4">
              <lable>'+ I18n.t('money.costs.contract') + '</lable>
            </div>
          </div>
          <div class="row">
            <div class="col-lg-4">
              <select class="counterparty_reg" data-type="new" data-id=' + idCounterparty + '></select>
            </div>
            <div class="col-lg-4">
              <div class="register_contract">
                <select class="contract_reg" data-status="new"></select>
              </div>
            </div>
            <div class="col-lg-4">
              <div class="editable-buttons">
                <button class="btn btn-primary btn-sm editable-submit" type="submit">
                  <i class="glyphicon glyphicon-ok"></i>
                </button>
                <button class="btn btn-default btn-sm margin-left-15" type="button">
                  <i class="glyphicon glyphicon-remove"></i>
                </button>
              </div>
            </div>
          </div>
        </form>'
    ).click (e) ->
      idCounterparty = $(this).attr('data-value')
      idContract = $(this).attr('data-contract')
      idRegister = $(this).attr('data-id')
      $('.conterparty_popover').not(this).popover 'hide'
      $(this).popover 'toggle'
      setEditCounterparty()
      return

    $(document).click (e) ->
      if !$(e.target).is('.conterparty_popover, .popover-content')
        $('.conterparty_popover').popover 'hide'
      return
    return
    
