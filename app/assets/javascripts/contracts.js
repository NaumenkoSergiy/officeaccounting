var Contracts = {
  load: function(callback, id) {
    $.ajax({
      type: 'GET',
      url: '/contracts/',
      data: { counterparty: id },
      success: callback
    });
  },

  loadContract: function() {
    $('#money_register_counterparty_id').change(function() {
      var page = $('#money_register_contract_id').data('page');
      var path = $('#money_register_contract_id').data('path');
      $('.contract_select').html('<select class="counterparty_contracts" data-path=' +
        path + ' data-page="' +  page + '" id="money_register_contract_id" name="money_register[contract_id]"></select>');
    });
  },

  loadPlugins: function() {
    $('#contract_date, #contract_validity').datepicker({ changeMonth: true, changeYear: true,
      yearRange: 'c-100:c+1' }).change('changeDate', function() {
      $(this).valid();
    });;
    $('input.number').numeric({ negative : false, decimal: false });
    $('#contract_contract_type').select2({ minimumResultsForSearch: -1 });
    Contracts.validateFormForNewContract();
  },

  ForCounterparty: function() {
      var CounterpartyContracts = $('#money_register_counterparty_id');
      var id = CounterpartyContracts.val();
    Contracts.load(function(r) {
      var page = CounterpartyContracts.data('page');
      var path = $('#money_register_contract_id').data('path');

      if (r.length == 0 ) {
        $('.contract_select').html("<a data-remote='true' href=" + path + "?page=" + page + " type='get'>" +
          I18n.t('contract.contract_info') + "</a>");
      } else {
        $.each(r, function(i, data) {
          v = r[i];
          $('.counterparty_contracts').append('<option value=' + v.value + '>' + v.text + '</option>');
        });
        $('.contract_select').prepend("<a data-remote='true' href=" + path + "?page=" + page +
          " type='get'>" + I18n.t('contract.counterparty_add') + "</a>");
        $('.counterparty_contracts').select2();
      }
    }, id);
  },

  xeditable: function() {
    $('.change_contract[data-status=new]').each(function() {
      var id = $(this).data('counterparty');
      var element = $(this);

      Contracts.load(function(r) {
        element.editable({
          type: 'select2',
          source: r,
          ajaxOptions: {
            type: "PUT",
            dataType: "json"
          },
          params: xeditableParams
        });
        element.attr('data-status', 'old');
      }, id);
    });
  },

  ForRegisterTable: function() {
    var contractDefault = $('form#counterparty').data('contract');
    var id = $('select.counterparty_reg').val();
    console.log(contractDefault);
    console.log(id);

    Contracts.load(function(r) {

      if (r.length == 0 ) {
        $('.register_contract').html(I18n.t('contract.contract_info'));
      } else {
        $.each(r, function(i, data) {
          v = r[i];
          $('.contract_reg[data-status=new]').append('<option value=' + v.value + '>' + v.text + '</option>');
        });
        $('.contract_reg[data-status=new]').attr('data-status', 'old')
        $('.contract_reg[data-status=old]').select2();
        $('.contract_reg').select2('val', contractDefault);
      }
    }, id);
  },

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

  hideContract: function() {
    if ($("#counterparty_info").length) {
      $('#contract_select').hide();
    } else {
      $('#contract_select').show();
    }
  }
};
