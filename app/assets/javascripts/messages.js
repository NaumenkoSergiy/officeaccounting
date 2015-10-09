
$(document).ready(function() {
  $('.select2').select2()
  AjaxGetRecipients = {
                        url: '/users/recipients/',
                        dataType: 'json',
                        data: function(term) {
                          return { q: term };
                        },
                        results: function(data) {
                          return { results: data['data'] };
                        }
                      }
  $('#recipients').select2({
    minimumInputLength: 3,
    multiple: true,
    ajax: AjaxGetRecipients
  })
})
