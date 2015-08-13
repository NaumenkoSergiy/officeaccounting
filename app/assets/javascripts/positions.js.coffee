window.Position =
  load: (callback) ->
    $.ajax
      type: 'GET'
      dataType: 'json'
      async: false
      url: $('#path').data('positions')
      success: callback
    return

  loadOption: ->
    Position.load (positions) ->
      $position = $('.positions[data-status=new]')
      if $.isEmptyObject(positions)
        $('#position_select').html(I18n.t('info.empty')).css({ 'color':'red' })
      else
        $.each positions, ->
          option = new Option(@text, @value)
          $position.append option
          return
        $position.attr 'data-status', 'old'

  loadPlugins: ->
    editableStart()
    return

  xeditablePositions: ->
    Position.load (positions) ->
      $('.change_position').editable
        type: 'select2'
        source: positions
        ajaxOptions:
          type: 'PUT'
          dataType: 'json'
        params: xeditableParams
      return
    return
