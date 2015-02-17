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
    onkeyup: false,
    onclick: false,
    errorElement: "div",
    errorClass: "invalid",
    errorPlacement: function(error, element) {
      error.insertBefore("#email");
    },
    rules: {
      password : { invalidLoginDetails: true },
    },
  });
  new_session_form.find('input').keypress(function() {
    $('div.invalid').remove();
  })
  $('#new_session_form').submit(function() {
    new_session_form.validate();
  })

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
        required: I18n.t('validation.errors.mail_should_be_valid'),
        email: I18n.t('validation.errors.invalid_format')
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
        required: I18n.t('validation.errors.cant_be_blank'),
        minlength:  I18n.t('validation.errors.password_more8')
      },
      "user[confirm_password]": {
        required:  I18n.t('validation.errors.cant_be_blank'),
        equalTo:  I18n.t('validation.errors.passwords_not_identical')
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
