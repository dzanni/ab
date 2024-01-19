(function(jQuery) {

	$(document).on('click', '.header__city-current', function(e){
		e.preventDefault()
		$(this).toggleClass('active')
		$(this).next().slideToggle()
	})

	$(document).on('click', function(e) {
		if (!$(e.target).closest(".header__city, .header__city-popup").length) {
			$('.header__city-popup').slideUp();
		}
		e.stopPropagation();
	});

	$(document).on('click', '.scroll__up', function(e){
		e.preventDefault()
		$('body,html').animate({
			scrollTop: 0,
		}, 500)
	})

	$(document).on('click', '.header__menu-open', function(e) {
		e.preventDefault()
		$('body').toggleClass('animate__menu');
		$('#nav__mobile-bg').fadeToggle();
	})

	$(document).on('click', '#nav__mobile-bg, .nav__mobile-close', function(e) {
		e.preventDefault()
		$('body').removeClass('animate__menu');
		$('body').removeClass('animate__treemenu');
		$('.header__catalog').removeClass('open');
		$('header').removeClass('treemenu__open');
		$('#nav__mobile-bg').fadeOut();
	})

	$(document).on('click', '.header__catalog', function(e) {
		e.preventDefault()
		$(this).toggleClass('open')
		$(this).parent().parent().toggleClass('treemenu__open')
		$('body').toggleClass('animate__treemenu');
		$('#nav__mobile-bg').fadeToggle();
	})
	
	$(document).on('click', '.mobile__link.has__children, .mobile__link-child.has__children', function(e) {
		e.preventDefault()
		$(this).parent().toggleClass('open')
		$(this).next().slideToggle()
	})
	
	$(document).on('click', '.ver_01 .search__items-link', function(e) {
		e.preventDefault()
		let link = '.'+$(this).attr('href').slice(1)
		$(this).siblings('.search__items-link').removeClass('active')
		$(this).addClass('active')
		$(this).parent().next().find('.search__form').removeClass('active')
		$(this).parent().next().find('.search__form'+link).addClass('active')
	})

	$(document).on('click', '.ver_02 .search__items-link', function(e) {
		e.preventDefault()
		let link = '.'+$(this).attr('href').slice(1)
		$(this).siblings('.search__items-link').removeClass('active')
		$(this).addClass('active')
		$(this).parent().parent().next().find('.search__form').removeClass('active')
		$(this).parent().parent().next().find('.search__form'+link).addClass('active')
	})


	var main__slider = $('.main-screen__slider')
	if(main__slider.length)
		{
				main__slider.slick({
				dots: false,
				infinite: true,
				speed: 500,
				fade: true,
				cssEase: 'linear',
				arrows: false
			})
			$('.slider-nav__next').click(function() {
				main__slider.slick('slickNext');
			})
			$('.slider-nav__prev').click(function() {
					main__slider.slick('slickPrev');
			})
		}

	$("form").each(function(){
		$(this).find('input[name="form__checkbox"]').on('change', function() {
			if (!$(this).is(':checked')) $(this).parent().parent().parent().find('.form__button').attr('disabled',true).addClass("disabled")
			else $(this).parent().parent().parent().find('.form__button').attr('disabled',false).removeClass("disabled")
		});

	})

	$('div.overlay, a.popup__close').on('click', function(e){
		e.preventDefault()
		$('.overlay').fadeOut()
		$('.popup__wrap').fadeOut()
	})



	var adv__slider = $('.pict_slider__slider')
	if(adv__slider.length)
	{
		adv__slider.slick({
			dots: true,
			infinite: true,
			speed: 500,
			fade: true,
			cssEase: 'linear',
			arrows: false
		})
		$('.slider-nav__next').click(function() {
			adv__slider.slick('slickNext');
		})
		$('.slider-nav__prev').click(function() {
			adv__slider.slick('slickPrev');
		})
	}

	var product__slider = $('.product__more-slick')
	if(product__slider.length)
		{
			product__slider.slick({
				dots: false,
				infinite: true,
				speed: 500,
				arrows: true,
				slidesToShow: 3,
				slidesToScroll: 1,
				prevArrow: '<button class="slider-nav__button slider-nav__prev"><img class="svg" src="/i/icon__slider-prev.svg" alt=""></button>',
				nextArrow: '<button class="slider-nav__button slider-nav__next"><img class="svg" src="/i/icon__slider-next.svg" alt=""></button>',
				responsive: [
					{
						breakpoint: 991,
						settings: {
							slidesToShow: 2
						}
					},
					{
						breakpoint: 768,
						settings: {
							slidesToShow: 1
						}
					}
				]
		
			})
		}

	var product__image_slider = $('.product__image-slick')
	var product__slider_thumb = $('.product__image-slick-thumb')
	if(product__image_slider.length)
		{
			product__image_slider.slick({
				slidesToShow: 1,
				slidesToScroll: 1,
				dots: false,
				arrows: true,
				fade: true,
				infinite: true,
				_asNavFor: product__slider_thumb,
				prevArrow: '<button class="slider-nav__button slider-nav__prev"><img class="svg" src="/i/icon__slider-prev.svg" alt=""></button>',
				nextArrow: '<button class="slider-nav__button slider-nav__next"><img class="svg" src="/i/icon__slider-next.svg" alt=""></button>'
		
			});
		}
		
	if(product__slider_thumb.length) {
		product__slider_thumb.slick({
			slidesToShow: 4,
			slidesToScroll: 1,
			infinite: true,
			_asNavFor: product__image_slider,
			dots: false,
			arrows: true,
			prevArrow: '<button class="slider-nav__button slider-nav__prev"><img class="svg" src="/i/icon__slider-prev.svg" alt=""></button>',
			nextArrow: '<button class="slider-nav__button slider-nav__next"><img class="svg" src="/i/icon__slider-next.svg" alt=""></button>',
			focusOnSelect: true,
			responsive: [
				{
					breakpoint: 991,
					settings: {
						slidesToShow: 5
					}
				},
				{
					breakpoint: 768,
					settings: {
						slidesToShow: 3
					}
				},
				{
					breakpoint: 468,
					settings: {
						slidesToShow: 2
					}
				}
			]
		});
	}

	

	var search__slider = $('.search__slider')
	if(search__slider.length)
	{
		search__slider.slick({
			dots: true,
			infinite: true,
			speed: 500,
			fade: true,
			cssEase: 'linear',
			arrows: false
		})
		$('.slider-nav__next').click(function() {
			search__slider.slick('slickNext');
		})
		$('.slider-nav__prev').click(function() {
			search__slider.slick('slickPrev');
		})
	}

	var team__slider = $('.ver_01 .team__slider')
	if(team__slider.length)
	{
		team__slider.slick({
			dots: true,
			infinite: true,
			speed: 500,
			arrows: true,
			slidesToShow: 4,
			slidesToScroll: 1,
			prevArrow: '<button class="slider-nav__button slider-nav__prev"><img class="svg" src="/i/icon__slider-prev.svg" alt=""></button>',
			nextArrow: '<button class="slider-nav__button slider-nav__next"><img class="svg" src="/i/icon__slider-next.svg" alt=""></button>',
			responsive: [
				{
					breakpoint: 991,
					settings: {
						slidesToShow: 3
					}
				},
				{
					breakpoint: 768,
					settings: {
						slidesToShow: 2
					}
				},
				{
					breakpoint: 576,
					settings: {
						slidesToShow: 1
					}
				}
			]

		})
	}

	var team__slider = $('.ver_02 .team__slider')
	if(team__slider.length)
	{
		team__slider.slick({
			dots: true,
			infinite: true,
			speed: 500,
			arrows: true,
			slidesToShow: 2,
			slidesToScroll: 1,
			prevArrow: '<button class="slider-nav__button slider-nav__prev"><img class="svg" src="/i/icon__slider-prev.svg" alt=""></button>',
			nextArrow: '<button class="slider-nav__button slider-nav__next"><img class="svg" src="/i/icon__slider-next.svg" alt=""></button>',
			responsive: [
				{
					breakpoint: 991,
					settings: {
						slidesToShow: 1
					}
				}
			]

		})
	}

	var partners__slider = $('.partners__slider')
	if(partners__slider.length)
	{
		partners__slider.slick({
			dots: false,
			infinite: true,
			speed: 500,
			arrows: true,
			slidesToShow: 6,
			slidesToScroll: 1,
			prevArrow: '<button class="slider-nav__button slider-nav__prev"><img class="svg" src="/i/icon__slider-prev.svg" alt=""></button>',
			nextArrow: '<button class="slider-nav__button slider-nav__next"><img class="svg" src="/i/icon__slider-next.svg" alt=""></button>',
			responsive: [
				{
					breakpoint: 1200,
					settings: {
						slidesToShow: 5
					}
				},
				{
					breakpoint: 991,
					settings: {
						slidesToShow: 4
					}
				},
				{
					breakpoint: 768,
					settings: {
						slidesToShow: 3
					}
				},
				{
					breakpoint: 468,
					settings: {
						slidesToShow: 2
					}
				}
			]

		})
	}

	var stages__slider = $('.stages__slider')
	if(stages__slider.length)
	{
		stages__slider.on('init', function(slick){
			$(this).find('.slick-dots li').each(function(){
				if($(this).find('button').text() < 10) {
					$(this).find('button').text('0'+$(this).find('button').text())
				}
			})
		})
		stages__slider.on('beforeChange', function(event, slick, currentSlide, nextSlide){
			let curNum = parseInt($(this).find('.slick-dots li.slick-active button').text())
			$(this).find('.slick-dots li').removeClass('slick-line')
			let k = 0
			$(this).find('.slick-dots li').each(function(){
				if(k == nextSlide) {
					return false
				} else {
					$(this).addClass('slick-line')
				}
				k++
			})

		})
		stages__slider.slick({
			dots: true,
			infinite: false,
			speed: 500,
			fade: true,
			cssEase: 'linear',
			arrows: false,
			slidesToShow: 1,
			slidesToScroll: 1
		})
	}

	$('.content table').each(function(){
		$(this).wrap('<div class="content__table"></div>')
	})

	$(document).on('click', '.product__count-minus', function(e){
		e.preventDefault()
		$input = $(this).next();
		var count = parseInt($input.val()) - 1;
		count = count < 1 ? 1 : count;
		$input.val(count);
		$input.change()
	})

	$(document).on('click', '.product__count-plus', function(e){
		e.preventDefault()
		$input = $(this).prev();
		var count = parseInt($input.val()) + 1;
		$input.val(count);
		$input.change()
	})

	$(document).on('click', '.filter__subtitle', function(e){
		e.preventDefault()
		$(this).next().slideToggle()
		$(this).parent().toggleClass('close')
	})
	if($('.filter__select').length) {
		$('.filter__select').select2({
			placeholder: "Выберите раздел",
			maximumSelectionLength: 2,
			language: "ru"
		});
	}
	if($('.search__form-select').length) {
		$('.search__form-select').select2({
			placeholder: $(this).data('placeholder'),
			maximumSelectionLength: 2,
			language: "ru"
		});
	}

	if($('.filter__price').length) {
		$('.filter__price').each(function () {
			var obj = $(this).closest(".filter__price-wrap");
            let filter__min = parseInt(obj.find('.filter__price-min').attr("min"));
            let filter__max = parseInt(obj.find('.filter__price-max').attr("max"));
            let filter__min_val = parseInt(obj.find('.filter__price-min').val());
            let filter__max_val = parseInt(obj.find('.filter__price-max').val());

			$(this).slider({
                range: true,
                min: filter__min,
                max: filter__max,
                values: [filter__min_val,filter__max_val],
                slide: function( event, ui ) {
                    $( ".filter__price-min" ).val(ui.values[0])
                    $( ".filter__price-max" ).val(ui.values[1])
                }
            });
        });
	}

	$('.filter__value').each(function(index){
		if($(this).data('view')) {
			$(this).find('label').hide()
			$(this).find('label:lt('+$(this).data('view')+')').show()
			$(this).append('<a href="#" class="filter__more"><img src="/i/icon__arrow.svg" class="svg"></a>')
		}
	})

	$(document).on('click', '.filter__more', function(e){
		e.preventDefault()
		if($(this).hasClass('filter__hide')) { 
			$(this).siblings('label').hide()
			$(this).siblings('label:lt('+$(this).parent().data('view')+')').show()
		} else {
			$(this).siblings('label').show()
		}
		$(this).toggleClass('filter__hide')
	})

	$('.search__result .table-items__more').on('click', function(e){
		e.preventDefault()
		$(this)
		.hide()
		.siblings('.table-item')
		.find('.item-var__item')
		.removeClass('hide-item')
		$(this)
		.parent()
		.removeClass('more-items')
	})

	let count

	$('.item-var__amount-minus').click(function(e) {
		e.preventDefault()
			count = parseInt($(this).siblings('.item-var__amount-input').val());
			if (count == 2) {
					$(this).attr('disabled',true)
			}
			count--;
			$(this).siblings('.item-var__amount-input').val(count);
	})

	$('.item-var__amount-plus').click(function(e) {
			e.preventDefault()
			count = parseInt($(this).siblings('.item-var__amount-input').val());
			$(this).siblings('.item-var__amount-minus').attr('disabled',false)
			count++;        
			$(this).siblings('.item-var__amount-input').val(count);
	})

	if($('.item-var__amount-input').length) {
			$('.item-var__amount-input').each(function(){
					if($(this).val() == 1) {             
							$(this).siblings('.item-var__amount-minus').attr('disabled',true)
					}
			})
	}
	if($(window).width() < 991) {
		$('.filter__title').click(function(e) {
				e.preventDefault()
			$(this).parent().toggleClass('open')
		})
	} else {
		$('form.filter').removeClass('open')
	}

	$('.open__popup').click(function(e) {
		e.preventDefault();
		$('div.overlay').fadeIn();
		$($(this).attr('href')).fadeIn();
        var title = $(this).data("title"); // Эту строку и строки ниже добавили
		if (title != ''){
            $('#popup__order').find('.form_title').html(title);
		}
	});

    $('.open__popup-firm').click(function(e) {
        e.preventDefault();
        $('div.overlay').addClass('open');
        $('div.overlay').fadeIn();
        $($(this).attr('href')).fadeIn();
        var title = $(this).data("title"); // Эту строку и строки ниже добавили
        if (title != ''){
            $('#popup__firm').find('.form_title').html(title);
        }

        var firm_page = $(this).data("firm_page");
        if (firm_page){
            $('#popup__firm').find('.js_send_form').attr("data-query", location.search);
        }
        //
        // var email = $(this).data("email");
        // if (email){
        //     $('#popup__firm').find('.js_send_form').attr("data-email", email);
        // }
    });

// Это заменили на свою логику
	/*$('form.form__content').on('submit', function(){
		let form = $(this)
		$(this).find('.error__label').removeClass('visible')
		$(this).find('input.required').each(function(){
			if($(this).val() == '') {
				$(this).addClass('error')
				form.find('.error__label').addClass('visible')
				return false
			}
		})
	})
	*/
	
	/*jQuery(window).on('scroll', function(){
		scroll()
	});*/

	jQuery(window).on('resize', function(){

		if($(window).width() < 991) {
			$('.filter__title').click(function(e) {
					e.preventDefault()
				$(this).parent().toggleClass('open')
			})
		} else {
			$('form.filter').removeClass('open')
		}
	});

	jQuery(document).ready(function(){

    let mobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);

		jQuery('img.svg').each(function(){
			var $img = jQuery(this);
			var imgID = $img.attr('id');
			var imgClass = $img.attr('class');
			var imgURL = $img.attr('src');
	  
			jQuery.get(imgURL, function(data) {
				// Get the SVG tag, ignore the rest
				var $svg = jQuery(data).find('svg');
	  
				// Add replaced image's ID to the new SVG
				if(typeof imgID !== 'undefined') {
					$svg = $svg.attr('id', imgID);
				}
				// Add replaced image's classes to the new SVG
				if(typeof imgClass !== 'undefined') {
					$svg = $svg.attr('class', imgClass+' replaced-svg');
				}
	  
				// Remove any invalid XML tags as per http://validator.w3.org
				$svg = $svg.removeAttr('xmlns:a');
	  
				// Replace image with new SVG
				$img.replaceWith($svg);
	  
			}, 'xml');
	  
		});

	});

    $('input[name=phone],input.tel').inputmask("+7 (999) 999-99-99");

// function setEqualHeight(columns)
// {
// var tallestcolumn = 0;
// columns.each(
// function()
// {
// currentHeight = $(this).height();
// if(currentHeight > tallestcolumn)
// {
// tallestcolumn = currentHeight;
// }
// }
// );
// columns.height(tallestcolumn);
// }


})(jQuery);

 
//  