if '<%= flash[:error] %>'
  $('#employees .notification.error, #employees_modal .notification.error').show().text('<%= flash[:error] %>').fadeOut(5000)
else
  $('#employees_modal_list').html('<%= j(render "personnels/employees/list") %>')
  $('#employees_list').html('<%= j(render "personnels/employees/list") %>')
  i = 0
  while i < $('.new_employee').length
    $('.new_employee')[i].reset()
    i += 1
  $('#employee_personnel_number').val('<%= @personnel_number + 1 %>')
  $('#new_employee').hide()
  editableStart()
  Employee.convertEmployeeNumber()
