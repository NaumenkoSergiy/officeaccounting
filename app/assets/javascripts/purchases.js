function validCounterparty() {
  $('#new_counterparty').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "counterparty[title]": {
        required: true
      },
      "counterparty[name]": {
        required: true
      },
      "counterparty[edrpo]": {
        required: true
      },
      "counterparty[adress]": {
        required: true
      },
      "counterparty[account]": {
        required: true
      },
      "counterparty[mfo]": {
        required: true
      }
    },
    messages: {
      "counterparty[title]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "counterparty[name]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "counterparty[edrpo]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "counterparty[adress]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "counterparty[account]": {
        required: I18n.t('validation.errors.cant_be_blank')
      },
      "counterparty[mfo]": {
        required: I18n.t('validation.errors.cant_be_blank')
      }
    }
  });
}

function openform() {
  $('#add_new_counterparty').click(function() {
    $('form#new_counterparty').toggle();
  });
}

function checkResident() {
  $('.counterparty_resident').click(function() {
    id = $(this).data('id');
    $.ajax({
      type: 'PUT',
      url: '/purchases/counterparties/' + id,
      data: {counterparty: {resident: $(this).is(':checked')}},
    });
  })
};
