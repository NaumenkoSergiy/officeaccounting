window.Product =
  loadForm: ($element) ->
    $.ajax
      dataType: 'html'
      url: $element.data('path')
      success: (data) ->
        $('#products_services_form').html data
        Product.loadPlugins()

  loadList: ($element) ->
    $.ajax
      dataType: 'html'
      url: $element.data('path')
      success: (data) ->
        $element.html data
        Product.loadPlugins()
        $('.conducted').on 'click', ->
          $.ajax
            type: 'put'
            url: $(@).data('url')
            data: product: { conducted: $(@).is(':checked') }

  loadPlugins: ->
    $('.date').datepicker
      changeMonth: true
      changeYear: true
      yearRange: 'c-100:c+1'

    editableStart()

    $('#product_price, #product_amount').on 'keyup', ->
      price = $('#product_price').val()
      amount = $('#product_amount').val()
      $('#product_total').val amount * price
