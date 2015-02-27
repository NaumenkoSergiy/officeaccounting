var Accounts = {
  load: function(callback) {
    $.ajax({
      type: 'GET',
      url: $('#path').data('accounts'),
      data: { page: '' },
      success: callback
    });
  },

  loadOption: function() {
    Accounts.load(function(accounts) {
      $companyAccount = $('.company_accounts');
      var id = $companyAccount.data('id');
      var page = $companyAccount.data('page');
      var path = $companyAccount.data('path');
      if (accounts.length == 0 ) {
        $('#select_account').html("<a data-remote='true' href=" + path + "?page=" + page +
          " type='get'>" + I18n.t('money.accounts.accounts_info') + "</a>");
      } else {
        $.each(accounts, function() {
          $companyAccount.append('<option value=' + this.value + '>' + this.text + '</option>');
        });
        $('#select_account').prepend("<a data-remote='true' href=" + path + "?page=" + page +
          " type='get'>" + I18n.t('contract.add_new') + "</a>");
        $companyAccount.select2();
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
  },

  xeditableLoadSource: function() {
     Accounts.load(function(accounts) {
      $('.change_account[data-status=new]').each(function() {
        $(this).editable({
          type: 'select2',
          source: accounts,
          ajaxOptions: {
            type: "PUT",
            dataType: "json"
          },
          params: xeditableParams
        });
      $(this).attr('data-status', 'old');
      });
    });
  }
};
