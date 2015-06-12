if "<%= params[:container] %>" == 'modal'
  $('#employees_modal').html("<%= j render 'personnels/employees/employees_modal' %>").modal('show')
  $('#employees_modal_form').html("<%= j render 'personnels/employees/form' %>")
  $('#employees_modal_list').html("<%= j render 'personnels/employees/list' %>")
  openForm('new_employee_modal', 'add_new_employee_modal')
else
  $('#employees').html("<%= j render 'personnels/employees/employees' %>")
  $('#employees_form').html("<%= j render 'personnels/employees/form' %>")
  $('#employees_list').html("<%= j render 'personnels/employees/list' %>")
  openForm('new_employee_', 'add_new_employee')
Employee.loadPlugins()
Employee.convertEmployeeNumber()
