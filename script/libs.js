jQuery(document).ready(function () {

     $(document).on("click", ".js_add_in_basket", function () {
       var obj = $(this).closest(".js_add_in_basket_div");
       var query = {};
       obj.find(".js_add_in_basket_data").each(function () {
           query[$(this).attr("name")] = $(this).val();
       });
       query['addInBasket'] = true;
       $.post("/basket/",query,function (data) {
            data = JSON.parse(data);
            if (data.status == "ERR"){
                alert(data.msg);
            }else{
                obj.html(data.msg.btn);
                $(".js_basket").html(data.msg.html);
            }
       });
    });

    $(document).on("click",".js_chg_col",function () {
        chg_col_plus_minus($(this).closest(".js_plus_minus_chg").find(".js_col_item"), $(this).data("type"));
    });

    $(document).on("change",".js_col_item",function () {
        chg_col_plus_minus($(this), '');
    });

});


function isValidEmail (email, strict)
{
    if ( !strict ) email = email.replace(/^\s+|\s+$/g, '');
    return (/^([a-z0-9_\-]+\.)*[a-z0-9_\-]+@([a-z0-9][a-z0-9\-]*[a-z0-9]\.)+[a-z]{2,4}$/i).test(email);
}

function chg_col_plus_minus(obj, type) {
    var col = parseInt(obj.val());

    var max = parseInt((obj.data("max")) ? obj.data("max") : 1);
    var inpack = parseInt((obj.data("inpack")) ? obj.data("inpack") : 1);

        col = Number(col);

    if (type == "plus"){
        if (col >= max) {
            return false;
        } else if (col >= (Math.ceil(max/inpack)*inpack) - inpack) {
            col = max;
        } else {
            col = col+inpack;
        }
    }else if(type == "minus"){
        if ((col <= inpack) && (col <= max)) {
            return false;
        } else if ((col <= max) && (col > ((Math.ceil(max/inpack)*inpack) - inpack))) {

            col = Math.ceil(max/inpack)*inpack - inpack;
        } else {
            col = col-inpack;
        }
    }

    if ((col <= 0) || !(Number.isInteger(col))) {
        col =  Math.min(inpack, max);
    } else if (col >= max) {
        col = max;
        console.log(123);
    } else if (col < inpack) {
        col = Math.min(inpack, max);
    } else {
        col = Math.min((Math.ceil(col/inpack)*inpack), max);
    }
    obj.val(col);
    if (obj.hasClass("js_basket_chg_col")){
        chg_order_data_col(obj);
    }
}

function showMsg(obj, msg, err = false){
    if (!err){
        obj.removeClass("bad").addClass("good");
    }else{
        obj.removeClass("good").addClass("bad");
    }
    obj.html(msg);
}

