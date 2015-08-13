if "<%= params[:container] %>" == 'modal'
  $('#departments_modal').html("<%= j render_modal_window(t('personnels.departments'),
                                                  'departments_modal_form',
                                                  'departments_modal_list', '') %>").modal('show')
  $('#departments_modal_form').html("<%= j render 'personnels/departments/form' %>")
  $('#departments_modal_list').html("<%= j render 'personnels/departments/list' %>")
else
  $('#departments').html("<%= j render 'personnels/departments/departments' %>")
  $('#departments_form').html("<%= j render 'personnels/departments/form' %>")
  $('#departments_list').html("<%= j render 'personnels/departments/list' %>")
Department.loadPlugins()
