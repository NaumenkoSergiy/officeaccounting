if '<%= flash[:error] %>'
  $('#accounting_accounts .notification.error').show().text('<%= flash[:error] %>').fadeOut(5000)
else
  $('#accounting_accounts_list').html('<%= j(render "accounting_accounts/list") %>')
  $('#new_accounting_account').hide()[0].reset();
  editableStart()
