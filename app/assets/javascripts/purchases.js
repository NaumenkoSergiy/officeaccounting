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
        required: 'поле не може бути пустим'
      },
      "counterparty[name]": {
        required: 'поле не може бути пустим'
      },
      "counterparty[edrpo]": {
        required: 'поле не може бути пустим'
      },
      "counterparty[adress]": {
        required: 'поле не може бути пустим'
      },
      "counterparty[account]": {
        required: 'поле не може бути пустим'
      },
      "counterparty[mfo]": {
        required: 'поле не може бути пустим'
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
