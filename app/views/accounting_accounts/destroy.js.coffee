if '<%= flash[:error] %>'
  $('#accounting_accounts .notification.error').show().text('<%= flash[:error] %>').fadeOut(5000)
else
  $('.accounting_account_<%= params[:id] %>').remove()
