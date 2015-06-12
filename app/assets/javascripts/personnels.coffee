
PersonnelsController = Paloma.controller('Personnels')
PersonnelsController::index = ->
  $.ajax
    type: 'GET'
    url: $('#path').data('employees')

window.Personel =
  initTabs: ->
    $("#personels_tabs li a").on 'click', ->
      data = $(@).attr('href').substr(1)
      $.ajax
        type: 'GET'
        url: $('#path').data(data)
    $("#personels_tabs").removeClass('init')
