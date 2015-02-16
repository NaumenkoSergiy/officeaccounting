var Counterparties = {
  loadPluginsCounterparty: function() {
    $('#counterparty_bank_id').select2({ width: '100%' });
    $('input.number').numeric({ negative : false, decimal: false });
    Counterparties.validCounterparty();
  },

  getAllCounterparties: function(selector) {
    id = $(selector).data('id');
    page = $(selector).data('page');

    $.ajax({
      type: 'GET',
      url: '/purchases/counterparties/',
      data: { id: id },
      success: function(r) {
        if (r.data.length == 0) {
           $(selector).parent().html("<a data-remote='true' href='/purchases/counterparties/new?page=" + page + "' type='get'>" + I18n.t('contract.counterparty_info') + "</a>");
        } else {
          $.each(r.data, function(i, data) {
            v = r.data[i];
            $(selector).append('<option value=' + v.id + '>' + v.name + '</option>');
          });
          $(selector).before("<a data-remote='true' href='/purchases/counterparties/new?page=" + page + "' type='get'>" + I18n.t('contract.counterparty_add') + "</a>");
          $(selector).select2();
          Contracts.loadContract();
        }
      }
    });
  },

  validCounterparty: function() {
    $('#new_counterparty').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        "counterparty[title]": {
          required: true
        },
        "counterparty[name]": {
          required: true
        },
        "counterparty[edrpo]": {
          required: true
        },
        "counterparty[adress]": {
          required: true
        },
        "counterparty[account]": {
          required: true
        },
        "counterparty[mfo]": {
          required: true
        }
      },
      messages: {
        "counterparty[title]": {
          required: I18n.t('validation.errors.cant_be_blank')
        },
        "counterparty[name]": {
          required: I18n.t('validation.errors.cant_be_blank')
        },
        "counterparty[edrpo]": {
          required: I18n.t('validation.errors.cant_be_blank')
        },
        "counterparty[adress]": {
          required: I18n.t('validation.errors.cant_be_blank')
        },
        "counterparty[account]": {
          required: I18n.t('validation.errors.cant_be_blank')
        },
        "counterparty[mfo]": {
          required: I18n.t('validation.errors.cant_be_blank')
        }
      }
    });
  },

  checkResident: function() {
    $('.counterparty_resident').click(function() {
      id = $(this).data('id');
      $.ajax({
        type: 'PUT',
        url: '/purchases/counterparties/' + id,
        data: {counterparty: {resident: $(this).is(':checked')}},
      });
    })
  }
};
