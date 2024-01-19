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
		}

	$('.slider-nav__next').click(function() {
    main__slider.slick('slickNext');
	})
	// Go to the previous item
	$('.slider-nav__prev').click(function() {
			// With optional speed parameter
			// Parameters has to be in square bracket '[]'
			main__slider.slick('slickPrev');
	})

	$("form").find('input[name="form__checkbox"]').on('change', function() {
		if (!$(this).is(':checked')) $(this).parent().parent().find('.form__button').attr('disabled',true) 
		else $(this).parent().parent().find('.form__button').attr('disabled',false) 
	});
	
	jQuery(window).on('scroll', function(){
		scroll()
	});

	jQuery(window).on('resize', function(){

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

    $('.js_send_form').click(function () {

        var self = $(this);
        var form = self.closest('.form_block');

        var title = form.find('.form_title').html();
        var email = self.data("email");
        var admin = self.data("admin");

       if (form.find('.agree').is(':checked') === false) {
            form.find('.result_not').html('Нужно согласиe на обработку данных');
            return false;
        }
        var error = [];
        form.find('.data-provider.not-empty').each(function () {
            if ($(this).val() == '') {
                error.push($(this).data('title'));
                $(this).css("border", "1px solid red");
            }
        });
        if (error.length) {
            form.find('.result_not').html('<p>Обязательно для заполнения:</p>' + error.join(', ') + '.' + '').show();
            return false;
        }

        var token = self.data("token");

        /*grecaptcha.ready(function() {
            e.preventDefault();
            grecaptcha.execute(token, {action: 'submit'}).then(function(token) {
                form.find(".js_token_captcha").val(token);
            });
        });*/

        var tmp = {};
        var index = 0;
        form.find('.data-provider').each(function (i) {
            tmp['sendData[' + i + '][title]'] = $(this).data('title');
            tmp['sendData[' + i + '][value]'] = $(this).val();
            index++;
        });

        tmp['sendData[' + index + '][title]'] = "URL";
        tmp['sendData[' + index + '][value]'] = location.href;

        index++;
        tmp['sendData[' + index + '][title]'] = "Форма";
        tmp['sendData[' + index + '][value]'] =  title;

        index++;
        tmp['sendData[' + index + '][title]'] = "Наш email";
        tmp['sendData[' + index + '][value]'] =  email;

        index++;
        tmp['sendData[' + index + '][title]'] = "Админ email";
        tmp['sendData[' + index + '][value]'] =  admin;

        $.post("/ajax/messager.php", tmp, function (data) {
            form.find('.result').css('text-align', 'center');
            form.find('.result').css('font-family', 'SFUIDisplay-Semibold, sans-serif');
            form.find('.result').css('color', 'red'); // Ввели для Шаблона2022
            form.find('.result').html('Сообщение отправлено');

        });

        return false;
    });

    $('.js_chg_city').click(function () {
    	var city = $(this).data('city');
    	$(".header__city-current .js_city_anchor").html(city);
     });

    $('.js_chg_header_and_footer').click(function () {
        var choice = $(this).data('choice');
        var type = $(this).data('type');
        if (type == 'HEADER'){
           	$('.js_chg_header_and_footer[data-type="HEADER"]').html('Выбрать');
            $('.js_chg_header_and_footer[data-type="HEADER"]').removeClass('choosen');
            $(this).html('ВЫБРАН');
            $(this).addClass('choosen');
		}
        if (type == 'FOOTER'){
            $('.js_chg_header_and_footer[data-type="FOOTER"]').html('Выбрать');
            $('.js_chg_header_and_footer[data-type="FOOTER"]').removeClass('choosen');
            $(this).html('ВЫБРАН');
            $(this).addClass('choosen');
        }

        $.post("/ajax/ajax.php", {choice:choice, type:type, chgHeaderFooter : true}, function (data) {

        });
    });

    $('.js_edit_header_and_footer').click(function () {
        $(".techno").removeClass('hidden');
        $("header").removeClass('hidden');
        $("footer").removeClass('hidden');
        $(".techno_button_on").addClass('hidden');
        $(".techno_button_off").removeClass('hidden');
    });

    $('.js_end_edit_header_and_footer').click(function () {

        var header_anchor = $(document).find('.choosen[data-type="HEADER"]');
        var header_id = 'ver_0' + header_anchor.attr("data-choice");
        var footer_anchor = $(document).find('.choosen[data-type="FOOTER"]');
        var footer_id = 'ver_0' + footer_anchor.attr("data-choice");

       	$(".techno").addClass('hidden');
        $('header').not(`[class=${header_id}]`).addClass('hidden');
        $('footer').not(`[class=${footer_id}]`).addClass('hidden');
        $(".techno_button_on").removeClass('hidden');
        $(".techno_button_off").addClass('hidden');

    });



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