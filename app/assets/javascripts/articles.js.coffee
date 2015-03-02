window.Articles = 
  load: (callback) ->
    $.ajax
      type: 'GET'
      dataType: 'json'
      async: false
      url: $('#path').data('articles')
      success: callback
    return

  loadOption: ->
    Articles.load (articles) ->
      if $.isEmptyObject(articles)
        $('#select_article').html I18n.t('money.article_info')
      else
        $.each articles, ->
          $('.articles').append '<option value=' + @value + '>' + @text + '</option>'
          return
      return
    return

  xeditable: ->
    Articles.load (articles) ->
      $('.change_article[data-status=new]').each ->
        $(this).editable
          type: 'select2'
          select2: 'width': '300px'
          source: articles
          ajaxOptions:
            type: 'PUT'
            dataType: 'json'
          params: xeditableParams
        $(this).attr 'data-status', 'old'
        return
      return
    return
    
  validateFormForNewArticle: ->
    $('#new_article').validate
      errorElement: 'div'
      errorPlacement: (error, element) ->
        error.insertBefore element
        return
      rules: 'article[name]': required: true
      messages: 'article[name]': required: I18n.t('validation.errors.cant_be_blank')
    return
