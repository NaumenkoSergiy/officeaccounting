if '<%= flash[:error] %>'
  $('#companyBanks .notification.error').show().text('<%= flash[:error] %>').fadeOut(5000)
else
  $(".bank_<%= params[:id] %>").remove()
