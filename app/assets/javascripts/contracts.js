function validContract() {
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
}

function loadPluginsContract() {
  $('#contract_date, #contract_validity').datepicker({ changeMonth: true, changeYear: true, yearRange: 'c-100:c+1' }).change('changeDate', function() {
    $(this).valid();
  });;
  $('input.number').numeric({ negative : false, decimal: false });
  $('#contract_contract_type').select2({ minimumResultsForSearch: -1, 'width' : '100%' });
  $('#contract_counterparty_id').select2({ minimumResultsForSearch: 5, 'width' : '100%' });
  validContract();
}
