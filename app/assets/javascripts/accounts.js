var Accounts = {
  load: function() {
    var companyAccount = $('.company_accounts');
    var id = companyAccount.data('id');
    var page = companyAccount.data('page');
    var path = companyAccount.data('path');

    $.ajax({
      type: 'GET',
      url: '/money/accounts/',
      data: { company_id: id },
      success: function(r) {
        if (r.length == 0 ) {
          $('#select_account').html("<a data-remote='true' href=" + path + "?page=" + page +
            " type='get'>" + I18n.t('money.accounts.accounts_info') + "</a>");
        } else {
          $.each(r, function(i) {
            v = r[i];
            $('.company_accounts').append('<option value=' + v.id + '>' + v.number + '</option>');
          });
          $('#select_account').prepend("<a data-remote='true' href=" + path + "?page=" + page +
            " type='get'>" + I18n.t('contract.add_new') + "</a>");
          $('.company_accounts').select2();
        }
      }
    });
  },

  validateFormForNewAccount: function() {
    $('#new_account').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        "account[name]": { required: true },
        "account[number]": { required: true }
      },
      messages: {
        "account[name]": { required: I18n.t('validation.errors.cant_be_blank') },
        "account[number]": { required: I18n.t('validation.errors.cant_be_blank')}
      }
    });
  },

  loadPlugins: function() {
    $('#account_account_type, #account_currency').select2();
    $('input.number').numeric({ negative : false, decimal: false });
    $('#new_account').hide();
    Accounts.validateFormForNewAccount();
  }
};
