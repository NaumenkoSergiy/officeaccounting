var Counterparties = {
  loadPluginsCounterparty: function() {
    $('input.number').numeric({ negative : false, decimal: false });
    Counterparties.validateFormForNewCounterparty();
  },

  load: function(callback) {
    $.ajax({
      type: 'GET',
      url: $('#path').data('counterparties'),
      success: callback
    });
  },

  loadOption: function() {
    Counterparties.load(function(counterparties) {
      var selector = $('.company_counterparties[data-type=new]')
      var id = selector.data('id');
      var page = selector.data('page');
      var path = selector.data('path');
      if (counterparties.length == 0) {
         selector.parent().html("<a data-remote='true' href=" + path + "?page=" + page +
           " type='get'>" + I18n.t('contract.counterparty_info') + "</a>");
      } else {
        $.each(counterparties, function() {
          selector.append('<option value=' + this.value + '>' + this.text + '</option>');
        });
        selector.before("<a data-remote='true' href=" + path + "?page=" + page +
            " type='get'>" + I18n.t('contract.counterparty_add') + "</a>");
        if($("#contracts").length && $('#costs').hasClass('fade in')) {
          $('#contracts a[data-remote]').remove();
        }
        selector.attr('data-type', 'old');
        $('.company_counterparties[data-type=old]').select2();
        Contracts.loadContract();
      }
    });
  },

  xeditable: function() {
    Counterparties.load(function(counterparties) {
      $('.change_counterparty[data-status=new]').each(function() {
        $(this).editable({
          type: 'select2',
          source: counterparties,
          ajaxOptions: {
            type: "PUT",
            dataType: "json"
          },
          params: xeditableParams
        });
      $(this).attr('data-status', 'old');
      });
    });
  },

  validateFormForNewCounterparty: function() {
    $('#new_counterparty').validate({
      errorElement: "div",
      errorPlacement: function(error, element) {
        error.insertBefore(element);
      },
      rules: {
        "counterparty[title]": { required: true },
        "counterparty[name]": { required: true },
        "counterparty[edrpo]": { required: true },
        "counterparty[adress]": { required: true },
        "counterparty[account]": { required: true },
        "counterparty[mfo]": { required: true }
      },
      messages: {
        "counterparty[title]": { required: I18n.t('validation.errors.cant_be_blank') },
        "counterparty[name]": { required: I18n.t('validation.errors.cant_be_blank') },
        "counterparty[edrpo]": { required: I18n.t('validation.errors.cant_be_blank') },
        "counterparty[adress]": { required: I18n.t('validation.errors.cant_be_blank') },
        "counterparty[account]": { required: I18n.t('validation.errors.cant_be_blank') },
        "counterparty[mfo]": { required: I18n.t('validation.errors.cant_be_blank') }
      }
    });
  },

  checkResident: function() {
    $('.counterparty_resident').click(function() {
      id = $(this).data('id');
      $.ajax({
        type: 'PUT',
        url: $('#path').data('counterparties') + '/' + id,
        data: { counterparty: { resident: $(this).is(':checked') } },
      });
    })
  },

  forRegister: function() {
    Counterparties.load(function(counterparties) {
      var id = $('.counterparty_reg[data-type=new]').data('id');
      var $selector = $('.counterparty_reg[data-type=new]');
      $.each(counterparties, function() {
        $selector.append('<option value=' + this.value + '>' + this.text + '</option>');
      });
      $selector.attr('data-type', 'old');
      $('.counterparty_reg[data-type=old]').select2({'width': '130px'});
      $('.counterparty_reg[data-type=old]').select2('val', id);
    });
  },

  clickEditable: function() {
    $('.conterparty_popover').popover({
      html: true,
      placement: 'bottom',
      trigger: 'manual',
      content: function() {
        return ('<form id="counterparty" data-counterparty=' + idCounterparty + ' data-contract=' +
          idContract + ' data-id=' + idRegister + ' action="" role="form"><div class="form-group"><div class="row"><div class="col-lg-4"><lable>' +
          I18n.t('contract.counterparty') + '</lable></div><div class="col-lg-4"><lable>' +
          I18n.t('money.costs.contract') + '</lable></div></div><div class="row"><div class="col-lg-4"><select class="counterparty_reg" data-type="new" data-id=' +
          idCounterparty + '></select></div><div class="col-lg-4"><div class="register_contract"><select class="contract_reg" data-status="new"></select></div></div><div class="col-lg-4"><div class="editable-buttons"><button class="btn btn-primary btn-sm editable-submit" type="submit"><i class="glyphicon glyphicon-ok"></i></button><button class="btn btn-default btn-sm counterparty-cancel" type="button"><i class="glyphicon glyphicon-remove"></i></button></div></form>');
      }
    }).click(function(e) {
      $('.conterparty_popover').not(this).popover('hide');
      idCounterparty = $(this).data('value');
      idContract = $(this).data('contract');
      idRegister = $(this).data('register');
      $(this).attr('data-status', 'old')
      $(this).popover('toggle');
    });

    $(document).click(function(e) {
      if (!$(e.target).is('.conterparty_popover, .popover-content')) {
        $('.conterparty_popover').popover('hide');
      }
    });
  }
};
