window.Department =
  load: (callback) ->
    $.ajax
      type: 'GET'
      dataType: 'json'
      async: false
      url: $('#path').data('departments')
      success: callback
    return

  loadOption: ->
    Department.load (departments) ->
      $department = $('.departaments[data-status=new]')
      if $.isEmptyObject(departments)
        $('#departament_select').html(I18n.t('info.empty')).css({ 'color':'red' })
      else
        $.each departments, ->
          option = new Option(@text, @value)
          $department.append option
          return
        $department.attr 'data-status', 'old'

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

  xeditableDepartments: ->
    Department.load (departments) ->
      $('.change_department').editable
        type: 'select2'
        source: departments
        ajaxOptions:
          type: 'PUT'
          dataType: 'json'
        params: xeditableParams
      return
    return
