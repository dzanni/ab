jQuery(document).ready(function(){
    if ($(".LB_edit").data("edit")){
        LB_add_btn_rullers();
    }

    function LB_getFormValues(obj){
        var res = {};
        obj.find(".LB_send_element").each(function(){
            res[$(this).data("field")] = $(this).val();
        });

        console.log(res);
        return res;
    }

    function LB_add_btn_rullers(){
        $(".cs_block_element").each(function(){
            if ($(this).find(".LB_edit_icon").length == 0){
                $(this).append($(".LB_edit_DEFAULT_ELEMENT").html()).find(".LB_edit_icon").data("id",$(this).data("id"));
            }
        });
    }

    /*copy-paste*/
    $(document).on("click",".LB_edit__copy",function(e){
        $.post("/modules/LB_edit_on_page/ajax/LB_ajax.php",{copy_to_clip:$(this).data('id')}, function(data){
            $(".LB_edit__copy_modal .LB_modal_block_form").html(data);
            $(".LB_edit__copy_modal").arcticmodal({
                afterClose: function (data, el) {
                    $('body').css('overflow', 'auto');
                },
            });
        });
    });
    /*copy-paste*/

    /*edit*/

    function reload_element(id){
        $('.LB_edit__edit_modal').arcticmodal('close');
        $.post("/modules/LB_edit_on_page/ajax/LB_ajax.php",{get_element:id}, function(data){
            $(".cs_block_element[data-id="+id+"]").html(data);
            LB_add_btn_rullers();
        });
    }
    $(document).on("click",".LB_edit__edit",function(e){
        e.preventDefault();
        var id = $(this).data("id");
        $.post("/modules/LB_edit_on_page/ajax/LB_ajax.php",{edit_element:true,id:id,category:$(".LB_edit").data("category")}, function(data){
            $(".LB_edit__edit_modal .LB_modal_block_form").html(data);
            $(".LB_edit__edit_modal").width($(document).width()-200).arcticmodal({
                afterClose: function (data, el) {
                    $('body').css('overflow', 'auto');
                    reload_element(id);
                },
            });
        });
        return false;
    });

    /*end edit*/

    /*up-down*/
    function LB_save_positions(){
        var res = {};
        $(".cs_block_element").each(function(i){
            res[i] = $(this).data("id");
        });
        $.post("/modules/LB_edit_on_page/ajax/LB_ajax.php",{chg_pos:true, el:res}, function(data){});
    }

    $(document).on("click",".LB_edit__up",function(){
        var parent_element = $(this).closest('.cs_block_element');
        parent_element.insertBefore(parent_element.prev());
        LB_save_positions();
        return false
    });
    $(document).on("click",".LB_edit__down",function(){
        var parent_element = $(this).closest('.cs_block_element');
        parent_element.insertAfter(parent_element.next());
        LB_save_positions();
        return false
    });
    /*up-down end*/


    /*add*/

    $(document).on("click",".LB_confirm_add_block",function(e){
        var obj = $(this).closest(".LB_form");
        var id = $(".LB_send_element__id").val();
        $.post("/modules/LB_edit_on_page/ajax/LB_ajax.php",LB_getFormValues(obj), function(data){
            if(data != "error"){
                if ($(".LB_send_element[data-field='add_type']").val() == "before"){
                    $(".cs_block_element[data-id="+id+"]").before(data);
                }else{
                    $(".cs_block_element[data-id="+id+"]").after(data);
                }
                LB_add_btn_rullers();
                $('.LB_edit__add_modal').arcticmodal('close');
            }else{
             $(".LB_edit__add_modal .LB_modal_block_form").html("<p>РќРµРёР·РІРµСЃС‚РЅР°СЏ РѕС€РёР±РєР°. РџРѕРїСЂРѕР±СѓР№С‚Рµ РїРѕРІС‚РѕСЂРёС‚СЊ РѕРїРµСЂР°С†РёСЋ</p>");

            }
        });
    });

    $(document).on("click",".LB_edit__add",function(e){
        e.preventDefault();
        var category = $(".LB_edit").data("category");
        var firm = $(".LB_edit").data("firm");
        var firmpage = $(".LB_edit").data("firmpage");

        $.post("/modules/LB_edit_on_page/ajax/LB_ajax.php",{get_add_new_form:true,id:$(this).data("id"),category:category, firm:firm, firmpage:firmpage}, function(data){
            $(".LB_edit__add_modal .LB_modal_block_form").html(data);
            $(".LB_edit__add_modal").arcticmodal({
                afterClose: function (data, el) {
                    $('body').css('overflow', 'auto');
                },
            });
        });
        return false;
    });
    $(document).on("click",".LB_select_add_block_type",function(e){
        if ($(this).hasClass("LB_selected")){
            return false;
        }
        $(".LB_select_add_block_type").removeClass("LB_selected");
        $(this).addClass("LB_selected");
        $(".LB_send_element__LB_type").val($(this).data("id"));
    });


    /*end add*/

    /*remove*/
    $(document).on("click",".LB_edit__del",function(e){
        e.preventDefault();
        $(".LB_edit__del_modal .LB_btn").data('id',$(this).data("id"));
        $('.LB_edit__del_modal').arcticmodal({
            afterClose: function (data, el) {
                $('body').css('overflow', 'auto');
            },
        });
        return false;
    });
    $(document).on("click",".LB_confirm_remove",function(e) {
        var id = $(this).data("id");
        $.post("/modules/LB_edit_on_page/ajax/LB_ajax.php",{remove_element:true,id:id}, function(data){
            $(".cs_block_element[data-id="+id+"]").remove();
        });
        $('.LB_edit__del_modal').arcticmodal('close');
    });
    /*end remove*/
    $(document).on("click", ".cs_block_element", function(){
        $(this).find(".LB_edit_element").toggleClass("cs_block_LB_edit_element");
        $(this).toggleClass("cs_block_element_hover");
    });
});