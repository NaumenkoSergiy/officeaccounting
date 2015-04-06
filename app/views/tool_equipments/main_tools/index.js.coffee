$('#main_tools').html('<%= j render_modal_window(t("tool_equipments.main_tools"),
                                                   "main_tools_form",
                                                   "main_tools_list",
                                                   "main_tools_new",
                                                   "#{render "tool_equipments/main_tools/tabs"}") %>').modal('show')
$('#main_tools_form').html('<%= j render "tool_equipments/main_tools/form" %>')
$('#main_tools_list').html('<%= j render "tool_equipments/main_tools/list" %>')
$('#building').html('<%= j(render file: "tool_equipments/main_tools/index.html") %>')
MainTool.loadPlugins()
