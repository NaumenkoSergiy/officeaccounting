window.MainTool =
  load: (callback, type, dataType) ->
    $.ajax
      type: 'GET'
      dataType: dataType
      async: false
      url: $('#path').data('main-tools')
      data: '' ||  { type: type }
      success: callback
    return

  validateFormForNewMainTool: ->
    $('#new_main_tool').validate
      errorElement: 'div'
      errorPlacement: (error, element) ->
        error.insertBefore element
        return
      rules:
        'main_tool[title]': required: true
        'main_tool[date]': required: true
        'main_tool[serial_number]': required: true
        'main_tool[main_tool[brand]]': required: true
      messages:
        'main_tool[title]': required: I18n.t('validation.errors.cant_be_blank')
        'main_tool[date]': required: I18n.t('validation.errors.cant_be_blank')
        'main_tool[serial_number]': required: I18n.t('validation.errors.cant_be_blank')
        'main_tool[main_tool[brand]]': required: I18n.t('validation.errors.cant_be_blank')
    return

  loadPlugins: ->
    $('#main_tool_date').datepicker({changeMonth: true, changeYear: true})
    openForm('new_main_tool', 'main_tools_new')
    editableStart()
    MainTool.validateFormForNewMainTool()
    MainTool.initTabs()
    $('.new_tool').click ->
      $('form#new_main_tool').toggle()
    return

  loadTable: (id) ->
    type = $('[href=' + id + ']').attr('data-type')
    MainTool.load ((html) ->
      $(id).html html
      editableStart()
    ), type, 'html'

  initTabs: ->
    $("#main_tools_tabs li a").on 'click', ->
      $('#main_tool_type').select2('val', $(@).attr('data-type'))
      id = $(@).attr('href')
      unless $(id).children().is('table')
        MainTool.loadTable(id)
        $('.new_tool').click ->
          $('form#new_main_tool').toggle()
