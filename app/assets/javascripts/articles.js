var Articles = {
  load: function() {
    page = $('.articles').data('page');
    $.ajax({
      type: 'GET',
      url: '/money/articles/',
      data: { page: page },
      success: function(r) {
        if (r.length == 0 ) {
          $('#select_article').html(I18n.t('money.article_info'));
        } else {
          $.each(r, function(i) {
            v = r[i];
            $('.articles').append('<option value=' + v.id + '>' + v.name + '</option>');
          });
          $('.articles').select2();
        }
      }
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
