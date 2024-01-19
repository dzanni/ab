jQuery(document).ready(function () {

    $(document).on("click", ".js_send_request_for_brand", function () {
        $(this).hide();
        $.post("/modules/Firms/ajax.php", {send_request_for_brand:true, id:$(this).data("id")}, function (data) {
            $(".js_send_request_for_brand_result").html(data);
        });
    });

    $(document).on("click", ".js_send_request_for_sotrudnik", function () {
        $(this).hide();
        $.post("/modules/Firms/ajax.php", {send_request_for_sotrudnik:true, id:$(this).data("id")}, function (data) {
            $(".js_send_request_for_sotrudnik_result").html(data);
        });
    });

    $(document).on("click", ".js_show_all", function () {
        var msg = $(this).data('msg');
        $(this).closest(".content__block").find('.to_hide').toggleClass('hidden');
        if ($(this).text() == "Скрыть") {
            $(this).html(msg)
        }else{
            $(this).html('Скрыть')
        }
    });

    $(document).on("click", ".js_firm_other_action", function () {
        $(this).closest(".comp-button__link_wrap").find('.comp-button__link_inner').toggleClass("on");

    });

});
