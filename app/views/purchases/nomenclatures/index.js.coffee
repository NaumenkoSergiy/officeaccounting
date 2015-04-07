$('#nomenclatures').html('<%= j render_modal_window(t("purchases.nomenclature"),
                                                   "nomenclatures_form",
                                                   "nomenclatures_list",
                                                   "nomenclatures_new",
                                                   "#{render "purchases/nomenclatures/tabs"}") %>').modal('show')
$('#nomenclatures_tabs li:first').addClass('active')
$('#nomenclatures_list').html('<%= j render "purchases/nomenclatures/list" %>')
$('#nomenclatures_form').html('<%= j render "purchases/nomenclatures/form" %>')
$('#equipment').html('<%= j(render file: "purchases/nomenclatures/index.slim") %>')
Nomenclature.loadPlugins()
