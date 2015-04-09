window.GuideUnits =
  load: (callback) ->
    $.ajax
      type: 'GET'
      dataType: 'json'
      async: false
      url: $('#path').data('guide-units')
      success: callback
    return

  loadOption: ->
    GuideUnits.load (guideUnits) ->
      $guideUnit = $('.guide_units[data-status=new]')
      if $.isEmptyObject(guideUnits)
        $('#guide_unit_select').html(I18n.t('info.empty')).css({ 'color':'red' })
      else
        $.each guideUnits, ->
          option = new Option(@text, @value)
          $guideUnit.append option
          return
        $guideUnit.attr 'data-status', 'old'

  validateFormForNewGuideUnits: ->
    $('#new_guide_unit').validate
      errorElement: 'div'
      errorPlacement: (error, element) ->
        error.insertBefore element
        return
      rules:
        'guide_unit[name]': required: true
      messages:
        'guide_unit[name]': required: I18n.t('validation.errors.cant_be_blank')
    return

  loadPlugins: ->
    openForm('new_guide_unit', 'guide_units_new')
    editableStart()
    GuideUnits.validateFormForNewGuideUnits()
    return

  xeditable: ->
    GuideUnits.load (guideUnits) ->
      $('.change_guide_units[data-status=new]').each ->
        $(this).editable
          type: 'select2'
          select2: 'width': '150px'
          source: guideUnits
          ajaxOptions:
            type: 'PUT'
            dataType: 'json'
          params: xeditableParams
        $(this).attr 'data-status', 'old'
        return
      return
    return
