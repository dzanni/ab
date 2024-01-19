jQuery(document).ready(function () {
    $( ".sort_files" ).sortable({
        stop: function( event, ui ) {
            var pos = {};
            $(this).find(".sort_file_item").each(function(i) {
                pos[i] = {id:$(this).data("id"), pos:i};
            });
            console.log("todo");
           // $.post(location.href, {pos:pos, chgSertificatePosition : true});
        }
    });

    $(document).on("click", ".js_quest_add", function () {
       var obj = $(this);
       if (obj.data("id")){
           return;
       }
       obj.data("id","proceed");
       $.post("/quests/", {create_new_free_ans:true, quest:$(this).data("quest")},function (data) {
           if (data){
               obj.data("id",data);
               obj.find(".upload .js_ans_id").val(data);
               obj.find(".upload").removeClass("hidden");
               obj.find(".upl_main_obj").attr("id","file_"+data);
               obj.find("label").attr("for","file_"+data);
           }
       });
    });

    $(document).on("change", ".js_otvet_txt", function () {
        $.post("/quests/", {save_ans:true, id:$(this).closest(".js_quest_add").data("id"), val: $(this).val()},function (data) {
            if (data){
            }
        });
    });
    $(document).on("click", ".js_public_answer", function () {
        var obj = $(this).closest(".js_quest_add");
        obj.hide();
        $.post("/quests/", {public_answer:true, id:obj.data("id"), quest:obj.data("quest"), parent:obj.data("parent")},function (data) {
            if (data){
                obj.closest(".js_quest_item").find(".js_answers").html(data).show();
            }
        });
    });
    $(document).on("click", ".js_remove_answer", function () {
        var obj = $(this).closest(".quest__answer");
        obj.hide();
        $.post("/quests/", {remove_answer:true, id:$(this).data("id")},function (data) {
        });
    });


    $(document).on("click", ".js_answers_pagination a", function () {
        if ($(this).hasClass("active")){
            return false;
        }
        var obj = $(this).closest(".js_answers");
        $.post("/quests/", {get_answers:true, id:obj.data("id"), page:$(this).data("page"), colonpage:obj.data("col_answers")},function (data) {
            obj.html(data);
        });
    });

    $(document).on("click", ".js_open_inner_answer_form", function () {
        var prev = $(this).closest(".quest__item-footer");
        prev.next(".answer_inner").find(".js_quest_add").first().toggleClass('hidden');

        //$(".answer_inner .js_quest_add").toggleClass('hidden');
    });

    $(document).on("click", ".js_open_inner_answer_form_1", function () {
        var prev = $(this).closest(".quest__item-inner.quest__answer");
        prev.next(".js_quest_add").toggleClass('hidden');
    });


    $(document).on("mouseenter", ".js_tooltip", function () {
        var data_parent = $(this).data('parent');
        var super_parent = $(this).closest(".js_answer_anchor");

        if ($(".quest__item-inner.quest__answer[data-id="+data_parent+"]").length){
            //alert ("ok-"+data_parent);
            var insert = $(".quest__item-inner.quest__answer[data-id="+data_parent+"]").find(".quest__item-q-f.second_level").html();
        }else{
            var insert = super_parent.find(".js_tooltip_anchor").html();
        }

        var parent = $(this).closest(".quest__item-header");
        parent.find(".tooltip_answer").removeClass("hidden");
        parent.find(".tooltip_answer").html('<div class="quest__item-q-f">'+insert+'</div>');
    });
    $(document).on("mouseleave", ".js_tooltip", function () {
        var parent = $(this).closest(".quest__item-header");
        parent.find(".tooltip_answer").addClass("hidden");
    });


    $(document).on("click", ".js_edit_answer", function () {
       // $(".js_edit_answer_anchor").toggleClass("hidden");
        var parent = $(this).closest(".quest__item-info");
        parent.find(".js_edit_answer_anchor").toggleClass("hidden");
    });

});