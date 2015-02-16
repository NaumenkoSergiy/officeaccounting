$(document).ready(function() {
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

  I18n.defaultLocale = $.cookie('language');
  I18n.locale = $.cookie('language');

  $('#moneyCurrency h4').append(I18n.t('for_today') + $.datepicker.formatDate('dd.mm.yy', curr_date));
  

  $('.currencySelect, .editable-select').select2({width: '255px'});

  $('#moneyCurrency .currencyRemove').remove();

  $('#add_new_bank, #add_new_cashier, #add_new_article, #add_new_credit').click(function () {
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

function RemoveOptionsCurrensy() {
  $('.currency').each(function(){
    currency = $(this).last().text();
    selector = "select option:contains(" + currency + ")";
    $(selector).remove();
    $('.select2-chosen').text($('select option:first').text());
    currencyShort = currency.slice(0,3);
    $('.currency_rates[value=' + currencyShort + '], .currency[value=' + currencyShort + ']').prepend('<div class="flag ' + currencyShort + '"></div>');

    $.each(currencyRate.responseJSON.query.results.rate, function(i, v) {
      v = currencyRate.responseJSON.query.results.rate[i];
      if (v.id == currencyShort + "UAH") {
        $('.currency_rates[value=' + currencyShort + ']').after('<td>' + v.Bid + ' грн.</td><td>' + v.Ask + ' грн.</td>');
      }
    });
  });
  if ($('.currencySelect option').length == 0) {
    $('#currency_form').hide();
  }
};

function currencyRemove(id) {
  $.ajax({
    type: 'DELETE',
    url: '/money/currencies/' + id,
    success: function(){
      currencies = $('.currency_' + id + ' td:first').text();
      $('.currency_' + id).remove();
      $('.currencyRates_' + id).remove();
      value = currencies.slice(0,3);
      $('select').append('<option value=' + value + '>' + currencies + '</option>');
      $('#currency_form').show();
    }
  });
};

function validAccount() {
  $('#new_account').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "account[name]": {
        required: true
      },
      "account[number]": {
        required: true
      }
    },
    messages: {
      "account[name]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "account[number]": {
        required: I18n.t('validation.errors.cant_be_blank')
      }
    }
  });
}

function validCashier() {
  $('#new_cashier').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "cashier[name]": {
        required: true
      }
    },
    messages: {
      "cashier[name]": {
        required: I18n.t('validation.errors.cant_be_blank')
      }
    }
  });
}

function validBank() {
  $('#new_bank').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "bank[name]": {
        required: true
      },
      "bank[code_edrpo]": {
        required: true
      },
      "bank[mfo]": {
        required: true
      },
      "bank[lawyer_adress]": {
        required: true
      }
    },
    messages: {
      "bank[name]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "bank[code_edrpo]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "bank[mfo]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "bank[lawyer_adress]": {
        required: I18n.t('validation.errors.cant_be_blank')
      }
    }
  });
}

function validArticle() {
  $('#new_article').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "article[name]": {
        required: true
      }
    },
    messages: {
      "article[name]": {
        required: I18n.t('validation.errors.cant_be_blank')
      }
    }
  });
}

function validCredit() {
  $('#new_credit').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "credit[name]": {
        required: true
      },
      "credit[account_number]": {
        required: true
      }
    },
    messages: {
      "credit[name]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "credit[account_number]": {
        required: I18n.t('validation.errors.cant_be_blank')
      }
    }
  });
}

function validRegister() {
  $('#money_register_date').datepicker({ changeMonth: true, changeYear: true, yearRange: 'c-100:c+1' }).change('changeDate', function() {
    $(this).valid();
  });;
  $('#new_money_register').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    ignore: "",
    rules: {
      "money_register[date]": {
        required: true
      },
      "money_register[total]": {
        required: true
      },
      "money_register[counterparty_id]": {
        required: true
      },
      "money_register[contract_id]": {
        required: true
      },
      "money_register[account_id]": {
        required: true
      }
    },
    messages: {
      "money_register[date]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "money_register[total]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "money_register[counterparty_id]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "money_register[contract_id]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "money_register[account_id]": {
        required: I18n.t('validation.errors.cant_be_blank')
      }
    }
  });
}

function hideContract() {
  if ($("#counterparty_info").length) {
    $('#contract_select').hide();
  } else {
    $('#contract_select').show();
  }
}
