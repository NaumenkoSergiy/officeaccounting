if '<%= flash[:error] %>'
  $('#departments .notification.error, #departments_modal .notification.error').show().text('<%= flash[:error] %>').fadeOut(5000)
else
  $('#departments_modal_list').html('<%= j(render "personnels/departments/list") %>')
  $('#departments_list').html('<%= j(render "personnels/departments/list") %>')
  i = 0
  while i < $('.new_department').length
    $('.new_department')[i].reset()
    i += 1
  editableStart()
