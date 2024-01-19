"use strict";

jQuery('img.svg').each(function () {
  var $img = jQuery(this);
  var imgID = $img.attr('id');
  var imgClass = $img.attr('class');
  var imgURL = $img.attr('src');
  jQuery.get(imgURL, function (data) {
    // Get the SVG tag, ignore the rest
    var $svg = jQuery(data).find('svg'); // Add replaced image's ID to the new SVG

    if (typeof imgID !== 'undefined') {
      $svg = $svg.attr('id', imgID);
    } // Add replaced image's classes to the new SVG


    if (typeof imgClass !== 'undefined') {
      $svg = $svg.attr('class', imgClass + ' replaced-svg');
    } // Remove any invalid XML tags as per http://validator.w3.org


    $svg = $svg.removeAttr('xmlns:a'); // Replace image with new SVG

    $img.replaceWith($svg);
  }, 'xml');
});
$(document).on('click', '.show__all', function (e) {
  e.preventDefault();
  let list = $(this).prev();
  let show = list.data('show');
  let visible = list.find('> *:visible').length;
  let count = list.find('> *').length;

  for (var i = 1; i <= show; i++) {
    list.find('> *').eq(visible - 1 + i).removeClass('hidden');
  }

  visible = visible + show;

  if (visible >= count) {
    $(this).hide();
  }
});
$(document).on('click', '.aside__open', function (e) {
  e.preventDefault();
  $(this).next().slideToggle();
});
$(document).on('click', '.faq__title', function (e) {
  e.preventDefault();
  $(this).toggleClass('open');
  $(this).next().slideToggle();
});
$('.slider__ver03').slick();
$('.gallery__ver03').slick();
$(".gallery__ver03").on("afterChange", function (event, slick, currentSlide, nextSlide) {
  $('.gallery-nav__current').text(currentSlide + 1);
});
$('.gallery-nav__all').text($(".gallery__ver03").slick("getSlick").slideCount);
$(document).on('click', '.gallery-nav__prev', function () {
  $(".gallery__ver03").slick('slickPrev');
});
$(document).on('click', '.gallery-nav__next', function () {
  $(".gallery__ver03").slick('slickNext');
});
$(document).on('click', '.popup__open', function (e) {
  e.preventDefault();
  $('.overlay').toggleClass('open');
});
$(document).on('click', '.popup__close', function (e) {
  e.preventDefault();
  $('.overlay').removeClass('open');
  $('.popup').removeClass('open');
});
$(document).on('click', '.overlay', function (e) {
  e.preventDefault();
  $('.overlay').removeClass('open');
  $('.popup').removeClass('open');
});