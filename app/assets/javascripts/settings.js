$(document).ready(function() {
  $('#full_name').on('keyup', function() {
    $('#latin_name').val($('#full_name').val().translit());
  });

  $('#nace_codes').tagsInput({defaultText: 'Додати код'});

  $('#state_registration_date,\
     #date_registered_in_revenue_commissioners,\
     #registered_in_pension_fund').inputmask('99-99-9999');

  $('#official_submit').on('click', function() {
    $.ajax({
      type: 'POST',
      url: '/settings/officials',
      data: $('#official_form_director').serialize()
    });

    if (!$('.bookkeeper').is(":hidden")) {
      $.ajax({
        type: 'POST',
        url: '/settings/officials',
        data: $('#official_form_bookkeeper').serialize()
      });
    }

    $.ajax({
      type: 'POST',
      url: '/settings/bank_accounts',
      data: $('#bank_account').serialize(),
      success: function() {
        document.location = '/settings';
      }
    });
  });
});
