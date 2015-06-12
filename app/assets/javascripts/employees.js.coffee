window.Employee =
  convertEmployeeNumber: ->
    personnelNumber = $('.employee_personnel_number').val()
    length = 6
    lengthEmployeeNumber = personnelNumber.length
    countForAdd = length - lengthEmployeeNumber
    i = 0
    while i < countForAdd
      personnelNumber = '0' + personnelNumber
      i++
    $('.employee_personnel_number').val(personnelNumber)

  loadPlugins: ->
    editableStart()

    $('#employee_date_birth_, #employee_date_birth_modal').datepicker(
      maxDate: 0
      changeMonth: true
      changeYear: true
      yearRange: 'c-100:c+1').change 'changeDate', ->
      $(this).valid()
      return

    $('#employee_start_date_, #employee_start_date_modal').datepicker(
      minDate: 0
      changeMonth: true
      changeYear: true
      yearRange: 'c-100:c+1').change 'changeDate', ->
      $(this).valid()
      return

    $('input.number').numeric
      negative: false
      decimal: false
    return
