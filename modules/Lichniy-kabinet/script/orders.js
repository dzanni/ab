jQuery(document).ready(function () {

    $(document).on("click", ".js_set_edit", function () {
        $(this).closest(".js_chg_row").find(".js_val").addClass("hidden");
        $(this).closest(".js_chg_row").find(".js_chg").removeClass("hidden");
    });

    $(document).on("click", ".js_chg_order_btn", function (){
        $(this).closest(".js_order_element").find(".element_value").hide();
        $(this).closest(".js_order_element").find(".chg_element_hide").removeClass("chg_element_hide");
        //$(this).hide();
    });

    $(document).on("change", ".js_chg_order", function () {
        var res = {};
        res["chg_data"] = true;
        res["id"] = $(this).closest(".js_order_element").data("order");
        res['v'] = $(this).val();
        res['f'] = $(this).data("field");
        if ($(this).closest(".js_row_basket_item").length){
            res['item'] = $(this).closest(".js_row_basket_item").data("id");
        }
        $.post("/modules/Lichniy-kabinet/orderAjax.php", res, function (data) {
            data = $.parseJSON(data);
            showAlert(data.msg, data.class);
            if (res['f'] == "col" || res['f'] == "price" || res['f'] == "deliverPrice"){
                reload_order(res["id"]);
            }
        });
    });


    $(document).on("click", ".js_apply_order", function () {
        var res = {};
        res["apply_order"] = true;
        $(this).hide();
        res["id"] = $(this).closest(".js_order_element").data("order");
        $.post("/modules/Lichniy-kabinet/orderAjax.php", res, function (data) {
            data = $.parseJSON(data);
            showAlert(data.msg, data.class);
        });
    });
    $(document).on("click", ".js_add_in_order_btn", function () {
        var res = {};
        res["add_in_order"] = true;
        var obj = $(this).closest(".js_add_in_order");
        res["id"] = $(this).closest(".js_order_element").data("order");
        res['art'] = obj.find(".js_add_tovar_id").val();
        res['col'] = obj.find(".js_add_order_col").val();
        if (res['art'] > 0 && res['col'] > 0){
            $.post("/modules/Lichniy-kabinet/orderAjax.php", res, function (data) {
                data = $.parseJSON(data);
                showAlert(data.msg, data.class);
                if (data.reload_order == 1){
                    reload_order(res["id"]);
                }
            });
        }else{
            showAlert("ОШИБКА: Не указан артикул или количество!", "bad");
        }
    });

    $(document).on("click", ".js_order_remove", function () {
        var res = {};
        res["remove_from_order"] = true;
        var obj = $(this).closest(".js_add_in_order");
        res["order_id"] = $(this).closest(".js_order_element").data("order");
        res["order_element_id"] = $(this).data("id");
        $.post("/modules/Lichniy-kabinet/orderAjax.php", res, function (data) {
            data = $.parseJSON(data);
            showAlert(data.msg, data.class);
            if (data.reload_order == 1){
                reload_order(res["order_id"]);
            }
        });
    });

});

function reload_order(order){
    $.get("/account/orders_all/", {s_id:order,page:1,getAjax:true}, function (data){
        data = JSON.parse(data);
        var html = data.html;
        html = $(html).find(".order_"+order).html();
        $(".order_"+order).html(html);
    });
}