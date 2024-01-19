$(document).ready(function(){
    $('.promo__main').slick({
      slidesToShow: 1,
      slidesToScroll: 1,
      arrows: false,
      fade: true,
      asNavFor: '.promo__slides'
    });

    $('.promo__slides').slick({
      slidesToShow: 3,
      slidesToScroll: 1,
      asNavFor: '.promo__main',
      variableWidth: false,
      dots: false,
      prevArrow: $('.promo__prev'),
      nextArrow: $('.promo__next'),
      focusOnSelect: true,
        responsive: [
        {
        breakpoint: 1919,
        settings: {
            variableWidth: false,
            }
        },
        {
        breakpoint: 900,
        settings: {
            variableWidth: false,
            slidesToShow: 2,
            slidesToScroll: 1,
            }
        }
       ]
    });
      $(".promo__main, .promo__slides").on('afterChange', function(event, slick, currentSlide){
     $(".count-active").text(currentSlide + 1);
  });
});
$(document).ready(function(){
    $('.partners__slides').slick({
      lazyLoad: 'ondemand',
      centerMode: false,
      variableWidth: true,
      prevArrow: $('.partners__prev'),
      nextArrow: $('.partners__next'),
      slidesToShow: 5,
      slidesToScroll: 5,
      responsive: [
        {
        breakpoint: 1919,
        settings: {
            variableWidth: false,
            }
        },
        {
        breakpoint: 1700,
        settings: {
            variableWidth: false,
            slidesToShow: 3,
            slidesToScroll: 3,
            }
        },
        {
        breakpoint: 650,
        settings: {
            slidesToShow: 2,
            slidesToScroll: 2,
            variableWidth: false,
            }
        },
        {
        breakpoint: 340,
        settings: {
            slidesToShow: 1,
            slidesToScroll: 1,
            variableWidth: false,
            }
        }
      ]
    });
    $(".partners__slides").on('afterChange', function(event, slick, currentSlide){
     $(".partners-active").text(currentSlide + 1);
  });
});
$(document).ready(function(){
  $('.item__slider-main').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    fade: true,
    asNavFor: '.item__slider-slides'
  });

  $('.item__slider-slides').slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    asNavFor: '.item__slider-main',
    variableWidth: false,
    dots: false,
    arrows: false,
    focusOnSelect: true,
      responsive: [
      {
      breakpoint: 1919,
      settings: {
          variableWidth: false,
          }
      },
      {
      breakpoint: 900,
      settings: {
          variableWidth: false,
          slidesToShow: 2,
          slidesToScroll: 1,
          }
      }
     ]
  });
 
});