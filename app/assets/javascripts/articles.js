function getAllArticles() {
  page = $('.articles').data('page');
  $.ajax({
    type: 'GET',
    url: '/money/articles/',
    data: { page: page },
    success: function(r) {
      if (r.data.length == 0 ){
        $('#select_article')[0].innerHTML = "<a data-remote='true' href='/money/articles/new?page=" + page + "' type='get'>" + I18n.t('money.accounts.accounts_info') + "</a>";
      } else {
        $.each(r.data, function(i, data) {
          v = r.data[i];
          $('.articles').append('<option value=' + v.id + '>' + v.name + '</option>');
        });
        $('.articles').select2();
      }
    }
  });
}
