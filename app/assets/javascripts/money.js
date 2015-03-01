$(document).ready(function() {

  updateMoneyChart();

  Counterparties.clickEditable();

  curr_date = new Date();

  $('#moneyCurrency h4').append(I18n.t('for_today') + $.datepicker.formatDate('dd.mm.yy', curr_date));

  $('.editable-select').select2({width: '255px'});

  $('#moneyCurrency .currencyRemove').remove();

  $('a[data-form-toggle]').click(function () {
    $(this).parents('.modal-header').next().find('form').toggle();
  });
});

function ratesLoad() {
  currencyRate = $.ajax({
    type: 'GET',
    url: 'https://query.yahooapis.com/v1/public/yql?q=select+*+from+yahoo.finance.xchange+where+pair+=+%22USDUAH,EURUAH,AUDUAH,AZNUAH,GBPUAH,BYRUAH,DKKUAH,ISKUAH,KZTUAH,CADUAH,MDLUAH,NOKUAH,PLNUAH,SGDUAH,HUFUAH,TMTUAH,UZSUAH,CZKUAH,SEKUAH,CHFUAH,CNYUAH,JPYUAH,RUBUAH%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=',
    async: false
  });
  return currencyRate.response;
}

function addCurrency() {
  if ($('.currencySelect option').length == 0) {
    $('#currency_form').hide();
  }
  $('#currencies_form a').click(function () {
    selected = $('.currencySelect :selected');
    data = {
      currency: {
        name: selected.val()
      }
    };

    $.ajax({
      type: 'POST',
      url: $('#path').data('currensies'),
      data: data,
      success: RemoveOptionsCurrensy(selected)
    });
  });
}

function addFlags() {
  $('.currency').each(function() {
    value = $(this).attr("value")
    $(this).prepend('<div class="flag ' + value + '"></div>')
  })
}

function addRates() {
  $.each(currencyRate.responseJSON.query.results.rate, function(i, v) {
    currency =  v.id.slice(0,3);
    element = $('.currency_rates[value=' + currency + ']');
    //Add rates
    element.after('<td>' + v.Bid + ' грн.</td><td>' + v.Ask + ' грн.</td>');
    //Add flag images before currency
    element.prepend('<div class="flag ' + currency + '"></div>');
  });
};

function RemoveOptionsCurrensy(selected) {
  selected.remove();
  $('#companyCurrency .select2-chosen').text($('#companyCurrency select option:first').text());
  if ($('.currencySelect option').length == 0) {
    $('#currency_form').hide();
  }
};

function currencyRemove(id) {
  $.ajax({
    type: 'DELETE',
    url: $('#path').data('currensies') + '/' + id,
    async: false,
    success: function() {
      currencies = $('.currencyRates_' + id + ' td:first').text();
      $('.currencyRates_' + id).remove();
      value = currencies.slice(0,3);
      $('select').append('<option value=' + value + '>' + currencies + '</option>');
      $('#currency_form').show();
      $('#companyCurrency .select2-chosen').text($('#companyCurrency select option:first').text());
    }
  });
};

function validateFormForNewCashier() {
  $('#new_cashier').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "cashier[name]": { required: true }
    },
    messages: {
      "cashier[name]": { required: I18n.t('validation.errors.cant_be_blank') }
    }
  });
}

function validateFormForNewCredit() {
  $('#new_credit').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "credit[name]": { required: true },
      "credit[account_number]": { required: true }
    },
    messages: {
      "credit[name]": { required: I18n.t('validation.errors.cant_be_blank') },
      "credit[account_number]": { required: I18n.t('validation.errors.cant_be_blank') }
    }
  });
}

function validateFormForNewRegister() {
  $('#money_register_date').datepicker({ changeMonth: true, changeYear: true, yearRange: 'c-100:c+1' }).change('changeDate', function() {
    $(this).valid();
  });
  $('#new_money_register').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    ignore: "",
    rules: {
      "money_register[date]": { required: true },
      "money_register[total]": { required: true },
      "money_register[counterparty_id]": { required: true },
      "money_register[contract_id]": { required: true },
      "money_register[account_id]": { required: true }
    },
    messages: {
      "money_register[date]": { required: I18n.t('validation.errors.cant_be_blank') },
      "money_register[total]": { required: I18n.t('validation.errors.cant_be_blank') },
      "money_register[counterparty_id]": { required: I18n.t('validation.errors.cant_be_blank') },
      "money_register[contract_id]": { required: I18n.t('validation.errors.cant_be_blank') },
      "money_register[account_id]": { required: I18n.t('validation.errors.cant_be_blank') }
    }
  });
}

function setEditCounterparty() {
  $('.counterparty_reg').on('change', function() {
    $('.register_contract').html('<select class="contract_reg change" data-status="new" data-select="false"></select>');
  });

  $('.counterparty-cancel').on('click', function() {
    $('.popover').remove();
  });

  $('form#contract_popover').submit(function() {
    var registerId = $(this).data('id');
    var counterpartyId = $('select.counterparty_reg').val();
    var contractId = $('select.contract_reg').val();
    var counterpartyText = $('select.counterparty_reg :selected').text();
    var contractText = $('select.contract_reg :selected').text();

    if(contractId == null) {
      return false;
    } else {
      $.ajax({
        type: 'PUT',
        url: $('#path').data('registers') + '/' + registerId,
        async: false,
        data: { money_register: { counterparty_id: counterpartyId, contract_id: contractId } },
        success: function() {
          $('#contract_' + registerId).text(contractText).attr({'data-value': counterpartyId, 'data-contract': contractId});
          $('#conterparty_' + registerId ).text(counterpartyText).attr({'data-value': counterpartyId, 'data-contract': contractId});
          $('.popover').remove();
        }
      });
    }
  })
};

function updateMoneyChart (argument) {
  $('.total').on('save', function(e, params) {
    setCharts();
  });
}
