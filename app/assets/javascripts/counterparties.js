$(document).ready(function() {
  $.datepicker.setDefaults( $.datepicker.regional["uk"] );
  $('#counterparty_start_date').datepicker();
});

function LoadPluginsCounterparty() {
  validCounterparty();
  $('#counterparty_bank_id').select2({ width: '100%' });
  $('input.number').numeric({ negative : false, decimal: false });
}
