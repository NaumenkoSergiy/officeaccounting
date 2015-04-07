window.AccountingAccount =
  load: (callback, type='') ->
    $.ajax
      type: 'GET'
      dataType: 'json'
      async: false
      url: $('#path').data('accounting-account')
      data: { type: type }
      success: callback
    return

  loadOption: (selector, type)->
    AccountingAccount.load ((accounts) ->
      $accountingAccount = selector
      $.each accounts, ->
        option = new Option(@text, @value)
        $accountingAccount.append option
        return
      AccountingAccount.loadSubOption($('select.parent_account > option:selected').text())
      $accountingAccount.attr 'data-status', 'old'
    ), type

  loadSubOption: (value) ->
    options = []
    for i in [1...4]
      option = new Option(value + i, value + i)
      options.push option

    $('select#accounting_account_account_number').html(options).select2('val', options[0].value)

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
    openForm('new_accounting_account', 'accounting_account_new')
    editableStart()
    setNumeric()
    AccountingAccount.validateFormForNewAccountingAccount()
    AccountingAccount.initTreeTable()
    AccountingAccount.changeParentAccount()
    $('.sub_account').on 'click', ->
      AccountingAccount.showSubAccount()

  changeParentAccount: ->
    $('select.parent_account').on 'change', ->
      AccountingAccount.loadSubOption($('select.parent_account > option:selected').text())

  initTreeTable: ->
    $table = $('#accounting_tree')
    $table.treetable
      expandable: true
      onNodeCollapse: ->
        $('[data-tt-parent-id=' + @id + ']').hide()
      onNodeExpand: ->
        node = @
        if @row.next().is("[data-tt-parent-id]") && @id == @row.next().data('tt-parent-id')
          $('[data-tt-parent-id=' + node.id + ']').show()
        else
          $.ajax(
            async: false
            url: $('#path').data('accounting-account') + '/' + node.id).done (html) ->
              rows = $(html).filter('tr')
              $table.treetable('loadBranch', node, rows)
          editableStart()
    return

  showSubAccount: ->
    if $('.sub_account').is(':checked')
      $('#bookeeper_account').hide()
      $('#sub_account_number').removeClass('hidden')
      $('select.parent_account').attr('name', 'accounting_account[parent_id]')
      $('select#accounting_account_account_number').attr('name', 'accounting_account[account_number]')
    else
      $('#sub_account_number').addClass('hidden')
      $('select.parent_account').attr('name', '')
      $('select#accounting_account_account_number').attr('name', '')
      $('#bookeeper_account').show()

  loadAccount_number: ->
    $('#parent_select').html '<select name="accounting_account[parent_id]" class="parent_account" data-status="new" data-select="false"></select>'
    AccountingAccount.changeParentAccount()
    AccountingAccount.loadSubOption($('select.parent_account > option:selected').text())

  xeditable: ->
    AccountingAccount.load ((accounts) ->
      $('.change_accounting_accounts[data-status=new]').each ->
        $(this).editable
          type: 'select2'
          select2: 'width': '150px'
          source: accounts
          ajaxOptions:
            type: 'PUT'
            dataType: 'json'
          params: xeditableParams
        $(this).attr 'data-status', 'old'
    ), 'children'
