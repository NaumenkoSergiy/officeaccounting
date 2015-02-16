function getAllAccounts() {
  id = $('.company_accounts').data('id');
  page = $('.company_accounts').data('page');
  $.ajax({
    type: 'GET',
    url: '/money/accounts/',
    data: { id: id },
    success: function(r) {
      if (r.data.length == 0 ) {
        $('#select_account')[0].innerHTML = "<a data-remote='true' href='/money/accounts/new?page=" + page + "' type='get'>" + I18n.t('money.accounts.accounts_info') + "</a>";
      } else {
        $.each(r.data, function(i, data) {
          v = r.data[i];
          $('.company_accounts').append('<option value=' + v.id + '>' + v.number + '</option>');
        });
        $('#select_account').prepend("<a data-remote='true' href='/money/accounts/new?page=" + page + "' type='get'>" + I18n.t('contract.add_new') + "</a>");
        $('.company_accounts').select2();
      }
    }
  });
}
