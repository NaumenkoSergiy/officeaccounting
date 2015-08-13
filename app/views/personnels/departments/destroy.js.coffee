if '<%= flash[:error] %>'
  $('#departments .notification.error, #departments_modal .notification.error').show().text('<%= flash[:error] %>').fadeOut(5000)
else
  $('.department_<%= params[:id] %>').remove()
