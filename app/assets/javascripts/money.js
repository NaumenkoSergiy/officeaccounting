$(document).ready(function() {
  $('.conterparty_popover').click(function() {
   idCounterparty = $(this).data('value');
   idContract = $(this).data('contract');
   idRegister = $(this).data('register');
    $(this).popover({
      html: true,
      placement: 'bottom',
      content: function() {
        return '<form id="counterparty" data-contract=' + idContract + ' data-id=' + idRegister + ' action="" role="form"><div class="form-group"><lable>' +I18n.t('contract.counterparty') + '</lable><br><select class="counterparty_reg" data-type="new" data-id=' + idCounterparty + '></select><br><lable>' +I18n.t('money.costs.contract') + '</lable><br><div class="register_contract"><select class="contract_reg" data-status="new"></select></div><div class="editable-buttons"><button class="btn btn-primary btn-sm editable-submit" type="submit"><i class="glyphicon glyphicon-ok"></i></button><button class="btn btn-default btn-sm counterparty-cancel" type="button"><i class="glyphicon glyphicon-remove"></i></button></div></form>';
      }
    });
  });

  $('#currency_form').click(function () {
    data = {
      currency: {
        name: $('.currencySelect :selected').val()
      }
    };
    
    $.ajax({
      type: 'POST',
      url: '/money/currencies',
      data: data,
      success: RemoveOptionsCurrensy

    });
  });

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
  $('#currency_form').click(function () {
    selected = $('.currencySelect :selected');
    data = {
      currency: {
        name: selected.val()
      }
    };
    $.ajax({
      type: 'POST',
      url: '/money/currencies',
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
    url: '/money/currencies/' + id,
    async: false,
    success: function(){
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
  $('.counterparty-cancel').click(function() {
    $('.popover').remove();
  });

  $('form#counterparty').submit(function() {
    registerId = $(this).data('id');
    counterpartyId = $('select.counterparty_reg').val();
    contractId = $('select.contract_reg').val();
    $.ajax({
      type: 'PUT',
      url: '/money/registers/' + registerId,
      data: { money_register: { counterparty_id: counterpartyId, contract_id: contractId } },
      success: function() {
        $('.popover').remove();
      }

    });
  })

  $('.counterparty_reg').change(function() {
    $('.contract_reg').html('<select class="contract_reg" data-status="new"></select>');
  });
};
