$('#guide_units').html("<%= j render_modal_window(t('guide_units'),
                                                  'guide_units_form',
                                                  'guide_units_list',
                                                  'guide_units_new') %>").modal('show')
$('#guide_units_form').html("<%= j render 'guide_units/form' %>")
$('#guide_units_list').html("<%= j render 'guide_units/list' %>")
GuideUnits.loadPlugins()
