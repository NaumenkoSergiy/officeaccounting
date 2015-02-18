var Contracts = {
  validateFormForNewContract: function() {
    $('#new_contract').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        "contract[date]": { required: true },
        "contract[number]": { required: true },
        "contract[validity]": { required: true }
      },
      messages: {
        "contract[date]": { required: I18n.t('validation.errors.cant_be_blank') },
        "contract[number]": { required: I18n.t('validation.errors.cant_be_blank') },
        "contract[validity]": { required: I18n.t('validation.errors.cant_be_blank') }
      }
    });
  },

  loadContract: function() {
    $('#money_register_counterparty_id').change(function() {
      var id = $(this).val();
      var page = $(this).data('page');
      var path = $(this).data('path');
      $('.contract_select').html('<select class="counterparty_contracts" data-id="' + id + '" data-path=' +
        path + ' data-page="' +  page + '" id="money_register_contract_id" name="money_register[contract_id]"></select>');
    });
  },

  loadPluginsContract: function() {
    $('#contract_date, #contract_validity').datepicker({ changeMonth: true, changeYear: true,
      yearRange: 'c-100:c+1' }).change('changeDate', function() {
      $(this).valid();
    });;
    $('input.number').numeric({ negative : false, decimal: false });
    $('#contract_contract_type').select2({ minimumResultsForSearch: -1 });
    Contracts.validateFormForNewContract();
  },

  loadContractsForCounterparty: function() {
    var CounterpartyContracts = $('#money_register_counterparty_id');
    var id = CounterpartyContracts.val();
    var page = CounterpartyContracts.data('page');
    var path = $('#money_register_contract_id').data('path');

    $.ajax({
      type: 'GET',
      url: '/contracts/',
      data: { id: id },
      success: function(r) {
        if (r.length == 0 ) {
          $('.contract_select').html("<a data-remote='true' href=" + path + "?page=" + page + " type='get'>" +
            I18n.t('contract.contract_info') + "</a>");
        } else {
          $.each(r, function(i, data) {
            v = r[i];
            $('.counterparty_contracts').append('<option value=' + v.id + '>' + v.number + '</option>');
          });
          $('.contract_select').prepend("<a data-remote='true' href=" + path + "?page=" + page +
            " type='get'>" + I18n.t('contract.counterparty_add') + "</a>");
          $('.counterparty_contracts').select2();
        }
      }
    });
  },

  hideContract: function() {
    if ($("#counterparty_info").length) {
      $('#contract_select').hide();
    } else {
      $('#contract_select').show();
    }
  }
};
