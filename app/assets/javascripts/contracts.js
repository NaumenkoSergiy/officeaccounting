function validContract() {
  $('#new_contract').validate({
    errorElement: "div",
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
    rules: {
      "contract[date]": {
        required: true
      },
      "contract[number]": {
        required: true
      },
      "contract[validity]": {
        required: true
      }
    },
    messages: {
      "contract[date]": {
        required: 'поле не може бути пустим'
      },
      "contract[number]": {
        required: 'поле не може бути пустим'
      },
      "contract[validity]": {
        required: 'поле не може бути пустим'
      }
    }
  });
}
