$(document).ready(function () {

    chgFaviconInit();

    $(document).on("click", ".js_send_form", function (e) {
        var self = $(this);
        var form = self.closest('.form_block');
        var title = form.find('.form_title').html().trim();
        var pr = false;
        var query = self.data('query') ? self.data('query') : 0; // Передается только из лендинга для страниц фирм
       // var email = self.data('email') ? self.data('email') : 0; // Передается только из лендинга для страниц фирм

        if (form.find('.agree').is(':checked') === false) {
            form.find(".result_not").css('display', 'block');
            form.find('.result_not').html('Нужно согласиe на обработку данных');
            return false;
        }

        form.find('.data-provider.not-empty').each(function () {
            if ($(this).val() == '') {
                pr = true;
                $(this).css("border", "1px solid red");
            }
        });

        if (!pr) {
            var tmp = {};
            var index = 0;
            form.find(".data-provider").each(function (i) {
                tmp['sendData[' + i + '][title]'] = $(this).data("title");
                tmp['sendData[' + i + '][value]'] = $(this).val();
                index++;
            });
            tmp['sendData[' + index + '][title]'] = "URL";
            //tmp['sendData[' + index + '][value]'] = url;
            tmp['sendData[' + index + '][value]'] = location.href;

            index++;
            tmp['sendData[' + index + '][title]'] = "Форма";
            tmp['sendData[' + index + '][value]'] = title;

            tmp['query'] = query;
            //tmp['email'] = email;

            var recaptсha = $(this).data("recaptcha");

            grecaptcha.ready(function () {
                e.preventDefault();
                grecaptcha.execute(`${recaptсha}`, {action: 'submit'}).then(function (token) {

                    tmp['g-recaptcha-response'] = token;
                    form.find(".js_token_captcha").val(token);
                    $.post("/ajax/messager.php", tmp, function (data) {
                        data = JSON.parse(data);

                        form.find('.result').css('text-align', 'center');
                        form.find('.result').css('font-size', '2rem');
                        form.find('.result').css('line-height', 'initial');
                        if (data === 0) {
                            form.find(".result").html('Код капчи не прошёл проверку на сервере');
                        } else {
                            form.find('.result').html('Сообщение отправлено');
                        }
                    });
                    show_err = false;
                });

            });

        } else {
            form.find(".result_not").css('display', 'block');
            form.find(".result_not").html("Заполните необходимые поля");
        }
    });

    // Быстрая отправка обратной формы зарегистированным юзером
    $('.js_send_form_quick').click(function() {
        var title = $(this).data('title');
        $(this).closest(".js_form_quick_anchor").html('Сообщение отправлено');
        $.post("/ajax/messager.php", {query: location.search, title:title, currentUser: true}, function () {
        });
    });

    $('.js_chg_city').click(function () {
        var city = $(this).data('city');
        $(".header__city-current .js_city_anchor").html(city);
    });

    $('.js_chg_header_and_footer').click(function () {
        var choice = $(this).data('choice');
        var type = $(this).data('type');
        if (type == 'HEADER') {
            $('.js_chg_header_and_footer[data-type="HEADER"]').html('Выбрать');
            $('.js_chg_header_and_footer[data-type="HEADER"]').removeClass('choosen');
            $(this).html('ВЫБРАН');
            $(this).addClass('choosen');
        }
        if (type == 'FOOTER') {
            $('.js_chg_header_and_footer[data-type="FOOTER"]').html('Выбрать');
            $('.js_chg_header_and_footer[data-type="FOOTER"]').removeClass('choosen');
            $(this).html('ВЫБРАН');
            $(this).addClass('choosen');
        }

        $.post("/ajax/ajax.php", {choice: choice, type: type, chgHeaderFooter: true}, function (data) {

        });
    });

    if (location.search == '?chg_header_footer') {
        $(".techno_button_on").html("Завершить редактирование");
        $(".techno_button_on").attr("href", "/account/");
    }

    /* Эти две функции больше не нужны:

        $('.js_edit_header_and_footer').click(function () {
           $(".techno").removeClass('hidden');
            $("header").removeClass('hidden');
            $("footer").removeClass('hidden');
            $(".techno_button_on").addClass('hidden');
            $(".techno_button_off").removeClass('hidden');
       });
       */
    /*
        $('.js_end_edit_header_and_footer').click(function () {

         var header_anchor = $(document).find('.choosen[data-type="HEADER"]');
            var header_id = 'ver_0' + header_anchor.attr("data-choice");
            var footer_anchor = $(document).find('.choosen[data-type="FOOTER"]');
            var footer_id = 'ver_0' + footer_anchor.attr("data-choice");

            $(".techno").addClass('hidden');
            $('header').not(`[class=${header_id}]`).addClass('hidden');
            $('footer').not(`[class=${footer_id}]`).addClass('hidden');
            $(".techno_button_on").removeClass('hidden');
            $(".techno_button_off").addClass('hidden');

        });*/

    $(document).on('change', '.js_select_car', function () {
        $(".js_select_model").next(".select2").remove();
        $(".js_select_year").next(".select2").remove();
        $(".js_select_modification").next(".select2").remove();
        $('.js_select_model').remove();
        $('.js_select_year').remove();
        $('.js_select_modification').remove();
        $('.js_scroll_result').addClass("hidden");
        $.get("/modules/Vivod-spiska-tovarov/ajax.php", {getModels: true, car: $(this).val()}, function (data) {
            $(".js_select_by_car_anchor").append(data);
            if ($('.filter__select').length) {
                $('.filter__select').select2({
                    placeholder: "Выберите раздел",
                    maximumSelectionLength: 2,
                    language: "ru"
                });
            }
        });
    });

    $(document).on('change', '.js_select_model', function () {
        $(".js_select_year").next(".select2").remove();
        $(".js_select_modification").next(".select2").remove();
        $('.js_select_year').remove();
        $('.js_select_modification').remove();
        $('.js_scroll_result').addClass("hidden");
        $.get("/modules/Vivod-spiska-tovarov/ajax.php", {getYear: true, model: $(this).val()}, function (data) {
            $(".js_select_by_car_anchor").append(data);
            if ($('.filter__select').length) {
                $('.filter__select').select2({
                    placeholder: "Выберите раздел",
                    maximumSelectionLength: 2,
                    language: "ru"
                });
            }
        });
    });

    $(document).on('change', '.js_select_year', function () {
        var form = $(this).closest("form");
        var model = form.find(".js_select_model").val();
        $(".js_select_modification").next(".select2").remove();
        $('.js_select_modification').remove();
        $('.js_scroll_result').addClass("hidden");
        $.get("/modules/Vivod-spiska-tovarov/ajax.php", {
            getModification: true,
            model: model,
            year: $(this).val()
        }, function (data) {
            $(".js_select_by_car_anchor").append(data);
            if ($('.filter__select').length) {
                $('.filter__select').select2({
                    placeholder: "Выберите раздел",
                    maximumSelectionLength: 2,
                    language: "ru"
                });
            }
        });
    });

    $(document).on('change', '.js_select_modification', function () {
        var form = $(this).closest("form");
        var car = form.find(".js_select_car").val();
        var model = form.find(".js_select_model").val();
        var year = form.find(".js_select_year").val();
        var type = form.data(type);
        $('.js_scroll_result').removeClass("hidden");
        $.get("/modules/Vivod-spiska-tovarov/ajax.php", {
            getVariants: true,
            car: car,
            model: model,
            year: year,
            modification: $(this).val(),
            result_output: type
        }, function (data) {
            $(".shina_disk_search_result").html(data);
        });
    });

    //Scroll
    $(document).on('click', '.js_scroll_result', function () {
        $(window).scrollTop($(".js_scroll_result_anchor").offset().top);
    });

    $(document).ready(function () {
        if ($('.js_first_form_on').hasClass("active")) {
            $('.js_second_search_form').hide();
        } else {
            $('.js_first_search_form').hide();
        }
    });

    $(document).on('click', '.js_first_form_on', function () {
        $(this).addClass("active");
        $(".js_second_form_on").removeClass("active");
        //$(".js_first_search_form").removeClass("hidden");
        //$(".js_second_search_form").addClass("hidden");
        $(".js_first_search_form").show();
        $(".js_second_search_form").hide();
    });

    $(document).on('click', '.js_second_form_on', function () {
        $(this).addClass("active");
        $(".js_first_form_on").removeClass("active");
        //$(".js_first_search_form").addClass("hidden");
        //$(".js_second_search_form").removeClass("hidden");
        $(".js_first_search_form").hide();
        $(".js_second_search_form").show();
    });

    $(document).on('click', '.js_filter_clear', function () {
        location.search = "";
    });

    $('.open__popup-table').click(function (e) {
        e.preventDefault();
        //$('div.overlay').fadeIn();
        $($(this).attr('href')).fadeIn();
        $.post("/modules/Vivod-spiska-tovarov/ajax.php", {
            showAlsoVariants: true,
            id: $(this).data("id")
        }, function (data) {
            $("#popup__table .popup__table_body").html(data);

        });
    });


    $(document).on("click", ".js_render_work_button", function () {
        var parent = $(this).closest(".render_work_parent");

        parent.find(".render_work_button").toggleClass("hidden");
        parent.find(".render_work").toggleClass("hidden");
        parent.find(".alert").html("");
    });

    $(document).on("click", ".js_create_new_firm", function () {
        var parent = $(this).closest(".render_work");
        var title = parent.find('input[name="new_firm"]').val().trim();
        var flag = parent.find('input[name="i_work_here"]').is(":checked") ? 1 : 0;
        if (title == "") {
            $(".alert").html("Вы не ввели название");
        } else {
            $.post("/modules/Firms/ajax.php", {flag: flag, title: title, createNewFirm: true}, function (data) {
                if (data) {
                    location.href = "/account/brands/?lk_brands_edit_profile=" + data;
                } else {
                    $(".alert").html("Что-то пошло не так");
                }
            });
        }
    });

    /* $(document).on("change", ".js_add_user_to_firm", function () {
        var user = $(this).data("user");
        var firm = $(this).data("firm");
        var label = $(this).closest("label");
        if (!$(this).is(":checked")){
            if (!confirm ("Удалить? Для обратного включения понадобится новый запрос")){
                this.checked = true;
                return;
            }
        }

        var msg = $(this).is(":checked") ? "- запрос отправлен" : "- пользователь исключен";

        label.find(".render_checkbox_alert").html(msg);
        $.post("/modules/Users/ajax.php", {user: user, firm: firm, addUserToFirm: true}, function () {

        });
     });*/

    $(document).on("click", ".js_add_all_users_to_firm", function () {
        var parent = $(this).closest(".render_work");
        parent.find('input[name="is_my_worker"]').each(function () {

            var user = $(this).data("user");
            var firm = $(this).data("firm");
            var label = $(this).closest("label");
            var flag = $(this).is(":checked") ? "add" : "del";

            /*if (!$(this).is(":checked")) {
                if (!confirm("Удалить? Для обратного включения понадобится новый запрос")) {
                    this.checked = true;
                    return;
                }
            }
            var msg = $(this).is(":checked") ? "- запрос отправлен" : "- пользователь исключен";
            label.find(".render_checkbox_alert").html(msg);*/
            $.post("/modules/Users/ajax.php", {
                user: user,
                firm: firm,
                flag: flag,
                addUserToFirm: true
            }, function (data) {
                label.find(".render_checkbox_alert").html(data);
            });

        });
    });

    $(document).on("click", ".js_add_all_clients_to_firm", function () {
        var parent = $(this).closest(".render_work");
        parent.find('input[name="is_my_client"]').each(function () {

            var client = $(this).data("client");
            var firm = $(this).data("firm");
            var label = $(this).closest("label");
            var flag = $(this).is(":checked") ? "add" : "del";
            $.post("/modules/Firms/ajax.php", {
                client: client,
                firm: firm,
                flag: flag,
                addClientToFirm: true
            }, function (data) {
                label.find(".render_checkbox_alert").html(data);
            });

        });
    });

    $(document).on("click", ".js_change_rating", function () {
        console.log($(this));
        var parent = $(this).closest(".render_work");
        var firm = parent.data("firm");
        //parent.find(":checked").each(function () {
            var rating = $(this).val();
            var client = $(this).closest(".rating-area").data("client");
            $.post("/modules/Firms/ajax.php", {
                client: client,
                firm: firm,
                rating: rating,
                changeRating: true
            }, function (data) {
                //$(".firm_rating").html(data);
                $(".comp__item-rating").html(data);

            });

        //});
    });

    $(document).on("click", ".js_change_remark", function () {
        var parent = $(this).closest(".render_work");
        var firm = parent.data("firm");
        parent.find(".remark").each(function () {
            var text = $(this).val().trim();
            if (text != ""){
                var client = $(this).closest(".remark-area").data("client");
                $.post("/modules/Firms/ajax.php", {
                    client: client,
                    firm: firm,
                    text: text,
                    page: 1,
                    changeRemark: true
                }, function (data) {
                    $(".js_remark_anchor").html(data);
                    parent.find('.alert').html("<br>Отзыв размещен");

                });
            }
        });
    });

    $(document).on("keyup", ".form__reviews .remark", function () {
        $(this).closest(".form__reviews").find(".alert").html("");
    });

    $(document).on("click", ".js_change_answer", function () {
        var parent = $(this).closest(".js_change_answer_anchor");
        var id = $(this).data("id");
        var answer = parent.find(".remark_answer").val().trim();
        if (answer !=""){
            $.post("/modules/Firms/ajax.php", {
                id: id,
                answer: answer,
                changeAnswer: true
            }, function () {
            });
        }
    });

    $(document).on("click", ".js_delete_answer", function () {
        var parent = $(this).closest(".js_change_answer_anchor");
        var id = $(this).data("id");
        $.post("/modules/Firms/ajax.php", {
            id: id,
            deleteAnswer: true
        }, function () {
            parent.html("ОТВЕТ УДАЛЕН");
            //parent.find(".remark_answer").html("");
            //parent.find(".firm_card_item_date").hide();

        });
    });

    $(document).on("click", '.js_tag_title_toggle', function () {
        $(this).toggleClass("on");
        var parent = $(this).closest(".js_chg_element");
        parent.find(".tag_title_anchor").toggleClass("on");
    });

    $(document).on("keyup", '.js_fast_filter_mark', function () {
        var obj = $(this);
        var root_obj = obj.closest(".filter_js_anchor");
        if (obj.val() == "") {
            //root_obj.find(".filter_content").show();
            root_obj.find(".filter-form__label-title").each(function () {
                $(this).closest("label, .label").show();
            });
        } else {
            var query = obj.val().toUpperCase();
            root_obj.find(".filter-form__label-title").each(function () {
                if ($(this).html().toUpperCase().search(query) != -1) {
                    $(this).closest("label, .label").show();
                } else {
                    $(this).closest("label, .label").hide();
                }
            });
        }
    });


    $(document).on("click", '.js_add_tag_render', function () {
        var id = $(this).data("id");
        var title = $(this).find("span").html();
        if (!$(this).hasClass("checked")) {
            $(this).addClass("checked");
            var obj = $(this).closest(".js_chg_element").find(".tag_cloud").first();
            obj.append("<div class='tag_cloud_item checked'>" + title + " <span class='js_delete_tag_render cross_small' data-id=" + id + "></span>");

            /* $.post("/modules/Firms/ajax.php", {id: id, addTagRender: true}, function () {

             });*/
        }
    });

    $(document).on("click", '.js_delete_tag_render', function () {
        var id = $(this).data("id");
        var obj = $(this).closest(".tag_cloud").next().find(".tag_cloud_item[data-id=" + id + "]");
        obj.removeClass("checked");
        $(this).closest(".tag_cloud_item").remove();

        /* $.post("/modules/Firms/ajax.php", {id: id, deleteTagRender: true}, function () {

         });*/
    });

    $(document).on("click", '.js_render_firm_filter', function () {
        var parent = $(this).closest(".lk_tag_box");
        var items = [];

        parent.find(".js_delete_tag_render").each(function () {
            var id = $(this).data("id");
            items.push(id);
        });
        var url = '';
        parent.find(".js_send_form").each(function () {
            if ($(this).val()){
                url+="&"+$(this).attr("name")+"="+$(this).val();
            }
        });
        if ($('.js_txt_search').val()){
            url+="&q="+$('.js_txt_search').val();
        }
        // alert (items);
        location.search = "tag=" + items + url;
    });

    $(".js_txt_search").keyup(function(event) {
        if (event.keyCode === 13) {
            $(".js_start_search").click();
        }
    });

    $(document).on("click", '.js_start_search', function () {
        $(".js_render_firm_filter").click();
    });
    $(document).on("change", '.js_sort_change', function () {
        location.href = $(this).val();
    });


   // js_txt_search js_start_search


    $(document).on("click", '.js_change_remark_page', function () {
        var page = $(this).data("page");
        var firm = $(this).closest(".catalog__pagination").data("firm");
        $.post("/modules/Firms/ajax.php", {
            page: page,
            firm: firm,
            changeRemarkPage: true
        }, function (data) {
            $(".js_remark_anchor").html(data);
        });
    });

    $(document).on("click", '.js_change_answer_page', function () {
        var page = $(this).data("page");
        var quest = $(this).closest(".catalog__pagination").data("quest");
        $.post("/modules/Quests/ajax.php", {
            page: page,
            quest: quest,
            changeAnswerPage: true
        }, function (data) {
            $(".js_answer_anchor").html(data);
        });
    });

    $(document).on("click", ".js_create_new_quest", function () {
        var is_news = $(this).data("news");

        $.post("/modules/Quests/ajax.php", {is_news: is_news, createNewQuest: true}, function (data) {
            if (data) {
                location.href = "/account/quests/?lk_quest_edit_profile=" + data;
            } else {
                $(".alert").html("Что-то пошло не так");
            }
        });
    });

    $(document).on("click", ".js_like_counter", function () {
        var obj_id = $(this).data("id");
        var obj = $(this).data("obj");
        var parent = $(this);
        $(this).toggleClass("checked");
        $.post("/modules/Lichniy-kabinet/ajax.php", {obj: obj, obj_id: obj_id, likeRemark: true}, function (data) {
            if (data) {
                parent.find(".js_like_counter_anchor").html(data);
            }
        });
    });

    $(document).on("click", ".js_answer_create", function () {
        var parent = $(this).closest(".render_work_parent");
        var answer = parent.data("answer");
        var quest = parent.data("quest");
        if (!answer) {
            $.post("/modules/Quests/ajax.php", {createNewAnswer: true, quest: quest}, function (data) {
                parent.attr("data-answer", data);
                $("input[name='answer']").val(data);
            });
        }
    });

    $(document).on("click", ".js_answer_submit", function () {
        var parent = $(this).closest(".render_work_parent");
        var quest = parent.data("quest");
        var title = parent.find(".answer").val().trim();

        if (!title && !parent.find(".files_block a").length){
            $(".alert").html("Пустой ответ");
        }else{
            $.post("/modules/Quests/ajax.php", {changeAnswer: true, quest: quest, title:title}, function (data) {
                $(".alert").html("Выполнено");
                if (data){
                    $(".js_answer_anchor").html(data);
                }
            });
        }
    });

    $(document).on("click", ".js_answer_delete", function () {
        var parent = $(this).closest(".render_work_parent");
        var quest = parent.data("quest");

        $.post("/modules/Quests/ajax.php", {
            deleteAnswer: true,
            quest: quest
        }, function (data) {
            $(".alert").html("Выполнено");
            parent.find(".answer").val("");
            if (data) {
                $(".js_answer_anchor").html(data);
            }
        });

    });

    $(document).on("mouseenter", ".js_tooltip", function () {
        var parent = $(this).closest(".tooltip_parent");
        parent.next(".tooltip_text").removeClass("hidden");
    });
    $(document).on("mouseleave", ".js_tooltip", function () {
        var parent = $(this).closest(".tooltip_parent");
        parent.next(".tooltip_text").addClass("hidden");
    });

   $(document).on("change", ".js_firm_title_select", function () {
       var id = $(this).val();
       var parent = $(this).closest(".render_work");
        if (id == -1){
            parent.find(".rating-area, .remark-area").removeClass("hidden");
        }else{
            parent.find(".rating-area[data-client="+id+"], .remark-area[data-client="+id+"]").removeClass("hidden");
            parent.find(".rating-area[data-client!="+id+"], .remark-area[data-client!="+id+"]").addClass("hidden");
        }
    });

    $(document).on("click", ".js_change_remark_bottom", function () {
        var parent = $(this).closest(".js_change_remark_anchor");
        var text = parent.find(".remark_bottom").val().trim();
        if (text != ""){
            var remark_id = $(this).data("id");
            $.post("/modules/Firms/ajax.php", {
                remark_id: remark_id,
                text: text,
                changeRemarkBottom: true
            }, function () {

            });
        }
    });

    $(document).on("click", ".js_delete_remark_bottom", function () {
        var parent = $(this).closest(".comp__reviews-item");
        var remark_id = $(this).data("id");
        $.post("/modules/Firms/ajax.php", {
            remark_id: remark_id,
            deleteRemarkBottom: true
        }, function () {
            parent.html("");
        });
    });

    $(document).on("click", ".js_change_quest_answer", function () {
        var parent = $(this).closest(".user_card_item");
        var answer_id = $(this).data("id");
        var text = parent.find(".quest_answer").val().trim();
        if (text != "") {
            $.post("/modules/Quests/ajax.php", {
                answer_id: answer_id,
                text: text,
                changeQuestAnswer: true
            }, function () {
            });
        }
    });

    $(document).on("click", ".js_delete_quest_answer", function () {
        var parent = $(this).closest(".user_card_item");
        var answer_id = $(this).data("id");
        $.post("/modules/Quests/ajax.php", {
            answer_id: answer_id,
            deleteQuestAnswer: true
        }, function () {
            $(`.render_work_parent[data-answer=${answer_id}]`).find(".sort_files").html("");
            parent.html("ОТВЕТ УДАЛЕН");
        });
    });

    $(document).on("click", ".js_delete_answer_files", function () {
        var id = $(this).data("id");
        var filename = $(this).data("filename");
       // var quest_id = $(this).closest(".render_work_parent").data("quest");

        $(this).prev("a").remove();
        $(this).remove();

        $.post(location.href, {
            id: id,
            filename:filename,
            //quest_id: quest_id,
            deleteAnswerFile: true
        }, function () {

        });
    });

    $(document).on("click", ".js_remove_msg", function () {
        var parent = $(this).closest(".msg");
        var msg = parent.data('id');
        $.post("/modules/Lichniy-kabinet/ajax.php", {
            msg: msg,
            deleteMsgByUser: true
        }, function (data) {
            if (data){
                parent.remove();
            }
        });
    });

    $(document).on("click", ".js_open_test_alert", function () {
        $(".js_test_alert_anchor").toggleClass('hidden');
    });

    $(document).on("click", ".js_open_share_alert", function () {
        $(".js_share_alert_anchor").toggleClass('hidden');
    });

    $(document).on("click", ".js_share", function () {
        $("#share").toggleClass('open');
        $('.overlay').toggleClass('open');
    });

    $(document).on("click", ".js_reviews", function () {
        $("#reviews").toggleClass('open');
        $('.overlay').toggleClass('open');
    });

});

function chgFaviconInit(){

    if (!$(".js_msg_inner_start").length){

        $.post("/modules/Lichniy-kabinet/ajax.php", {chgFavicon: true}, function (data) {
            data = data || 0;
            if (data !=0){
                set_favicon(data);
                $(".js_msg_new").html("<span>"+data+"</span>");
            }else{
                $('link[rel="shortcut icon"]').remove();
                $('head').append('<link id="favicon" rel="shortcut icon" href="/favicon.ico" type="image/x-icon">');
                $(".js_msg_new").html("");
            }
        });
    }
    setTimeout(chgFaviconInit, 5000);
}

// function newUpdate() {
//     update = setInterval(changeFavicon, 3000);
//     setTimeout(function() {
//         clearInterval( update );
//     }, 3100);
// }



// Заменили на chgFaviconInit()
function chgFavicon() {
    // var last_icons = [];
    // $('link[rel="shortcut icon"]').each(function () {
    //     last_icons.push(this.outerHTML);
    // });

    var num = $('.js_msg_new').find('span').html();
    num = num || 0;
    if (parseInt(num) > 0) {
        set_favicon(num);
    } else {
        // Удаление новой иконки
        $('link[rel="shortcut icon"]').remove();

        // Возвращение исходных
        // last_icons.forEach(function (element) {
        //     $('head').append(element);
        // });
        $('head').append('<link id="favicon" rel="shortcut icon" href="/favicon.ico" type="image/x-icon">');

    }
    setTimeout(chgFavicon, 5000);
}

function set_favicon(num){
    var canvas = document.createElement('canvas');
    canvas.height = 16;
    canvas.width = 16;
    var ctx = canvas.getContext('2d');

    // Вывод картинки
    var img = new Image();
    img.src = '/favicon.ico';

    // Ждем пока загрузится изображение и продолжаем
    img.addEventListener('load', function(){
        ctx.drawImage(img, 0, 0);

        // Рисуем круг
        ctx.beginPath();
        ctx.fillStyle = "#FF0000";
        ctx.arc(11, 5, 5, 0, 2 * Math.PI, true);
        ctx.fill();

        // Выводим текст
        ctx.font = '9px bold Tahoma';
        ctx.fillStyle = '#fff';
        ctx.fillText(num, 9, 8);

        // Удаление старых элементов link
        $('link[rel="shortcut icon"]').remove();

        // Вставка новой иконки
        var n = document.createElement('link');
        n.setAttribute('rel', 'icon');
        n.setAttribute('href', canvas.toDataURL());
        document.querySelector('head').appendChild(n);
    }, false);
}