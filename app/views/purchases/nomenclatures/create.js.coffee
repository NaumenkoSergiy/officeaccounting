if '<%= flash[:error] %>'
  $('#nomenclatures .notification.error').show().text('<%= flash[:error] %>').fadeOut(5000)
else
  Nomenclature.loadTable('<%=params[:nomenclature][:type] %>'.replace('Nomenclature::', '#').toLowerCase())
  $('#new_nomenclature')[0].reset()
  $('#nomenclature_type').select2('val', '<%=params[:nomenclature][:type] %>')
  editableStart()
