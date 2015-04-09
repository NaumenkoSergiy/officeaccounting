$('#departments').html("<%= j render_modal_window(t('personnels.department'),
                                                  'departments_form',
                                                  'departments_list', '') %>").modal('show')
$('#departments_form').html("<%= j render 'personnels/departments/form' %>")
$('#departments_list').html("<%= j render 'personnels/departments/list' %>")
Department.loadPlugins()
