if '<%= flash[:error] %>'
  $('#departments .notification.error').show().text('<%= flash[:error] %>').fadeOut(5000)
else
  $('#departments_list').html('<%= j(render "personnels/departments/list") %>')
  $('#new_department')[0].reset();
  editableStart()
