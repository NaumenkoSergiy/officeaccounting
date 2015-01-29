function validCounterparty () {
  $('#new_counterparty').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "counterparty[name]": {
        required: true
      },
      "counterparty[start_date]": {
        required: true,
        dpDate: true
      }
    },
    messages: {
      "counterparty[name]": {
        required: 'поле не може бути пустим'
      },
      "counterparty[start_date]": {
        required: 'поле не може бути пустим'
      }
    }
  });
}

function openform () {
  $('#add_new_counterparty').click(function() {
    $(this).parents('.modal-header').next().find('form').toggle();
  });
}

