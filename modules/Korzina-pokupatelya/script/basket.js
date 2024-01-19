jQuery(document).ready(function () {

    $(document).on("click", ".js_mk_order", function (data) {
        if ($(this).hasClass("disabled")){
            $(".js_mk_order_result").html("Вы не согласились с политикой обработки данных");
            return false;
        }
        $(".notEmptyOrder").removeClass("bad");
        var msg = '';
        if ($(".notEmptyOrder.e_mail").length) {
            if (!isValidEmail($(".notEmptyOrder.e_mail").val(), false)) {
                msg += "<p>E-mail заполнен некорректно</p>";
                $(".notEmptyOrder.e_mail").addClass("bad");
            }
        }
        $(".notEmptyOrder").each(function () {
            if (!$(this).val()){
                msg+= "<p>Не заполнен параметр: "+$(this).attr("placeholder")+"</p>";
                $(this).addClass("bad");
            }
        })

        $(".js_mk_order_result").html(msg);
        if (msg != ''){
            return false;
        }else{
            $.post("/basket/",{mk_order:true}, function(data){
                data = JSON.parse(data);
                if (data.status == "ERR"){
                    $(".js_mk_order_result").html(data.msg);
                }else{
                    $(".js_cart_all_item_page").html(data.msg);
                }
            });
        }
    });


    $(document).on("change", ".js_chg_values_order_data", function(){
        var obj = $(this);
        $.post("/basket/",{chg_field_in_order_data_basket:true, id:$(this).data("id"), value:$(this).val(), field:$(this).data("field")}, function(data){
            data = JSON.parse(data);
            if (data.status == "ERR"){
                alert(data.msg);
            }
        });
    });

    $(document).on("change", ".js_chg_values_order", function(){
        var obj = $(this);
        var value;

        value = $(this).val();

        /*if (obj.is(':checked')) {
            value = 1;
        }
        else if (obj.is(':disabled')) {
            value = 0;
        }else{
            value = $(this).val();
        }*/

        $.post("/basket/",{chg_field_in_order_basket:true, id:$(this).data("id"), value:value, field:$(this).data("field")}, function(data){
            data = JSON.parse(data);
            if (data.status == "ERR"){
                alert(data.msg);
            }else if(data.msg.reload_price == "true"){
                $(".js_basket").html(data.msg.html);
                $(".js_sum_all").html(data.msg.sum_all);
            }
        });
    });

    $(document).on("change", ".js_basket_delay", function(){
        var obj = $(this);
        var delay = 1;
        if (obj.is(':checked')){
            delay = 0;
        }
        $.post("/basket/",{chg_delay_in_basket:true, id:$(this).data("id"), delay:delay}, function(data){
            data = JSON.parse(data);
            if (data.status == "ERR"){
                alert(data.msg);
            }else{
                $(".js_basket").html(data.msg.html);
                $(".js_col_all").html(data.msg.col_all);
                $(".js_sum_all").html(data.msg.sum_all);
            }
        });
    });

    $(document).on("change", ".js_basket_delay_all", function(){
        var obj = $(this);
        var parent = obj.closest('.js_basket_all_items');

        if (obj.is(':checked')) {
            parent.find('.js_basket_delay:not(:checked)').each(function () {
               $(this).click();
            });
        }else if (!obj.is(':checked')) {
            parent.find('.js_basket_delay:checked').each(function () {
                  $(this).click();
            });
        }
    });

    $(document).on("click", ".js_basket_remove", function(){
        var obj = $(this);
        var root_obj = $(this).closest(".js_row_basket_item");
        $.post("/basket/",{remove_from_basket:true, id:$(this).data("id")}, function(data){
            data = JSON.parse(data);
            if (data.status == "ERR"){
                alert(data.msg);
            }else{
                root_obj.remove();
                $(".js_basket").html(data.msg.html);
                $(".js_col_all").html(data.msg.col_all);
                $(".js_sum_all").html(data.msg.sum_all);
            }
        });
    });

    $(document).on("keyup", '.js_check_order_tel', function () {
        $('.js_check_order_tel_alert').html("");
        if ($.isNumeric($(this).val().substr(17,1)))
        {
            $.post("/modules/Korzina-pokupatelya/ajax.php", {checkOrderTel: true, tel: $(this).val()}, function (data) {
                if (data == "Телефон подтвержден"){
                    $('.js_mk_order_wrap').html('<div class="js_mk_order button cart__order-button form__button">Оформить заказ</div>');
                }
                $('.js_check_order_tel_alert').html(data);

            });
        }else{
            $('.js_check_order_tel_alert').html("Введите полный номер");
            $('.js_mk_order_wrap').html("");
        }
    });
});

$(document).on("click", '.js_prove_order_tel', function () {
    var tel = $(".js_check_order_tel").val();
    $.post("/modules/Korzina-pokupatelya/ajax.php", {proveOrderTel: true, tel: tel}, function (data) {
        $('.js_check_order_tel_alert').html(data);
    });
});

$(document).on("click", '.js_accept_order_tel', function () {
    var parent = $(this).closest("div");
    var tel_code = parent.find("input").val();
    $.post("/modules/Korzina-pokupatelya/ajax.php", {acceptOrderTel: true, tel_code: tel_code}, function (data) {
        if (data == "Телефон подтвержден"){
            $('.js_mk_order_wrap').html('<div class="js_mk_order button cart__order-button form__button">Оформить заказ</div>');
        }
        $('.js_check_order_tel_alert').html(data);
    });
});


function chg_order_data_col(obj){
    var root_obj = obj.closest(".js_row_basket_item");
    $.post("/basket/",{chg_col_item_in_basket:true, id:obj.data("id"), col:obj.val()}, function(data){
        data = JSON.parse(data);
        if (data.status == "ERR"){
            alert(data.msg);
        }else{
            root_obj.find(".js_sum_local").html(data.msg.sum_local);
            $(".js_basket").html(data.msg.html);
            $(".js_col_all").html(data.msg.col_all);
            $(".js_sum_all").html(data.msg.sum_all);
        }
    });
}