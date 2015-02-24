var Banks = {
  loadBanks: function(callback) {
    $.ajax({
      type: 'GET',
      url: '/money/banks/',
      success: callback
    });
  },

  loadOption: function() {
    $('.banks[data-type=new]').attr('data-type', 'old');
    Banks.loadBanks(function(banks) {
      $.each(banks, function(i) {
        bank = banks[i];
        $('.banks').append('<option value=' + bank.value + '>' + bank.text + '</option>');
      });
      $('.banks[data-type=old]').select2();  
    });
  },

  validateFormForNewBank: function() {
    $('#new_bank').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        "bank[name]": { required: true },
        "bank[code_edrpo]": { required: true },
        "bank[mfo]": { required: true },
        "bank[lawyer_adress]": { required: true }
      },
      messages: {
        "bank[name]": { required: I18n.t('validation.errors.cant_be_blank') },
        "bank[code_edrpo]": { required: I18n.t('validation.errors.cant_be_blank') },
        "bank[mfo]": { required: I18n.t('validation.errors.cant_be_blank') },
        "bank[lawyer_adress]": { required: I18n.t('validation.errors.cant_be_blank') }
      }
    });
  },

  xeditableBanks: function() {
    Banks.loadBanks(function(banks) {
      $('.change_bank').editable({
        type: 'select2',
        source: banks,
        ajaxOptions: {
          type: "PUT",
          dataType: "json"
        },
        params: xeditableParams
      });
    });
  }
}
