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

  curr_date = new Date();

  $('#moneyCurrency h4').append(' на сьогодні ' + $.datepicker.formatDate('dd.mm.yy', curr_date));
  
  $('.money_add_new').click(function () {
      currencyRate = $.ajax({
        type: 'GET',
        url: 'https://query.yahooapis.com/v1/public/yql?q=select+*+from+yahoo.finance.xchange+where+pair+=+%22USDUAH,EURUAH,AUDUAH,AZNUAH,GBPUAH,BYRUAH,DKKUAH,ISKUAH,KZTUAH,CADUAH,MDLUAH,NOKUAH,PLNUAH,SGDUAH,HUFUAH,TMTUAH,UZSUAH,CZKUAH,SEKUAH,CHFUAH,CNYUAH,JPYUAH,RUBUAH%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=',
        async: false
      });
    RemoveOptionsCurrensy(currencyRate.response);
  });


  $('.currencySelect').select2({width: '255px'});

  $('#moneyCurrency .currencyRemove').remove();
});

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
