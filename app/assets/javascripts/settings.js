$(document).ready(function() {
  $('#registration_form_of_incorporation, #registration_tax_inspection').select2({width: '970px'});

  AjaxGetKoatuu = {
                    url: '/settings/registrations/get_koatuu',
                    dataType: 'json',
                    data: function(term) {
                      return { q: term };
                    },
                    results: function(data) {
                      return { results: data['data'] };
                    }
                  }

  $('#registration_koatuu').select2({
    width: '970px',
    minimumInputLength: 3,
    triggerChange: true,
    ajax: AjaxGetKoatuu
  })

  $('.registration_koatuu').editable({
    ajaxOptions: {
      type: "PUT",
      dataType: "json"
    },
    params: function(params) {
      var railsParams;
      railsParams = {};
      railsParams[$(this).data("model")] = {};
      railsParams[$(this).data("model")][params.name] = params.value;
      railsParams['page'] = 'show';
      return railsParams;
    },
    select2: {
      width: '340px',
      minimumInputLength: 3,
      ajax: AjaxGetKoatuu
    }
  });

  function numberPdv () {
    $(".checkPdv").is(':checked') ? $('.numberPdv').show() : $('.numberPdv').hide();
  }

  numberPdv();

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

  $('#new_company').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "company[full_name]": {
        required: true
      },
      "company[short_name]": {
        required: true
      },
      "company[latin_name]": {
        required: true
      },
      "company[juridical_address]": {
        required: true
      },
      "company[actual_address]": {
        required: true
      },
      "company[numbering_format]": {
        required: true
      }
    },
    messages: {
      "company[full_name]": {
        required: 'поле не може бути пустим'
      },
      "company[short_name]": {
        required: 'поле не може бути пустим'
      },
      "company[latin_name]": {
        required: 'поле не може бути пустим'
      },
      "company[juridical_address]": {
        required: 'поле не може бути пустим'
      },
      "company[actual_address]": {
        required: 'поле не може бути пустим'
      },
      "company[numbering_format]": {
        required: 'поле не може бути пустим'
      }
    }
  });

  $('#new_registration').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "registration[edrpou]": {
        required: true
      },
      "registration[nace_codes]":{min:1},
      "registration[koatuu]": {
        required: true
      },
      "registration[tin]": {
        required: true
      },
      "registration[state_registration_date]": {
        required: true
      },
      "registration[registered_by]":{
        required: true
      },
      "registration[registration_number]": {
        required: true
      },
      "registration[date_registered_in_revenue_commissioners]": {
        required: true
      },
      "registration[number_registered_in_revenue_commissioners]": {
        required: true
      },
      "select2-choices": {
        required: true
      }
    },
    messages: {
      "registration[edrpou]": {
        required: 'поле не може бути пустим'
      },
      "registration[nace_codes]": { 
        valueNotEquals: "Please select an item!" 
      },
        "registration[koatuu]": {
        required: 'поле не може бути пустим'
      },
        "registration[tin]": {
        required: 'поле не може бути пустим'
      },
        "registration[state_registration_date]": {
        required: 'поле не може бути пустим'
      },
        "registration[registered_by]": {
        required: 'поле не може бути пустим'
      },
        "registration[registration_number]": {
        required: 'поле не може бути пустим'
      },
        "registration[date_registered_in_revenue_commissioners]": {
        required: 'поле не може бути пустим'
      },
        "registration[number_registered_in_revenue_commissioners]": {
        required: 'поле не може бути пустим'
      }
    }
  });

    $('#registration_nace_codes, #registration_koatuu').change(function (argument) {
        $(this).prev().prev().hide();
    })

    $('#new_registration').submit(function() {
      error = 0;
      if ($('#registration_nace_codes').val() === '') {
        error = 1;
        $('#registration_nace_codes').prev().prev().show();
      }

      if ($('#registration_koatuu').val() === '') {
        error = 1;
        $('#registration_koatuu').prev().prev().show();
      }

      if (error) {
          return false;
      } else {
          return true;
      }
    });

  $('#new_official').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "official[name]": {
        required: true
      },
      "official[tin]": {
        required: true
      },
      "official[phone]": {
        required: true
      },
      "official[email]": {
        required: true,
        pattern: /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/
      }
    },
    messages: {
      "official[name]": {
        required: 'поле не може бути пустим'
      },
      "official[tin]": {
        required: 'поле не може бути пустим'
      },
      "official[phone]": {
        required: 'поле не може бути пустим'
      },
      "official[email]": {
        required: 'поле не може бути пустим',
        pattern: 'поле має бути валідним'
      }
    }
  });

  $('#new_bank_account').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "bank_account[account]": {
        required: true
      },
      "bank_account[bank]": {
        required: true
      },
      "bank_account[mfo]": {
        required: true
      }
    },
    messages: {
      "bank_account[account]": {
        required: 'поле не може бути пустим'
      },
      "bank_account[bank]": {
        required: 'поле не може бути пустим'
      },
      "bank_account[mfo]": {
        required: 'поле не може бути пустим'
      }
    }
  });

  $('#delegate_form').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
       email: {
        required: true,
        pattern: /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/
      }
    },
    messages: {
      email: {
        required: 'поле не може бути пустим'
      }
    }
  });

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

  $('#registration_pdv').click(function(){
    if($(this).hasClass('checked')) {
      $('#registration_tin').attr('disabled', 'disabled');
      $(this).removeClass('checked');
    }
    else
    {
      $('#registration_tin').removeAttr('disabled');
      $(this).addClass('checked');
    }
  });
  
  $('a[href="' + this.location.pathname + '"]').parent().addClass('current');

  $('.companyChoose').on('switchChange.bootstrapSwitch', function() {
    companyId = $(this).val();
    $('.bootstrap-switch-on').next().next().show().css({ 'font-size':'12px', 'margin-left':'10px' });
    $('.bootstrap-switch-off').next().next().hide();

    $.ajax({
      type: 'POST',
      url: '/settings/companies/change_company/',
      data: { company_id: companyId },
      success: function(results) {
        $('.navbar-top-links li .current-company-name').text(results.company_name);
      }
    });
  });

  $('.role').selectpicker({'width':'210px'});

  $('#delegate_form').hide();

  $('.add_delegate').click(function() {
    $('#delegate_form').toggle();
  })

  $('.checkPdv').click(function(){
    id = $('#registration_id').val();
    
    $.ajax({
      type: 'PUT',
      url: '/settings/registrations/' + id,
      data: {registration: {pdv: $(this).is(':checked')}, page: 'show'},
      success: numberPdv
    });
  });

  $(".companyChoose").bootstrapSwitch({ 'size':'small','offColor':'danger', 'onText':'Вкл', 'offText':'Вик' });
  
  $('.bootstrap-switch-on').next().next().css({ 'font-size':'13px', 'margin-left':'10px' }).show();

  $('.info').tooltipster({ theme: 'tooltipster-shadow', position: 'right', maxWidth: '240' });

  $('#registration_risk_class').selectpicker({'width':'474', 'margin-bottom':'10px'});

  $('#registration_tax_system').selectpicker({'width':'150'});
});
