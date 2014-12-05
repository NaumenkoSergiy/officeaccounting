$(document).ready(function() {
  $('#new_user_form').validate({
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
      },
      confirm_password: {
        required: true,
        equalTo:  '#password'
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
      },
      confirm_password: {
        required: 'Поле confirm password не має бути бути порожнім',
        equalTo:  'Поле confirm password має бути бути відповідним до поля password'
      }
    }
  });

  $('#new_user_form').on('blur focusout change keyup', function(){
    $(this).validate();
  });

  $('#new_user_form').submit(function(){
    if (!$(this).valid()) {
      return false
    }
  });
});
