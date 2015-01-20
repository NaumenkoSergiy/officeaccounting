$(document).ready(function() {
  $('#currency_form').click(function () {
    data = {
      currency: {
        name: $('.currencySelect :selected').val()
      }
    };
    
    $.ajax({
      type: 'POST',
      url: '/money/currency',
      data: data,
      success: RemoveOptionsCurrensy

    });
  });

  $('#bank_form input[type=button]').click(function () {
    dataBank = {
      bank: {
        name: $('#bank_form #name').val(),
        code_edrpo: $('#bank_form #code_edrpo').val(),
        mfo: $('#bank_form #mfo').val(),
        lawyer_adress: $('#bank_form #lawyer_adress').val()
      }
    };

    $.ajax({
      type: 'POST',
      url: '/money/bank',
      data: dataBank,
      success: function  () {
        $('#bank_form').hide();
        $('#bank_form').trigger('reset');
      }
    });
  });

  $('#account_form input[type=button]').click(function () {
    dataAccount = {
      account: {
        name: $('#account_form #name').val(),
        account_type: $('#account_form #account_type').val(),
        number: $('#account_form #number').val(),
        currency: $('#account_form #currency').val(),
        bank_id: $('#account_form #bank_id').val()
      }
    };

    $.ajax({
      type: 'POST',
      url: '/money/account',
      data: dataAccount,
      success: function  () {
        $('#account_form').hide();
        $('#account_form').trigger('reset');
      }
    });
  });

  $('#cashier_form input[type=button]').click(function () {
    dataCashier = {
      cashier: {
        name: $('#cashier_form #name').val(),
        currency: $('#cashier_form #currency').val(),
      }
    };

    $.ajax({
      type: 'POST',
      url: '/money/cashier',
      data: dataCashier,
      success: function  () {
        $('#cashier_form').hide();
        $('#cashier_form').trigger('reset');
      }
    });
  });

  curr_date = new Date();

  $('#moneyCurrency h4').append(' на сьогодні ' + $.datepicker.formatDate('dd.mm.yy', curr_date));
  

  $('.currencySelect, .editable-select').select2({width: '255px'});

  $('.accountSelect').select2({width: '100%'});

  $('#moneyCurrency .currencyRemove').remove();

  $('#bank_form, #account_form, #cashier_form').hide();

  $('#add_new_bank, #add_new_account, #add_new_cashier, add_new_credit').click(function () {
    $(this).parent().parent().parent().next().find('form').toggle();
  });
});

function ratesLoad () {
  currencyRate = $.ajax({
    type: 'GET',
    url: 'https://query.yahooapis.com/v1/public/yql?q=select+*+from+yahoo.finance.xchange+where+pair+=+%22USDUAH,EURUAH,AUDUAH,AZNUAH,GBPUAH,BYRUAH,DKKUAH,ISKUAH,KZTUAH,CADUAH,MDLUAH,NOKUAH,PLNUAH,SGDUAH,HUFUAH,TMTUAH,UZSUAH,CZKUAH,SEKUAH,CHFUAH,CNYUAH,JPYUAH,RUBUAH%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=',
    async: false
  });
  return currencyRate.response;
}

function RemoveOptionsCurrensy () {
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

function currencyRemove (id) {
  $.ajax({
    type: 'DELETE',
    url: '/money/currency/' + id,
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

function moneyRemove (name, id) {
  $.ajax({
    type: 'DELETE',
    url: '/money/'+ name + '/' + id,
    success: function(){
      $('.' + name + '_' + id).remove();
    }
  });
}

function moneyShow (name, id) {
  $.ajax({
    type: 'GET',
    url: '/money/' + name + '/' + id,
    success: function(){
      editableStart();
    }
  });
}
