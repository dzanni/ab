$(function(){
    $('.burger-menu').click(function(){
        $('.burger-menu, .aside, .subheader__nav').toggleClass('active');
        $('body').toggleClass('hidden');
    });

      $('.js_add_favorite').on('click', function(){
          var obj = $(this);
        $.post("/modules/Vivod-spiska-tovarov/ajax.php",{id:$(this).data('id'), addFavorite:true, ajax:true},function (data) {
            if (data == "on"){
                obj.addClass("active");
            }else{
                obj.removeClass("active");
            }

        });
      });

    /*

    if($('.cart_count').length) {
        $('.cart_count').each(function(){
            if($(this).val() == 1) {
                $(this).siblings('.catalog__count-minus').attr('disabled',true)
            }
        })
    }

    let count

    $('.catalog__count-minus').click(function() {
        count = parseInt($(this).siblings('.cart_count').val());
        if (count == 2) {
            $(this).attr('disabled',true)
        }
        count--;
        $(this).siblings('.cart_count').val(count);
    })

    $('.catalog__count-plus').click(function() {
        count = parseInt($(this).siblings('.cart_count').val());
        $(this).siblings('.catalog__count-minus').attr('disabled',false)
        count++;
        $(this).siblings('.cart_count').val(count);
    })

    if($('.item__count-input').length) {
        $('.item__count-input').each(function(){
            if($(this).val() == 1) {
                $(this).siblings('.item__count-minus').attr('disabled',true)
            }
        })
    }

    let itemCount

    $('.item__count-minus').click(function() {
        itemCount = parseInt($(this).siblings('.item__count-input').val());
        if (itemCount == 2) {
            $(this).attr('disabled',true)
        }
        itemCount--;
        $(this).siblings('.item__count-input').val(itemCount);
    })

    $('.item__count-plus').click(function() {
        itemCount = parseInt($(this).siblings('.item__count-input').val());
        $(this).siblings('.item__count-minus').attr('disabled',false)
        itemCount++;
        $(this).siblings('.item__count-input').val(itemCount);
    })

    if($('.cart__item-count-input').length) {
        $('.cart__item-count-input').each(function(){
            if($(this).val() == 1) {
                $(this).siblings('.cart__item-count-minus').attr('disabled',true)
            }
        })
    }

    let cartItemCount

    $('.cart__item-count-minus').click(function(e) {
        e.preventDefault()
        cartItemCount = parseInt($(this).siblings('.cart__item-count-input').val());
        if (cartItemCount == 2) {
            $(this).attr('disabled',true)
        }
        cartItemCount--;
        $(this).siblings('.cart__item-count-input').val(cartItemCount);
    })

    $('.cart__item-count-plus').click(function(e) {
        e.preventDefault()
        cartItemCount = parseInt($(this).siblings('.cart__item-count-input').val());
        $(this).siblings('.cart__item-count-minus').attr('disabled',false)
        cartItemCount++;
        $(this).siblings('.cart__item-count-input').val(cartItemCount);
    })

   */


    let minVal = parseInt($('.aside__filter-range__min').val())
    let maxVal = parseInt($('.aside__filter-range__max').val())

    if($("#aside__filter-range").length) {
        $("#aside__filter-range").slider({
            range: true,
            min: minVal,
            max: maxVal,
            values: [minVal,maxVal],
            slide: function( event, ui ) {
                $('.aside__filter-range__min').val(ui.values[0])
                $('.aside__filter-range__max').val(ui.values[1])
                //$( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
            }
        });
        $('.aside__filter-range__min').on('change', function(){
            if(parseInt($(this).val()) < minVal) $(this).val(minVal)
            if(parseInt($(this).val()) > parseInt($('.aside__filter-range__max').val())) {
                $(this).val(parseInt($('.aside__filter-range__max').val()))
            }
            $("#aside__filter-range").slider( "values", [ $('.aside__filter-range__min').val(), $('.aside__filter-range__max').val() ] );
        })
        $('.aside__filter-range__max').on('change', function(){
            if(parseInt($(this).val()) > maxVal) $(this).val(maxVal)
            console.log(parseInt($(this).val()), minVal)
            if(parseInt($(this).val()) < parseInt($('.aside__filter-range__min').val())) {
                $(this).val(parseInt($('.aside__filter-range__min').val()))
            }
            $("#aside__filter-range").slider( "values", [ $('.aside__filter-range__min').val(), $('.aside__filter-range__max').val() ] );
        })
    }

    
    $('.item__tabs-link').on('click', function(e){
        e.preventDefault()
        $('.item__tabs-link').removeClass('active')
        $(this).addClass('active')
        $('.item__tabs-item').removeClass('active')
        $('.item__tabs-item'+$(this).attr('href')).addClass('active')
    })

    $(document).on('click', '.order__item-but-canceled:not(.open)', function(e){
        e.preventDefault()
        $(this).parent().parent().next().toggleClass('open')
        $(this).text('Не возвращать товар')
        $(this).toggleClass('open')
    })

    $(document).on('click', '.order__item-but-canceled.open', function(e){
        e.preventDefault()
        $(this).parent().parent().next().toggleClass('open')
        $(this).text('Вернуть товар')
        $(this).toggleClass('open')
    })

    $(document).on('click', '.order__item-comment-edit-link', function(e){
        e.preventDefault()
        $(this).parent().next().hide()
        $(this).parent().next().next().show()
    })

    $(document).on('click', '.order__item-comment-edit-button-cancel', function(e){
        e.preventDefault()
        $(this).parent().parent().hide()
        $(this).parent().parent().prev().show()
    })

    $('.cart-dp__field-delivery').on('change', function(){
        if( $(this).val() == 'more' ) {
            $('.cart-dp__field-delivery-more').removeClass('hide')
        } else {
            $('.cart-dp__field-delivery-more').addClass('hide')
        }
    })

    $('.cart-dp__field-contacts').on('change', function(){
        if( $(this).val() == 'more' ) {
            $('.cart-dp__field-contacts-more').removeClass('hide')
        } else {
            $('.cart-dp__field-contacts-more').addClass('hide')
        }
    })

});

jQuery('img.svg').each(function() {
    var $img = jQuery(this);
    var imgID = $img.attr('id');
    var imgClass = $img.attr('class');
    var imgURL = $img.attr('src');
  
    $.get(imgURL, function(data) {
      // Get the SVG tag, ignore the rest
      var $svg = jQuery(data).find('svg');
  
      // Add replaced image's ID to the new SVG
      if (typeof imgID !== 'undefined') {
        $svg = $svg.attr('id', imgID);
      }
      // Add replaced image's classes to the new SVG
      if (typeof imgClass !== 'undefined') {
        $svg = $svg.attr('class', imgClass + ' replaced-svg');
      }
  
      // Remove any invalid XML tags as per http://validator.w3.org
      $svg = $svg.removeAttr('xmlns:a');
  
      // Check if the viewport is set, if the viewport is not set the SVG wont't scale.
      if (!$svg.attr('viewBox') && $svg.attr('height') && $svg.attr('width')) {
        $svg.attr('viewBox', '0 0 ' + $svg.attr('height') + ' ' + $svg.attr('width'))
      }
  
      // Replace image with new SVG
      $img.replaceWith($svg);
  
    }, 'xml');
  
  });

