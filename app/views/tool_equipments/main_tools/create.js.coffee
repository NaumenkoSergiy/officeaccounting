if '<%= flash[:error] %>'
  $('#main_tools .notification.error').show().text('<%= flash[:error] %>').fadeOut(5000)
else
  MainTool.loadTable('<%=params[:main_tool][:type] %>'.replace('MainTool::', '#').toLowerCase())
  $('#new_main_tool').hide()[0].reset()
  $('#main_tool_type').select2('val', '<%=params[:main_tool][:type] %>')
  editableStart()
