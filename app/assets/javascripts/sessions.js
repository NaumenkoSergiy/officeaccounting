$(document).ready(function() {
  new_session_form = $('#new_session_form');

  jQuery.validator.addMethod( "invalidLoginDetails", function(value) {
    var email = $("#email").val();
    var password = $("#password").val();
    var isValidLogin = true;
    if ((password.length == 0) || !/^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email))  {
      isValidLogin = false;
    }
    return isValidLogin;
  },
  "Невірно введний Email або пароль"
  );

  new_session_form.validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      email : { invalidLoginDetails: true }
    }
  });

  $('#new_session_form').on('blur focusout change keyup', function(){
    $(this).validate();
  });

  $('#password_resets').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      email: {
        required: true,
        email: true,
        pattern:  /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/
      }
    },
    messages: {
      email: {
        required: 'Поле email має бути валідним',
        email: 'Невірний формат'
      }
    }
  });

  $('.edit_user').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "user[password]": {
        required:  true,
        minlength: 8,
        maxlength: 32
      },
      "user[confirm_password]": {
        required: true,
        equalTo: "#user_password"
      }
    },
    messages: {
      "user[password]": {
        required: 'Поле пароль не має бути бути порожнім',
        minlength:  'Поле пароль має бути мінімум 8 символів'
      },
      "user[confirm_password]": {
        required:  'Поле підтвердження пароля не має бути порожнім',
        equalTo:  'Паролі не однакові'
      }
    }
  });

  new_session_form.submit(function(){
    if (!$(this).valid()) {
      $('.notification.error').hide();
      return false
    }
  });
});
