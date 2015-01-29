$(document).ready(function() {
  $('#register_counterparty_id').select2({width: '774px'});
  $('.date').datepicker();

  editableStart();

  $('.check').click(function(){
    id = $(this).parent().parent()[0].className;
    $.ajax({
      type: 'PUT',
      url: '/registers/' + id,
      data: {register: {holding: $(this).is(':checked')}},
    });
  })
});

function editableStart () {
  return $("[data-xeditable=true]").each(function() {
    var name;
    var valueNew = null;
    var id = 0;
    return $(this).editable({
      ajaxOptions: {
        type: "PUT",
        dataType: "json"
      },
      params: function(params) {
        var railsParams;
        id = params.pk.id;
        name = params.name;
        if ($(this).data().source) {
          $.map( $(this).data().source, function( val, i ) {
            if (val['id']==params.value){
              valueNew = val['text'];
            }
          });
        }
        railsParams = {};
        railsParams[$(this).data("model")] = {};
        railsParams[$(this).data("model")][params.name] = params.value;
        railsParams['page'] = 'show';
        return railsParams;
      },
      success: function(response, newValue) {
        $("table tr[value='" + id + "'] td#"+name).find('a').text(valueNew || newValue);
      }
    });
  });
};
