$('<%=params[:type] %>'.replace('Nomenclature::', '#').toLowerCase()).html('<%= j(render file: "purchases/nomenclatures/index.slim") %>')
editableStart()
