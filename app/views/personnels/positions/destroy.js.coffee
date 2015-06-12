if '<%= flash[:error] %>'
  $('#positions .notification.error, #positions_modal .notification.error').show().text('<%= flash[:error] %>').fadeOut(5000)
else
  $('.position_<%= params[:id] %>').remove()
