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

  $('#moneyCurrency h4').append(' на сьогодні ' + $.datepicker.formatDate('dd.mm.yy', curr_date));
  

  $('.currencySelect, .editable-select').select2({width: '255px'});

  $('#moneyCurrency .currencyRemove').remove();

  $('#add_new_bank, #add_new_account, #add_new_cashier, #add_new_article').click(function () {
    $(this).parents('.modal-header').next().find('form').toggle();
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
