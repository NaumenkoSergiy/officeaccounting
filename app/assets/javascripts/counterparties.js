var Counterparties = {
  loadPluginsCounterparty: function() {
    $('input.number').numeric({ negative : false, decimal: false });
    Counterparties.validateFormForNewCounterparty();
  },

  loadOption: function() {
    selector = $('.company_counterparties[data-type=new]')
    var id = selector.data('id');
    var page = selector.data('page');
    var path = selector.data('path');

    $.ajax({
      type: 'GET',
      url: '/purchases/counterparties/',
      data: { id: id },
      success: function(r) {
        if (r.length == 0) {
           selector.parent().html("<a data-remote='true' href=" + path + "?page=" + page +
             " type='get'>" + I18n.t('contract.counterparty_info') + "</a>");
        } else {
          $.each(r, function(i, data) {
            v = r[i];
            selector.append('<option value=' + v.id + '>' + v.name + '</option>');
          });
          selector.before("<a data-remote='true' href=" + path + "?page=" + page +
              " type='get'>" + I18n.t('contract.counterparty_add') + "</a>");
          if($("#contracts").length && $('#costs').hasClass('fade in')) { 
            $('#contracts a[data-remote]').remove();
          }
          selector.attr('data-type', 'old');
          $('.company_counterparties[data-type=old]').select2();
          Contracts.loadContract();
        }
      }
    });
  },

  validateFormForNewCounterparty: function() {
    $('#new_counterparty').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        "counterparty[title]": { required: true },
        "counterparty[name]": { required: true },
        "counterparty[edrpo]": { required: true },
        "counterparty[adress]": { required: true },
        "counterparty[account]": { required: true },
        "counterparty[mfo]": { required: true }
      },
      messages: {
        "counterparty[title]": { required: I18n.t('validation.errors.cant_be_blank') },
        "counterparty[name]": { required: I18n.t('validation.errors.cant_be_blank') },
        "counterparty[edrpo]": { required: I18n.t('validation.errors.cant_be_blank') },
        "counterparty[adress]": { required: I18n.t('validation.errors.cant_be_blank') },
        "counterparty[account]": { required: I18n.t('validation.errors.cant_be_blank') },
        "counterparty[mfo]": { required: I18n.t('validation.errors.cant_be_blank') }
      }
    });
  },

  checkResident: function() {
    $('.counterparty_resident').click(function() {
      id = $(this).data('id');
      $.ajax({
        type: 'PUT',
        url: '/purchases/counterparties/' + id,
        data: { counterparty: { resident: $(this).is(':checked') } },
      });
    })
  }
};
