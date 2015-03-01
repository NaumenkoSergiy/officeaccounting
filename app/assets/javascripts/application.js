// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require i18n
//= require i18n/translations
//= require_tree .
//= require jquery-ui
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require bootstrap
//= require bootstrap3-editable/bootstrap-editable
//= require bootstrap-select
//= require select2
//= require observer

LEFT_BAR_HIDE = 45;
LEFT_BAR_SHOW = 220;

$(document).on('ready', function() {
  //set xeditable
  editableStart();

  //observer dom change
  setObserver();

  // left bar toggle
  $('.navbar-minimalize').click(function () {
    if ($('#page-wrapper').css('margin-left')==LEFT_BAR_HIDE+'px') {
      $.cookie('leftBar', LEFT_BAR_SHOW);
      px = LEFT_BAR_SHOW;
    }
    else {
      $.cookie('leftBar', LEFT_BAR_HIDE);
      px = LEFT_BAR_HIDE;
    }

    $('#page-wrapper').animate(
      { marginLeft: px },
      { duration: 200,
        complete: function(){
          $('.dropdown.profile-element').toggle();
        }
      }
    );
  });
  
  $('.left-bar a').click(function(){
    $('.left-bar a').removeClass('current');
    $(this).addClass('current');
  });

  $('form').submit(function(){
    $.blockUI({
      message: 'Зачекайте, будь ласка'
    });

    if (!$(this).valid()){
      $.unblockUI();
    }
  });

  $(document).ajaxStart(function(){
    $.blockUI({
      message: 'Зачекайте, будь ласка'
    });
  });
  $(document).ajaxStop(function () { $.unblockUI(); });
});

String.prototype.translit = (function () {
  var L = {
    'А': 'A', 'а': 'a', 'Б': 'B', 'б': 'b', 'В': 'V', 'в': 'v', 'Г': 'G', 'г': 'g',
    'Д': 'D', 'д': 'd', 'Е': 'E', 'е': 'e', 'Ё': 'Yo', 'ё': 'yo', 'Ж': 'Zh', 'ж': 'zh',
    'З': 'Z', 'з': 'z', 'И': 'I', 'и': 'i', 'І': 'I', 'і': 'i', 'Ї': 'YI', 'ї': 'yi', 'Й': 'Y', 'й': 'y', 'К': 'K', 'к': 'k',
    'Л': 'L', 'л': 'l', 'М': 'M', 'м': 'm', 'Н': 'N', 'н': 'n', 'О': 'O', 'о': 'o',
    'П': 'P', 'п': 'p', 'Р': 'R', 'р': 'r', 'С': 'S', 'с': 's', 'Т': 'T', 'т': 't',
    'У': 'U', 'у': 'u', 'Ф': 'F', 'ф': 'f', 'Х': 'Kh', 'х': 'kh', 'Ц': 'Ts', 'ц': 'ts',
    'Ч': 'Ch', 'ч': 'ch', 'Ш': 'Sh', 'ш': 'sh', 'Щ': 'Sch', 'щ': 'sch', 'Ъ': '', 'ъ': '',
    'Ы': 'Y', 'ы': 'y', 'Ь': "", 'ь': "", 'Э': 'E', 'э': 'e', 'Ю': 'Yu', 'ю': 'yu',
    'Я': 'Ya', 'я': 'ya', ' ': '-', '_': '-',
    '"': '', "'": '', '.': '', ',': '', '!': '', ':': '', ';': ''
  },
  r = '',
  k;
  for (k in L) r += k;
  r = new RegExp('[' + r + ']', 'g');
  k = function (a) {
    return a in L ? L[a] : '';
  };

  return function () {
    var text_string = this.replace(r, k).replace(' ', '-').toString();

    var literals = 'QqWwEeRrTtYyUuIiOoPpAaSsDdFfGgHhJjKkLlZzXxCcVvBbNnMm-0123456789';
    var newString = '';
    for (var i = 0; i < text_string.length; i++) {
        if (!(literals.indexOf(text_string.charAt(i)) == -1)) {
            newString += text_string.charAt(i);
        };
    };
    return newString;
  };
})();

function openForm(idform, idbutton) {
  $("#" + idbutton).click(function() {
    $("form#" + idform).toggle();
  });
}

//observer dom change
function setObserver() {
  var callback = function() {
    mo.disconnect();

    if ($('.company_accounts').length && $('.company_accounts  > option').length == 0) {
      Accounts.loadOption();
    }
    else if ($('.change_account').length && $('.change_account[data-status=new]').length) {
      Accounts.xeditableLoadSource();
    }
    else if ($('.articles').length && $('.articles  > option').length == 0) {
      Articles.loadOption();
    }
    else if ($('.change_article[data-status=new]').length) {
      Articles.xeditable();
    }
    else if ($('.company_counterparties').length > 0 && $('.company_counterparties[data-type=new]').length) {
      Counterparties.loadOption();
    }
    else if ($('.counterparty_contracts').length && $('.counterparty_contracts  > option').length == 0) {
      Contracts.ForCounterparty();
    }
    else if ($('.counterparty_reg[data-type=new]').length) {
      Counterparties.forRegister();
    }
    else if ($('.contract_reg[data-status=new]').length) {
      Contracts.ForRegisterTable();
    }
    else if ($('.banks').length > 0 && $('.banks[data-type=new]').length) {
      Banks.loadOption();
    }
    else if ($('.change_bank').length > 0 && !($( '.change_bank' ).length == $( '.change_bank.editable-click' ).length)) {
      Banks.xeditableBanks();
    }
    else if ($('[data-select2=false]')) {
      setSelect2();
    }

    setObserver();
  }
  mo = new MutationObserver(callback),
  options = {
      'childList': true,
      'subtree': true
  }
  mo.observe(document.body, options);
}

function editableStart() {
  return $("[data-xeditable=true]").each(function() {
    var name;
    var valueNew;
    var id = 0;
    return $(this).editable({
      ajaxOptions: {
        type: "PUT",
        dataType: "json"
      },
      params: xeditableParams,
      success: function(response, newValue) {
        $("table tr[value='" + id + "'] td#"+name).find('a').text(valueNew || newValue);
      }
    });
  });
};

xeditableParams = function(params) {
  var railsParams;
  id = params.pk.id;
  name = params.name;
  if ($(this).data().source) {
    $.map( $(this).data().source, function( val, i ) {
      if (val['id'] == params.value){
        valueNew = val['text'];
      }
    });
  }
  railsParams = {};
  railsParams[$(this).data("model")] = {};
  railsParams[$(this).data("model")][params.name] = params.value;
  railsParams['page'] = 'show';
  return railsParams;
}

function setSelect2() {
  $("[data-select=false]").each(function() {
    $(this).attr('data-select', true).select2();
  });
}
