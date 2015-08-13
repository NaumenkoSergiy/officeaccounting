if '<%= flash[:error] %>'
  $('#positions_modal .notification.error, #positions .notification.error').show().text('<%= flash[:error] %>').fadeOut(5000)
else
  $('#positions_modal_list').html('<%= j(render "personnels/positions/list") %>')
  $('#positions_list').html('<%= j(render "personnels/positions/list") %>')
  i = 0
  while i < $('.new_position').length
    $('.new_position')[i].reset()
    i += 1
  editableStart()
