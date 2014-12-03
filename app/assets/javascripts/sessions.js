$(document).ready(function() {
  $('#new_session_form').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      email: {
        required: true,
        pattern:  /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/
      },
      password: {
        required:  true,
        minlength: 8,
        maxlength: 32
      }
    },
    messages: {
      email: {
        required: 'Поле email не має бути бути порожнім',
        pattern:  'Поле email має бути валідним'
      },
      password: {
        required:  'Поле password не має бути бути порожнім',
        minlength: 'Поле password має бути довшим 8 символів',
        maxlength: 'Поле password має бути не довшим 32 символів'
      }
    }
  });

  $('#new_session_form').on('blur focusout change keyup', function(){
    $(this).validate();
  });

  $('#new_session_form').submit(function(){
    if (!$(this).valid()) {
      return false
    }
  });
});
