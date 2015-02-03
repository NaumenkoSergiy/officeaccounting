$(document).ready(function() {
  I18n.defaultLocale = $.cookie('language');
  I18n.locale = $.cookie('language');
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
        required: I18n.t('validation.errors.mail_not_blank'),
        pattern:  I18n.t('validation.errors.mail_should_be valid')
      },
      password: {
        required:  I18n.t('validation.errors.password_empty'),
        minlength: I18n.t('validation.errors.password_more8'),
        maxlength: I18n.t('validation.errors.password_less32')
      },
      confirm_password: {
        required: I18n.t('validation.errors.cant_be_blank'),
        equalTo:  I18n.t('validation.errors.passwords_not_identical')
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
