$('#accounting_accounts').html('<%= j render_modal_window(t("accounting_accounts"),
                                                          "accounting_accounts_form",
                                                          "accounting_accounts_list",
                                                          "accounting_account_new") %>').modal('show')
$('#accounting_accounts_form').html('<%= j render "accounting_accounts/form" %>')
$('#accounting_accounts_list').html('<%= j render "accounting_accounts/list" %>')
AccountingAccount.loadPlugins()
AccountingAccount.showSubAccount()
