window.GuideUnits =
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
