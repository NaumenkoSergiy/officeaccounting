$(document).on 'ready', () ->
  $('a[href="#products_services"]').on 'click', ->
    unless $('#products_services_form').children().length
      Product.loadForm($(@))
      Product.loadList($('#products_services_list'))
