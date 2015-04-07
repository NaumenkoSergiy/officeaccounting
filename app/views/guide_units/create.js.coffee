if '<%= flash[:error] %>'
  $('#guide_units .notification.error').show().text('<%= flash[:error] %>').fadeOut(5000)
else
  $('#guide_units_list').html('<%= j(render "guide_units/list") %>')
  $('#new_guide_unit').hide()[0].reset();
editableStart()
