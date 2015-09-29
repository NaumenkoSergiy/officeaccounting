if '<%= @product.persisted? %>' == 'true'
  $('#products_services_list tr.bg-grey').after('<%= j render_list("Product", "purchases/products/", [@product], "product") if @product.persisted? %>')
  $('#new_product')[0].reset()
  $('input[name="product[number]"]').val(parseInt($('#product_number').val()) + 1)
  $('select.select').select2('data', null)
  $('#products_services_form').removeClass('in')
  $('.has-error').removeClass('has-error')
  $('.help-block').remove()
else
  $('#new_product').replaceWith('<%= j render("purchases/products/form") %>')
Product.loadPlugins()
