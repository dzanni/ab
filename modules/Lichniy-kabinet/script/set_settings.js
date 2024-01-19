jQuery(document).ready(function () {
    load_price_set_settings();
    check_price();

    function load_price_set_settings() {
        var obj = $(".load_price_set_settings");
        $.get("/modules/Lichniy-kabinet/ajax.php",{load_price_set_settings:true,stock:obj.data("id")}, function(data){
            obj.html(data);
        });
    }

    $(document).on("change", ".js_chg_and_reload", function () {
        var res = {};
        res["chg_data"] = true;
        res["f_id"] = $(this).data("id");
        res[$(this).data("field")] = $(this).val();
        var field = $(this).data("field");
        $.post(location.href,res,function(data){
            data = $.parseJSON(data);
            if (field == "f_csv_charset" || field == "f_csv_delitel" ){
                load_price_set_settings();
            }
            showAlert(data.msg, data.class);
        });
    });

    $(document).on("change",".set_settings_js", function () {
        var obj = $(this).closest(".load_price_set_settings");
        obj.data("id");
        var str = '';
        obj.find(".set_settings_js").each(function () {
            str+=$(this).val()+",";
        });
        $(".js_f_fOrder").val(str).change();
        check_price();
    });
    
    function check_price() {
        $.post("/modules/Lichniy-kabinet/ajax.php",{check_price:true,forder:$(".js_f_fOrder").val()}, function(data){
            $(".js_check_price").html(data);
        });
    }

    function showAlert(html, classname) {
        var timeVar = new Date().getTime();
        $(".alerts").prepend('<div class="alert alert' + timeVar + " " + classname + '"><button type="button" class="close" data-dismiss="alert">&times;</button>' + html + '</div>');
        setTimeout(function () {
            $(".alert" + timeVar).fadeOut(400, function () {
                $(".alert" + timeVar).remove()
            })
        }, 2000);
    }
});