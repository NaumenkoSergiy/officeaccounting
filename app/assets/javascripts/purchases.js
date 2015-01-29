function openform () {
  $('#add_new_counterparty').click(function() {
    $(this).parents('.modal-header').next().find('form').toggle();
  });
}

