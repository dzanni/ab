jQuery(document).ready(function () {


    $(document).on("click",".js_lk_search_remark_firm_label",function () {
        if ($(this).hasClass("checked")){
            $(this).removeClass("checked");
        }else{
            $(".js_lk_search_remark_firm_label.checked").removeClass("checked");
            $(this).addClass("checked");
        }
    });
    $(document).on("click",".js_toggle_remarks_btns .account__button",function () {
        $(".js_toggle_remarks_btns .account__button").removeClass("hidden").addClass("active");
        $(this).removeClass("active").addClass("hidden");
        $(".js_toggle_remarks").addClass("hidden");
        $("."+$(this).data("name")).removeClass("hidden");
    });


    $(document).on("click", ".js_company_send_remark", function () {
        var err = '';
        var send = {};
        if ($(".js_toggle_remarks_btns .active").data("name") == "js_company_add"){ // выбор из списка активен
            if ($(".js_lk_search_remark_firm_label.checked").length == 0){
                err += "Вы не выбрали компанию из списка<br>";
            }else{
                send['id'] = $(".js_lk_search_remark_firm_label.checked").data("id");
            }
        }else{ // добавление активно
            if ($('.js_remark_title').val() == ''){
                err += "Заполните наименование компании<br>";
            }else{
                send['title'] = $('.js_remark_title').val();
            }
            if ($('.js_remark_url').val() == ''){
                err += "Заполните адрес сайта компании<br>";
            } else{
                send['url'] = $('.js_remark_url').val();
            }
        }

        if ($(".js_change_rating_lk_firm:checked").length == 0){
            err += "Вы не поставили оценку компании<br>";
        }else{
            send['rating'] = $(".js_change_rating_lk_firm:checked").val();
        }

        if ($(".js_txt_ramark").val() == ''){
            err += "Вы не написали отзыв<br>";
        }else{
            send['txt'] = $(".js_txt_ramark").val();
        }
        if (err){
            $(".js_result").html(err);
        }else{
            //$(this).hide();
            $(".js_result").html('');
            send['mk_new_remark'] = 'mk_new_remark';
            $.post("/account/remark/", send, function (data) {
                $(".js_result").html(data);
            });
        }
    });

    // $(document).on("click",".js_lk_search_remark_tag_label",function () {
    //     $(this).toggleClass("checked");
    // });

    $(document).on("click",".js_open_tag_list", function () {
          $(this).next(".tag_list").toggleClass("hidden");
        });

    $(document).on("change",".js_filter_massmessage", function () {
        var query = $("form.massmessages_add").serialize();

        $.get("/account/massmessages/", query, function (data) {
            $(".js_result_tmp").html(data);
        });
    });
    $(document).on("click",".js_filter_send_msg", function () {
        var query = $("form.massmessages_add").serialize();

        var parent = $(this).closest(".massmessages_send");
            var text = parent.find(".js_txt_mail_anchor").val();
           if (text.trim() != ""){
               $(this).hide();
           }
        $.get("/account/massmessages/", query+"&send_request=true", function (data) {
            $(".js_result_tmp").html(data);
        });
    });

    // $(document).on("click",".js_send_massmessage", function () {
    //     var parent = $(this).closest(".massmessages_send");
    //     var text = parent.find(".js_txt_mail_anchor").val();
    //     if (text.trim() == ""){
    //         parent.find(".js_result").html("Введите текст сообщения");
    //     }else{
    //         $.post("/account/massmessages/", {text:text, sendMassMessage:true}, function (data) {
    //             parent.find(".js_result").html(data);
    //         });
    //     }
    // });







});
