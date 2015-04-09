window.Nomenclature =
  load: (callback, type, dataType) ->
    $.ajax
      type: 'GET'
      dataType: dataType
      async: false
      url: $('#path').data('nomenclatures')
      data: '' ||  { type: type }
      success: callback
    return

  validateFormForNewNomenclature: ->
    $('#new_nomenclature').validate
      errorElement: 'div'
      errorPlacement: (error, element) ->
        error.insertBefore element
        return
      rules:
        'nomenclature[title]': required: true
      messages:
        'nomenclature[title]': required: I18n.t('validation.errors.cant_be_blank')

  loadPlugins: ->
    editableStart()
    Nomenclature.validateFormForNewNomenclature()
    Nomenclature.initTabs()
    $('#nomenclatures_new').remove()

  loadTable: (id) ->
    type = $('[href=' + id + ']').attr('data-type')
    Nomenclature.load ((html) ->
      $(id).html html
      editableStart()
    ), type, 'html'

  initTabs: ->
    $("#nomenclatures li a").on 'click', ->
      $('#nomenclature_type').select2('val', $(@).attr('data-type'))
      id = $(@).attr('href')
      unless $(id).children().is('table')
        Nomenclature.loadTable(id)
