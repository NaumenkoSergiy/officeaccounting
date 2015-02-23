var Articles = {
  load: function(callback) {
    $.ajax({
      type: 'GET',
      url: '/money/articles/',
      data: { page: '' },
      success: callback
    });
  },

  loadOption: function() {
    Articles.load(function(r) {
      if (r.length == 0 ) {
        $('#select_article').html(I18n.t('money.article_info'));
      } else {
        $.each(r, function(i) {
          v = r[i];
          $('.articles').append('<option value=' + v.value + '>' + v.text + '</option>');
        });
        $('.articles').select2();
      }
    });
  },

  xeditable: function() {
    Articles.load(function(r) {
      $('.change_article[data-status=new]').each(function() {
        $(this).editable({
          type: 'select2',
          select2: { 'width':'300px' },
          source: r,
          ajaxOptions: {
            type: "PUT",
            dataType: "json"
          },
          params: xeditableParams
        });
      $(this).attr('data-status', 'old');
      });
    });
  },

  validateFormForNewArticle: function() {
    $('#new_article').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        "article[name]": { required: true }
      },
      messages: {
        "article[name]": { required: I18n.t('validation.errors.cant_be_blank') }
      }
    });
  }
};
