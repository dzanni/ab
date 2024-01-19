jQuery(document).ready(function () {

    if ($(".js_ws_search_query_brands").length){
        $("html").data("check", false);
        $("html").data("ws_col", $(".js_ws_search_query_brands").length);
        $("html").data("ws_completed", 0);
        $(".js_ws_search_query_brands").each(function () {
            $.get(location.pathname, {article:$(".js_article").val(), ws_id:$(this).val()}, function (data) {
                if (data == 1){
                    $("html").data("ws_completed", $("html").data("ws_completed")+1);
                    if ($("html").data("ws_completed") == $("html").data("ws_col")){
                        $("html").data("check", true);
                        check_brands();
                    }
                }
            });
        });
    }

    function check_brands() {
        if (!$("html").data("check")){

        }else{
            $.get(location.pathname, {article:$(".js_article").val(), getAllBrands: true}, function (data) {
                if (data == 'NO_BRANDS_IN_DB'){
                    location.href = "/article-search/?article="+$(".js_article").val()+"&br_search";
                    return;
                }
                $(".js_asearch_result").html(data);
            });
        }
    }

    if ($(".js_ws_search_query_brands_tovar").length){
        $("html").data("check", false);
        $("html").data("ws_col", $(".js_ws_search_query_brands_tovar").length);
        $("html").data("ws_completed", 0);
        $(".js_ws_search_query_brands_tovar").each(function () {
            $.get(location.pathname, {article:$(".js_article").val(), ws_id:$(this).data("id"), ws_arg:$(this).val()}, function (data) {
                if (data == 1){
                    $("html").data("ws_completed", $("html").data("ws_completed")+1);
                    if ($("html").data("ws_completed") == $("html").data("ws_col")){
                        $("html").data("check", true);
                        check_products();
                    }
                }
            });
        });
    }


    function check_products() {
        if (!$("html").data("check")){

        }else{
            $.get(location.href, {getAllResult: true}, function (data) {
                $(".js_asearch_result").html(data);
            });
        }
    }


});