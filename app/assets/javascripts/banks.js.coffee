window.Banks =
  loadBanks: (callback) ->
    $.ajax
      type: 'GET'
      dataType: 'json'
      async: false
      url: $('#path').data('banks')
      success: callback
    return

  loadOption: ->
    $('.banks[data-type=new]').attr 'data-type', 'old'
    Banks.loadBanks (banks) ->
      $.each banks, ->
        $('.banks').append '<option value=' + @value + '>' + @text + '</option>'
        return
      return
    return

  validateFormForNewBank: ->
    $('#new_bank').validate
      errorElement: 'div'
      errorPlacement: (error, element) ->
        error.insertBefore element
        return
      rules:
        'bank[name]': required: true
        'bank[code_edrpo]': required: true
        'bank[mfo]': required: true
        'bank[lawyer_adress]': required: true
      messages:
        'bank[name]': required: I18n.t('validation.errors.cant_be_blank')
        'bank[code_edrpo]': required: I18n.t('validation.errors.cant_be_blank')
        'bank[mfo]': required: I18n.t('validation.errors.cant_be_blank')
        'bank[lawyer_adress]': required: I18n.t('validation.errors.cant_be_blank')
    return

  xeditableBanks: ->
    Banks.loadBanks (banks) ->
      $('.change_bank').editable
        type: 'select2'
        source: banks
        ajaxOptions:
          type: 'PUT'
          dataType: 'json'
        params: xeditableParams
      return
    return
