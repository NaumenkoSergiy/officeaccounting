window.Accounts =
  load: (callback, currency) ->
    $.ajax
      type: 'GET'
      dataType: 'json'
      async: false
      url: $('#path').data('accounts')
      data: '' ||  { currency: currency }
      success: callback
    return

  loadOption: ->
    Accounts.load (accounts) ->
      $companyAccount = $('.company_accounts[data-status=new]')
      page = $companyAccount.data('page')
      path = $companyAccount.data('path')
      if $.isEmptyObject(accounts)
        $('#select_account').html '<a data-remote=\'true\' href=' + path + '?page=' + page + ' type=\'get\'>' + I18n.t('money.accounts.accounts_info') + '</a>'
      else
        $.each accounts, ->
          $companyAccount.append '<option value=' + @value + '>' + @text + '</option>'
          return
        $('#select_account').prepend '<a data-remote=\'true\' href=' + path + '?page=' + page + ' type=\'get\'>' + I18n.t('contract.add_new') + '</a>'
        $companyAccount.attr 'data-status', 'old'
      return
    return

  validateFormForNewAccount: ->
    $('#new_account').validate
      errorElement: 'div'
      errorPlacement: (error, element) ->
        error.insertBefore element
        return
      rules:
        'account[name]': required: true
        'account[number]': required: true
      messages:
        'account[name]': required: I18n.t('validation.errors.cant_be_blank')
        'account[number]': required: I18n.t('validation.errors.cant_be_blank')
    return

  loadPlugins: ->
    $('input.number').numeric
      negative: false
      decimal: false
    $('#new_account').hide()
    Accounts.validateFormForNewAccount()
    return

  xeditableLoadSource: ->
    Accounts.load (accounts) ->
      $('.change_account[data-status=new]').each ->
        $(this).editable
          type: 'select2'
          source: accounts
          ajaxOptions:
            type: 'PUT'
            dataType: 'json'
          params: xeditableParams
        $(this).attr 'data-status', 'old'
        return
      return
    return

  accountsOnType: ($selector) ->
    currency = $selector.data 'currency'
    Accounts.load ((accounts) ->
      if $.isEmptyObject(accounts)
        if $selector.data('currency') == 'UAH'
          $selector.after '<div class="error">' + I18n.t('money.accounts.accounts_grn') + '</div>'
        else
          $selector.after '<div class="error">' + I18n.t('money.accounts.accounts_foreign_currency') + '</div>'
        $selector.remove()
      else
        $.each accounts, ->
          $selector.append '<option value=' + @value + '>' + @text + '</option>'
          return
      $selector.attr 'data-status', 'old'
      return
    ), currency
