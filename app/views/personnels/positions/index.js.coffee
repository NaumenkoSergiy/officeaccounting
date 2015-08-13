if "<%= params[:container] %>" == 'modal'
  $('#positions_modal').html("<%= j render_modal_window(t('personnels.positions'),
                                                  'positions_modal_form',
                                                  'positions_modal_list', '') %>").modal('show')
  $('#positions_modal_form').html("<%= j render 'personnels/positions/form' %>")
  $('#positions_modal_list').html("<%= j render 'personnels/positions/list' %>")
else
  $('#positions').html("<%= j render 'personnels/positions/positions' %>")
  $('#positions_form').html("<%= j render 'personnels/positions/form' %>")
  $('#positions_list').html("<%= j render 'personnels/positions/list' %>")
Position.loadPlugins()
