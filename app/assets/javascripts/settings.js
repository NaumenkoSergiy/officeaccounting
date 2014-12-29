$(document).ready(function() {
  $('#registration_form_of_incorporation, #registration_tax_inspection').select2({width: '970px'});

  $('#registration_koatuu').select2({
    width: '970px',
    minimumInputLength: 3,
    ajax: {
      url: '/settings/registrations/get_koatuu',
      dataType: 'json',
      data: function(term) {
        return { q: term };
      },
      results: function(data) {
        return { results: data['data'] };
      }
    }
  });

  $('input.number').numeric({ negative : false, decimal: false });

  $.datepicker.setDefaults( $.datepicker.regional["uk"] );
  $('.date_reg').datepicker({ maxDate: 0,
                              changeMonth: true,
                              changeYear: true,
                              yearRange: 'c-100:c+1'
                            });

  $('#company_full_name').on('keyup', function() {
    $('#company_latin_name').val($('#company_full_name').val().translit());
  });
  
  $('#phone').inputmask('+(380)-99-9999999');

  $('#company_form').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      company_full_name: {
        required: true
      },
      company_short_name: {
        required: true
      },
      company_latin_name: {
        required: true
      },
      company_juridical_address: {
        required: true
      },
      company_actual_address: {
        required: true
      },
      company_numbering_format: {
        required: true
      }
    },
    messages: {
      company_full_name: {
        required: 'поле не може бути пустим'
      },
      company_short_name: {
        required: 'поле не може бути пустим'
      },
      company_latin_name: {
        required: 'поле не може бути пустим'
      },
      company_juridical_address: {
        required: 'поле не може бути пустим'
      },
      company_actual_address: {
        required: 'поле не може бути пустим'
      },
      company_numbering_format: {
        required: 'поле не може бути пустим'
      }
    }
  });
  $('#registration_form').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      edrpou: {
        required: true
      },
      koatuu: {
        required: true
      },
      tin: {
        required: true
      },
      state_registration_date: {
        required: true
      },
      registration_number: {
        required: true
      },
      date_registered_in_revenue_commissioners: {
        required: true
      },
      number_registered_in_revenue_commissioners: {
        required: true
      }
    },
    messages: {
      edrpou: {
        required: 'поле не може бути пустим'
      },
      koatuu: {
        required: 'поле не може бути пустим'
      },
      tin: {
        required: 'поле не може бути пустим'
      },
      state_registration_date: {
        required: 'поле не може бути пустим'
      },
      registration_number: {
        required: 'поле не може бути пустим'
      },
      date_registered_in_revenue_commissioners: {
        required: 'поле не може бути пустим'
      },
      number_registered_in_revenue_commissioners: {
        required: 'поле не може бути пустим'
      }
    }
  });

  function officials_validate() {
    $('#official_form_director').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        name: {
          required: true
        },
        tin: {
          required: true
        },
        phone: {
          required: true
        },
        email: {
          required: true,
          pattern: /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/
        }
      },
      messages: {
        name: {
          required: 'поле не може бути пустим'
        },
        tin: {
          required: 'поле не може бути пустим'
        },
        phone: {
          required: 'поле не може бути пустим'
        },
        email: {
          required: 'поле не може бути пустим',
          pattern: 'поле має бути валідним'
        }
      }
    });
    $('#official_form_bookkeeper').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        name: {
          required: true
        },
        tin: {
          required: true
        },
        phone: {
          required: true
        },
        email: {
          required: true,
          pattern: /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/
        }
      },
      messages: {
        name: {
          required: 'поле не може бути пустим'
        },
        tin: {
          required: 'поле не може бути пустим'
        },
        phone: {
          required: 'поле не може бути пустим'
        },
        email: {
          required: 'поле не може бути пустим',
          pattern: 'поле має бути валідним'
        }
      }
    });
    $('#bank_account').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        account: {
          required: true
        },
        bank: {
          required: true
        },
        mfo: {
          required: true
        }
      },
      messages: {
        account: {
          required: 'поле не може бути пустим'
        },
        bank: {
          required: 'поле не може бути пустим'
        },
        mfo: {
          required: 'поле не може бути пустим'
        }
      }
    });
  }
  $('#company_form, #registration_form, #official_form_director, #official_form_bookkeeper, #bank_account')
    .on('blur focusout change keyup', function() {
      $(this).validate();
    });
  $('form').submit(function() {
    if (!$(this).valid()) {
      return false
    }
  });

  $('.add_company').on('click', function() {
    $('.add_existing_company, .new_company').toggle();
    if ($('.add_existing_company').is(':hidden')) {
      $(this).text('Додати існуюче підприємство');
    } else {
      $(this).text('Додати нове підприємство');
    }
  });

  $('#pdv').click(function(){
    if($(this).hasClass('checked')) {
      $('#tin').attr('disabled', 'disabled');
      $(this).removeClass('checked');
    }
    else
    {
      $('#tin').removeAttr('disabled');
      $(this).addClass('checked');
    }
  });
  $('a[href="' + this.location.pathname + '"]').parent().addClass('current');
  
  function currency () {
    $.ajax({
      type: 'GET',
      url: 'https://query.yahooapis.com/v1/public/yql?q=select+*+from+yahoo.finance.xchange+where+pair+=+%22USDUAH,EURUAH,RUBUAH%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback='
    });
  }

  $('.role').select2({ width: '130px', minimumResultsForSearch: '5' });

  $('.checkPdv').click(function(){
    id = $('#registration_id').val();
    
    $.ajax({
      type: 'PUT',
      url: '/settings/registrations/' + id,
      data: {registration: {pdv: $(this).is(':checked')}},
      success: function() {
        document.location = document.location;
      }
    });
  })

  $('#bookkeeper').click(function() {
    $.ajax({
      type: 'POST',
      url: '/settings/officials',
      data: $('#official_form_bookkeeper').serialize(),
      success: function() {
        document.location = document.location;
      }
    });
  })
});
