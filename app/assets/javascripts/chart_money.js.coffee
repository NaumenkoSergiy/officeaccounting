window.setCharts = ->
  $.ajax
    type: 'GET'
    url: '/money/registers/'
    cache: false
    async: false
    dataType: 'json'
    success: (data) ->
      chart = AmCharts.makeChart('chart_money', {
        'theme': 'light'
        'type': 'serial'
        'startDuration': 2
        'dataProvider': data
        'valueAxes': [ { 'position': 'left' } ]
        'graphs': [
          {
            'title': I18n.t('buttons.spending')
            'balloonText': '[[category]]: <b>[[costs]]</b>'
            'color': 'color2'
            'fillAlphas': 0.85
            'colorField': 'color2'
            'lineAlpha': 0.1
            'type': 'column'
            'topRadius': 1
            'valueField': 'costs'
            'fillColors': '#FF0F00'
          }
          {
            'title': I18n.t('buttons.income')
            'balloonText': '[[category]]: <b>[[income]]</b>'
            'color': 'color1'
            'fillAlphas': 0.85
            'colorField': 'color1'
            'lineAlpha': 0.1
            'type': 'column'
            'topRadius': 1
            'valueField': 'income'
            'fillColors': '#04D215'
          }
        ]
        'legend':
          'useGraphSettings': true
          'align': 'center'
        'depth3D': 40
        'angle': 30
        'chartCursor':
          'categoryBalloonEnabled': false
          'cursorAlpha': 0
          'zoomable': false
        'categoryField': 'month'
        'categoryAxis':
          'gridPosition': 'start'
          'axisAlpha': 0
          'gridAlpha': 0
        'exportConfig':
          'menuTop': '20px'
          'menuRight': '20px'
          'menuItems': [ {
            'icon': 'export.png'
            'format': 'png'
          } ]
      }, 0)

      $('.chart-input').off().on 'input change', ->
        property = $(this).data('property')
        target = chart
        target1 = chart
        chart.startDuration = 0
        if property == 'topRadius'
          target = chart.graphs[0]
          target1 = chart.graphs[1]
        target[property] = @value
        target1[property] = @value
        chart.validateNow()
        return
      return
  return
