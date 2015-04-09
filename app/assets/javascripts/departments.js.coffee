window.Department =
  validateFormForNewDepartment: ->
    $('#new_department').validate
      errorElement: 'div'
      errorPlacement: (error, element) ->
        error.insertBefore element
        return
      rules:
        'department[name]': required: true
      messages:
        'department[name]': required: I18n.t('validation.errors.cant_be_blank')
    return

  loadPlugins: ->
    editableStart()
    Department.validateFormForNewDepartment()
    return
