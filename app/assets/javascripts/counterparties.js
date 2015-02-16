$(document).ready(function() {
  $.datepicker.setDefaults( $.datepicker.regional["uk"] );
  $('#counterparty_start_date').datepicker();
});

function LoadPluginsCounterparty() {
  validCounterparty();
  $('#counterparty_bank_id').select2({ width: '100%' });
  $('input.number').numeric({ negative : false, decimal: false });
}

function getAllCounterparties(selector) {
  id = $(selector).data('id');
  page = $(selector).data('page');

  $.ajax({
    type: 'GET',
    url: '/purchases/counterparties/',
    data: { id: id },
    success: function(r) {
      if (r.data.length == 0) {
         $(selector).parent().html("<a data-remote='true' href='/purchases/counterparties/new?page=" + page + "' type='get'>" + I18n.t('contract.counterparty_info') + "</a>");
      } else {
        $.each(r.data, function(i, data) {
          v = r.data[i];
          $(selector).append('<option value=' + v.id + '>' + v.name + '</option>');
        });
        $(selector).before("<a data-remote='true' href='/purchases/counterparties/new?page=" + page + "' type='get'>" + I18n.t('contract.counterparty_add') + "</a>");
        $(selector).select2();
        loadContract();
      }
    }
  });
}
