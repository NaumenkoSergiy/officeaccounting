$(document).ready(function() {
  $('#full_name').on('keyup', function() {
    $('#latin_name').val($('#full_name').val().translit());
  });

  $('#nace_codes').tagsInput({defaultText: 'Додати код'});

  $('#state_registration_date,\
     #date_registered_in_revenue_commissioners,\
     #registered_in_pension_fund').inputmask('99-99-9999');

  $('#official_submit').on('click', function() {
    officials_validate();
    bookkeeper = $('#official_form_bookkeeper').valid();
    bank = $('#bank_account').valid();
    director = $('#official_form_director').valid();

    if (bookkeeper && bank && director){
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
    }
  });

  $('#company_form').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      full_name:         { required: true },
      short_name:        { required: true },
      latin_name:        { required: true },
      juridical_address: { required: true },
      actual_address:    { required: true },
      numbering_format:  { required: true }
    },
    messages: {
      full_name:         { required: 'поле не може бути пустим' },
      short_name:        { required: 'поле не може бути пустим' },
      latin_name:        { required: 'поле не може бути пустим' },
      juridical_address: { required: 'поле не може бути пустим' },
      actual_address:    { required: 'поле не може бути пустим' },
      numbering_format:  { required: 'поле не може бути пустим' }
    }
  });

  $('#registration_form').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      edrpou:                                     { required: true },
      koatuu:                                     { required: true },
      tin:                                        { required: true },
      state_registration_date:                    { required: true },
      registration_number:                        { required: true },
      date_registered_in_revenue_commissioners:   { required: true },
      number_registered_in_revenue_commissioners: { required: true },
      registered_in_pension_fund:                 { required: true },
      code_registered_in_pension_fund:            { required: true }
    },
    messages: {
      edrpou:                                     { required: 'поле не може бути пустим' },
      koatuu:                                     { required: 'поле не може бути пустим' },
      tin:                                        { required: 'поле не може бути пустим' },
      state_registration_date:                    { required: 'поле не може бути пустим' },
      registration_number:                        { required: 'поле не може бути пустим' },
      date_registered_in_revenue_commissioners:   { required: 'поле не може бути пустим' },
      number_registered_in_revenue_commissioners: { required: 'поле не може бути пустим' },
      registered_in_pension_fund:                 { required: 'поле не може бути пустим' },
      code_registered_in_pension_fund:            { required: 'поле не може бути пустим' }
    }
  });

  function officials_validate(){
    $('#official_form_director').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        name:  { required: true },
        tin:   { required: true },
        phone: { required: true },
        email: {
          required: true,
          pattern: /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/
        }
      },
      messages: {
        name:  { required: 'поле не може бути пустим' },
        tin:   { required: 'поле не може бути пустим' },
        phone: { required: 'поле не може бути пустим' },
        email: {
          required: 'поле не може бути пустим',
          pattern:  'поле має бути валідним'
        }
      }
    });

    $('#official_form_bookkeeper').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        name:  { required: true },
        tin:   { required: true },
        phone: { required: true },
        email: {
          required: true,
          pattern: /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/
        }
      },
      messages: {
        name:  { required: 'поле не може бути пустим' },
        tin:   { required: 'поле не може бути пустим' },
        phone: { required: 'поле не може бути пустим' },
        email: {
          required: 'поле не може бути пустим',
          pattern:  'поле має бути валідним'
        }
      }
    });

    $('#bank_account').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        account: { required: true },
        bank:    { required: true },
        mfo:     { required: true }
      },
      messages: {
        account: { required: 'поле не може бути пустим' },
        bank:    { required: 'поле не може бути пустим' },
        mfo:     { required: 'поле не може бути пустим' }
      }
    });
  }

  $('#company_form, #registration_form, #official_form_director, #official_form_bookkeeper, #bank_account')
  .on('blur focusout change keyup', function(){
    $(this).validate();
  });

  $('#company_form, #registration_form').submit(function(){
    if (!$(this).valid()) {
      return false
    }
  });

  $('.add_company').on('click', function() {
    $('.add_existing_company, .new_company').toggle();
    if ($('.add_existing_company').is(':hidden')) {
      $(this).text('Додати існуюче підприємство');
    }
    else {
      $(this).text('Додати нове підприємство');
    }
  });
});
