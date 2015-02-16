var Contracts = {
  validContract: function() {
    $('#new_contract').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        "contract[date]": {
          required: true
        },
        "contract[number]": {
          required: true
        },
        "contract[validity]": {
          required: true
        }
      },
      messages: {
        "contract[date]": {
          required: I18n.t('validation.errors.cant_be_blank')
        },
        "contract[number]": {
          required: I18n.t('validation.errors.cant_be_blank')
        },
        "contract[validity]": {
          required: I18n.t('validation.errors.cant_be_blank')
        }
      }
    });
  },

  loadContract: function() {
    $('#money_register_counterparty_id').change(function() {
      id = $(this).val();
      page = $(this).data('page');
      $('.contract_select')[0].innerHTML = '<select class="counterparty_contracts" data-id="' +
      id + '" data-page="' + page + '" id="money_register_contract_id" name="money_register[contract_id]"></select>';
    });
  },

  loadPluginsContract: function() {
    $('#contract_date, #contract_validity').datepicker({ changeMonth: true, changeYear: true, yearRange: 'c-100:c+1' }).change('changeDate', function() {
      $(this).valid();
    });;
    $('input.number').numeric({ negative : false, decimal: false });
    $('#contract_contract_type').select2({ minimumResultsForSearch: -1 });
    Contracts.validContract();
  },

  getAllCounterpartyContracts: function() {
    id = $('#money_register_counterparty_id').val();
    page = $('#money_register_counterparty_id').data('page');

    $.ajax({
      type: 'GET',
      url: '/contracts/',
      data: { id: id },
      success: function(r) {
        if (r.data.length == 0 ) {
          $('.contract_select')[0].innerHTML = "<a data-remote='true' href='/contracts/new?page=" + page + "' type='get'>" + I18n.t('contract.contract_info') + "</a>";
        } else {
          $.each(r.data, function(i, data) {
            v = r.data[i];
            $('.counterparty_contracts').append('<option value=' + v.id + '>' + v.number + '</option>');
          });
           $('.contract_select').prepend("<a data-remote='true' href='/contracts/new?page=" + page + "' type='get'>" + I18n.t('contract.counterparty_add') + "</a>");
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
