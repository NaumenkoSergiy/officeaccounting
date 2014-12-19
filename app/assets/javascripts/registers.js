$(document).ready(function() {
  $('#register_counterparty_id').select2({width: '774px'});
  $('.date').datepicker();

  $(function() {
    return $("[data-xeditable=true]").each(function() {
      return $(this).editable({
        ajaxOptions: {
          type: "PUT",
          dataType: "json"
        },
        params: function(params) {
          var railsParams;
          railsParams = {};
          railsParams[$(this).data("model")] = {};
          railsParams[$(this).data("model")][params.name] = params.value;
          return railsParams;
        }
      });
    });
  });

  $('.check').click(function(){
    id = $(this).parent().parent()[0].className;
    $.ajax({
      type: 'PUT',
      url: '/registers/' + id,
      data: {register: {holding: $(this).is(':checked')}},
    });
  })
});
