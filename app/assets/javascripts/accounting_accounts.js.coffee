window.AccountingAccount =
  validateFormForNewAccountingAccount: ->
    $('#new_accounting_account').validate
      errorElement: 'div'
      errorPlacement: (error, element) ->
        error.insertBefore element
        return
      rules:
        'accounting_account[name]': required: true
        'accounting_account[account_number]': required: true
      messages:
        'accounting_account[name]': required: I18n.t('validation.errors.cant_be_blank')
        'accounting_account[account_number]': required: I18n.t('validation.errors.cant_be_blank')
    return

  loadPlugins: ->
    $('input.number').numeric
      negative: false
      decimal: false
    openForm('new_accounting_account', 'accounting_account_new')
    editableStart()
    AccountingAccount.validateFormForNewAccountingAccount()
    return
