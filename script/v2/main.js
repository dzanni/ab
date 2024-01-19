"use strict";

$(document).ready(function () {
  svg4everybody({});
}); // Полифилы
// forEach IE 11

if ('NodeList' in window && !NodeList.prototype.forEach) {
  console.info('polyfill for IE11');

  NodeList.prototype.forEach = function (callback, thisArg) {
    thisArg = thisArg || window;

    for (var i = 0; i < this.length; i++) {
      callback.call(thisArg, this[i], i, this);
    }
  };
} // closest IE 11


(function () {
  if (!Element.prototype.closest) {
    Element.prototype.closest = function (css) {
      var node = this;

      while (node) {
        if (node.matches(css)) return node;else node = node.parentElement;
      }

      return null;
    };
  }
})(); // matches IE 11


(function () {
  if (!Element.prototype.matches) {
    Element.prototype.matches = Element.prototype.matchesSelector || Element.prototype.webkitMatchesSelector || Element.prototype.mozMatchesSelector || Element.prototype.msMatchesSelector;
  }
})(); //Array.form IE 11


if (!Array.from) {
  Array.from = function (object) {
    'use strict';

    return [].slice.call(object);
  };
}

$(document).ready(function () {
  $(document).on('click', '.block__more', function (e) {
    e.preventDefault();
    $(this).toggleClass('open');
    $(this).siblings('.block__hidden').slideToggle();
  });
});
$(document).ready(function () {
  $(document).on('click', '.open__nav', function (e) {
    e.preventDefault();
    $(this).toggleClass('open');
    $('header .nav').slideToggle();
  });
});
$(document).ready(function () {
  $('select.select').select2({
    minimumResultsForSearch: Infinity
  });
}); // $('.input__show-button').each(function() {
// 	console.log($(this).data('view'));
// 	console.log($('[data-field='+$(this).data('view')+']').val());
// });

$(document).on('click', '.input__show-button', function (e) {
  e.preventDefault();
  $(this).find('.svg-sprite-icon').removeClass('selected');

  if ($('[data-field=' + $(this).data('view') + ']').val() == 0) {
    $('[data-field=' + $(this).data('view') + ']').val(1);
    $(this).find('.icon__eye-show').addClass('selected');
  } else {
    $('[data-field=' + $(this).data('view') + ']').val(0);
    $(this).find('.icon__eye-hide').addClass('selected');
  }

  $('.show__label').text($(this).find('.selected').data('text'));
  $('[data-field=' + $(this).data('view') + ']').change();
});
$('.input__show-button').hover(function () {
  $(this).append('<span class="show__label"></span>');
  $('.show__label').text($(this).find('.selected').data('text'));
}, function () {
  $('.show__label').remove();
});
$(document).on('change', '.input__birthday-day, .input__birthday-month, .input__birthday-year', function () {
  $('[data-field=f_birthday]').val($('.input__birthday-year').val() + '-' + $('.input__birthday-month').val() + '-' + $('.input__birthday-day').val());
  $('[data-field=f_birthday]').change(); //console.log($('.input__birthday-day').val()+'.'+$('.input__birthday-month').val()+'.'+$('.input__birthday-year').val());
}); // $("textarea.height__auto").each(function () {
//   this.setAttribute("style", "height:" + (this.scrollHeight) + "px;");
// }).on("input", function () {
//   this.style.height = "auto";
//   this.style.height = (this.scrollHeight) + "px";
// });

$(document).on('click', '.input__show-password', function (e) {
  e.preventDefault();
  $(this).toggleClass('active');

  if ($(this).prev().attr('type') == 'text') {
    $(this).prev().attr('type', 'password');
  } else {
    $(this).prev().attr('type', 'text');
  } // if($(this).hasClass('active')) {
  // 	$(this).prev().attr('type','password')
  // } else {
  // 	$(this).prev().attr('type','text')
  // }

});
$(document).on('change', 'input[name=select_type-f]', function () {
  if ($('input[name=select_type-f]:checked').val() == 'phone') {
    $(this).parent().parent().parent().find('form').hide();
    $(this).parent().parent().parent().find('form.auth_form-phone').show();
  }

  if ($('input[name=select_type-f]:checked').val() == 'mail') {
    $(this).parent().parent().parent().find('form').hide();
    $(this).parent().parent().parent().find('form.auth_form-mail').show();
  }
});
$(document).on('change', 'input[name=select_type]', function () {
  if ($('input[name=select_type]:checked').val() == 'phone') {
    $(this).parent().parent().parent().find('form').hide();
    $(this).parent().parent().parent().find('form.auth_form-phone').show();
  }

  if ($('input[name=select_type]:checked').val() == 'mail') {
    $(this).parent().parent().parent().find('form').hide();
    $(this).parent().parent().parent().find('form.auth_form-mail').show();
  }
});
$(document).on('click', '.forgot-phone', function (e) {
  e.preventDefault();
  $('.auth_form-login').hide();
  $('.auth_form-forgot').show();
  $('.auth_form-phone').show();
});
$(document).on('click', '.forgot-mail', function (e) {
  e.preventDefault();
  $('.auth_form-login').hide();
  $('.auth_form-forgot').show();
  $('.auth_form-phone').show();
});
$(document).on('click', '.comp__review-answer', function (e) {
  e.preventDefault();
  $(this).parent().next().addClass('show');
});
$(document).on('click', '.quest__nav-edit', function (e) {
  e.preventDefault();
  $(this).hide();
  $(this).closest('.comp__reviews-item').find('.comp__review-text').addClass('show');
});
$(document).on('click', '.review__add-q .review__add-button', function (e) {
  e.preventDefault();
  $(this).closest('.comp__reviews-item').find('.comp__review-text-inner').text($(this).prev().val());
  $(this).closest('.comp__reviews-item').find('.quest__nav-edit').show();
  $(this).closest('.comp__reviews-item').find('.comp__review-text').removeClass('show');
});
$(document).on('click', '.review__add .review__add-button', function (e) {
  e.preventDefault();
  $(this).closest('.comp__review-add').find('.comp__review-text-inner-a').text($(this).prev().val());
  $(this).closest('.comp__review-add form').hide();
});
$(document).on('click', '.quest__nav-del', function (e) {
  e.preventDefault();
});
$(document).on('click', '.js_popup', function (e) {
  e.preventDefault(); //console.log($(this).attr('href'))

  $('.popup' + $(this).attr('href')).addClass('popup__show');
});
$(document).on('click', '.popup__close', function (e) {
  e.preventDefault();
  $('.popup').removeClass('popup__show');
});
$(document).on('click', '.quest__item-open-link', function (e) {
  e.preventDefault();
  $(this).addClass('hidden');
  $(this).parent().next().slideToggle();
});
/*$(document).on('click', '.js_set_edit', function(e){
	e.preventDefault()
	$('.popup').removeClass('popup__show')
})*/

$(document).on('click', '.mobile__aside-open', function (e) {
  e.preventDefault();
  $(this).toggleClass('on');
  $(this).next().slideToggle();
});

$(document).on('click', '.js_edit_answer', function (e) {
  setTimeout(function(){
      autosize();
  },0)
  console.log(1)
});

set_message_list_height();

function set_message_list_height() {
  var height = $(window).outerHeight() - $('header').outerHeight() - $('footer').outerHeight() - 56 - 66 - 50 - $('.message__user-send-wrap').outerHeight();

  if (height < 300) {
    height = 300;
  }

  $('.message__list-wrap-inner').height(height); //$('.message__list').css('transform','translateY(-'+$(".message__list").height()+'px)')
}

let $parentDiv = $('.message__list-wrap-inner');
let $innerListItem = $('.message__list ');
$(window).on('load', function () {
  $parentDiv.scrollTop($innerListItem.outerHeight());
});
$(window).resize(function () {
  set_message_list_height();
});
$parentDiv.scroll(function () {
  if ($parentDiv.scrollTop() == 0) {
    console.log('ДОКРУТИЛ!');
  }

  ;
});
autosize();

function autosize() {
  var text = $('.textarea_autoheight');
  text.each(function () {
    $(this).attr('rows', 1);
    resize($(this));
  });
  text.on('input', function () {
    resize($(this));
  });

  function resize($text) {
    $text.css('height', 'auto');

    if ($text[0].scrollHeight < 100) {
      $text.css('overflow', 'hidden');
    } else {
      $text.css('overflow-y', 'scroll');
    }

    $text.css('height', $text[0].scrollHeight + 'px');
    //console.log($text.height());
  }
} //console.log($(window).outerHeight() - $('header').outerHeight() - $('footer').outerHeight() - 56 - $('.message__user-send-wrap').outerHeight())
//console.log($(window).outerHeight() +' '+ $('header').outerHeight() +' '+ $('footer').outerHeight() +' '+ $('.message__user-send-wrap').outerHeight())