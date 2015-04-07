$('<%=params[:type] %>'.replace('MainTool::', '#').toLowerCase()).html('<%= j(render file: "tool_equipments/main_tools/index.html") %>')
editableStart()
