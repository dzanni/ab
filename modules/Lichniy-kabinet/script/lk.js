jQuery(document).ready(function () {

    $(document).on("click", ".js_chg_field", function () {
        if ($(this).data("id")) {
            $("#" + $(this).data("id")).change();
        }
    });
    if ($(".ckeditor_txt").length){
        setEditor($(".ckeditor_txt"));
    }

    function setEditor(obj) {
        obj.ckeditor({
            extraPlugins: 'uploadimage,image2',
            height: 300,
            allowedContent: true,

            // Upload images to a CKFinder connector (note that the response type is set to JSON).
            uploadUrl: '/core/ajax/fileUploaderCKEditor.php?command=QuickUpload&type=Files&responseType=json',

            // Configure your file manager integration. This example uses CKFinder 3 for PHP.
            filebrowserBrowseUrl: "/core/fileManager/fileManager.php?iframe=1&images=true&CKEditor=1",//'/core/ajax/fileUploaderCKEditor.php?filemanager=1',
            filebrowserImageBrowseUrl: '/core/fileManager/fileManager.php?iframe=1&images=true&CKEditor=1',//'/core/ajax/fileUploaderCKEditor.php?filemanager=1&type=Images',
            filebrowserUploadUrl: '/core/ajax/fileUploaderCKEditor.php?command=QuickUpload&type=Files',
            filebrowserImageUploadUrl: '/core/ajax/fileUploaderCKEditor.php?command=QuickUpload&type=Images',

            // The following options are not necessary and are used here for presentation purposes only.
            // They configure the Styles drop-down list and widgets to use classes.

            stylesSet: [
                {name: 'Narrow image', type: 'widget', widget: 'image', attributes: {'class': 'image-narrow'}},
                {name: 'Wide image', type: 'widget', widget: 'image', attributes: {'class': 'image-wide'}}
            ],

            // Load the default contents.css file plus customizations for this sample.
            contentsCss: [CKEDITOR.basePath + 'contents.css', 'https://sdk.ckeditor.com/samples/assets/css/widgetstyles.css'],

            // Configure the Enhanced Image plugin to use classes instead of styles and to disable the
            // resizer (because image size is controlled by widget styles or the image takes maximum
            // 100% of the editor width).
            image2_alignClasses: ['image-align-left', 'image-align-center', 'image-align-right'],
            image2_disableResizer: false
        });

    }

    /*
       if ($(".js_edit_options option").last().hasClass("js_options_anchor")) {

                // $(".js_edit_options").trigger("change");

            var obj_tmp =  $(".js_edit_options option.js_options_anchor");
            var obj = obj_tmp.closest(".js_edit_options");

                obj.addClass("current");
                var tovar_id = obj.data("id");
                var options_id = obj.val();
                $.post("/modules/Vivod-spiska-tovarov/ajax.php", {
                    tovar_id: tovar_id,
                    options_id: options_id,
                    editOptions: true
                }, function (data) {
                    var className = "";
                    var parent_obj = obj.closest('.js_selectors');
                    parent_obj.find('.js_edit_options').each(function () {
                        $(this).addClass(className);
                        if ($(this).hasClass("current")) {
                            className = "remove";
                            $(this).removeClass("current")
                        }
                    });
                    // parent_obj.find(".remove").remove();
                    parent_obj.append(data);
                });
            }
    */


    $(document).on("click", ".js_otkaz .canceled-button", function (e) {
        var obj = $(this).closest(".js_otkaz");
        var checked = obj.find(".order__item-list-canceled-reason-label input:checked");
        if (checked.length == 0 && obj.find(".canceled-message-input").val() == '') {
            showAlert("Укажите причину отказа пожалуйста", "bad");
            return false;
        }
        $.post("/account/orders/", {
            mk_otkaz: true,
            id: $(this).data('id'),
            reason: checked.closest("label").find("span").text(),
            comment: obj.find(".canceled-message-input").val()
        }, function (data) {
            data = $.parseJSON(data);
            showAlert(data.msg, data.class);
        });

    });
    $(document).on("click", ".js_send_register_request", function (e) {
        var obj = $(this);
        var recaptсha = $(this).data("recaptcha");
        var parent = $(this).closest(".js_register_form");
        var result = parent.find(".js_result");
        var show_err = true;

        var msg = '';
        parent.find(".email").each(function () {
            var pattern = /^[\.a-z0-9_-]+@[\.a-z0-9-]+\.[a-z]{2,6}$/i;
            if (!($(this).val().search(pattern) == 0)) {
                msg += "<p>Поле e-mail заполнено некорректно " + $(this).data("title") + "</p>";
            }
        });

        parent.find(".notEmpty").each(function () {
            if ($(this).val() == '' || $(this).val() == 0) {
                msg += "<p>Ошибка: не заполнено обязательное поле " + $(this).data("title") + "</p>";
            }
        });
        if (msg != '') {
            showMsg(result, msg, "bad");
            return;
        }
        result.html("");

        grecaptcha.ready(function () {
            e.preventDefault();
            obj.hide();
            grecaptcha.execute(`${recaptсha}`, {action: 'submit'}).then(function (token) {
                parent.find(".js_token_captcha").val(token);
               $.post("/modules/Lichniy-kabinet/ajax.php", parent.serialize(), function (data) {
                   data = JSON.parse(data);
                   showMsg(result, data.msg, data.err);
              });
                show_err = false;
            });
        });

        if (!show_err) {
            showMsg(result, '* Вы не прошли проверку "Я не робот"', "bad");
        }
    });

    $(document).on("click", ".js_mk_auth_init", function (e) {
        var recaptсha = $(this).data("recaptcha");
        var parent = $(this).closest(".js_auth_form");
        var result = parent.find(".js_result");
        var show_err = true;
        grecaptcha.ready(function () {
            e.preventDefault();
            grecaptcha.execute(`${recaptсha}`, {action: 'submit'}).then(function (token) {
                parent.find(".js_token_captcha").val(token);
                parent.submit();
                show_err = false;
            });
        });
        if (!show_err) {
            showMsg(result, '* Вы не прошли проверку "Я не робот"', "bad");
        }
    });


    $(document).on("click", ".js_mk_forget_pwd", function (e) {
        var recaptсha = $(this).data("recaptcha");
        var parent = $(this).closest(".js_mk_forget_pwd_obj");
        var result = parent.find(".js_result");
        var login = parent.find(".js_login").val();
        var device = $(this).data("device");
        var show_err = true;
       grecaptcha.ready(function () {
            e.preventDefault();
            grecaptcha.execute(`${recaptсha}`, {action: 'submit'}).then(function (token) {
                parent.find(".js_token_captcha").val(token);
                if (login !== '') {
                    $.post("/modules/Lichniy-kabinet/ajax.php", {
                        login: login,
                        device: device,
                        forget_pwd: true,
                        "g-recaptcha-response": token
                    }, function (data) {
                        data = JSON.parse(data);
                        showMsg(result, data.msg, data.err);
                    });
                } else {
                    showMsg(result, "Укажите почту или телефон, на которые у Вас зарегистрирован аккаунт", 1);
                }
                show_err = false;
            });
        });
        if (!show_err) {
            showMsg(result, '* Вы не прошли проверку "Я не робот"', "bad");
        }
    });

    $(document).on("click", ".js_add_new_obj", function () {
        var root = $(this).closest(".js_add_new_element");
        var res = {};
        root.find(".js_add").each(function (i) {
            res[$(this).data("field")] = $(this).val();
            if ($(this).data("notnull") && !$(this).val()){
                if (res['notnull'] === undefined){
                    res['notnull'] = $(this).data("notnull");
                }else{
                    res['notnull'] += "," + $(this).data("notnull");
                }
            }
        });
        $.post(location.href, res, function (data) {
            data = $.parseJSON(data);
            root.find(".result").html(data.msg);
            if (data.id > 0) {
                var res = {"s_id": data.id};
                show_data(1, res);
                root.find('.js_showAll').removeClass("hidden");
            }
        });
    });

    $(document).on("click", ".js_remove_id_add_filer", function () {
        var root = $(this).closest(".js_showAll").addClass("hidden");
        show_data(1, '');
    });

    $(document).on("change", ".js_chg", function () {
        var res = {};
        res["chg_data"] = true;
        res["f_id"] = $(this).data("id");
        res[$(this).data("field")] = $(this).val();
        res['multikey'] = $(this).data('multikey');
        $.post(location.href, res, function (data) {
            data = $.parseJSON(data);
            showAlert(data.msg, data.class);
        });
    });

    $(document).on("click", ".js_set_remove", function () {

        if (confirm("Вы уверены, что хотите удалить элемент?")) {
            var res = {};
            var obj = $(this).closest(".js_chg_row");
            res["delete_data"] = true;
            res["f_id"] = $(this).data("id");
            $.post(location.href, res, function (data) {
                data = $.parseJSON(data);
                showAlert(data.msg, data.class);
                if (data.class = "good") {
                    obj.remove();
                }
            });
        }
    });

    $(document).on("click", ".js_pages_chg", function () {
        show_data($(this).data("page"), '');
    });
    $(document).on("click", ".js_sort_block .sort", function () {
        if ($(this).hasClass("selected")) {
            return false;
        }
        $(".js_sort_block .sort").removeClass("selected");
        $(this).addClass("selected");
        show_data(1, '');
    });
    $(document).on("change", ".js_search", function () {
        show_data(1, '');
    });

    function show_data(page, res) {
        var root = $(".js_search_block");
        if (res == '') {
            var res = {};
            root.find(".js_search").each(function () {
                if ($(this).val() !== '') {
                    res[$(this).data("field")] = $(this).val();
                }
            });
        }
        res['sort'] = $(".js_sort_block .sort.selected").data("field");
        res['page'] = page;
        res['getAjax'] = true;
        $.get(location.href, res, function (data) {
            data = $.parseJSON(data);
            $('.js_inner_result_data').html(data.html);
            if ($('.js_inner_result_data input.tel').length){
                $('.js_inner_result_data input.tel').inputmask("+7 (999) 999-99-99");
            }
            $('.js_pages').html(data.pageHtml);
        });
    }

    $(".sort_img").sortable({
        stop: function (event, ui) {
            var pos = {};
            $(this).find(".sort_img_item").each(function (i) {
                pos[i] = {id: $(this).data("id"), pos: i};
            });
            $.post(location.href, {pos: pos, chgTovarImgPosition: true});
        }
    });

    $(document).on("click", ".js_delete_cv_file", function () {
        $.post(location.href, {js_delete_cv_file: true});
        $(".sort_cv").html('');
    });
    $(document).on("click", ".js_delete_img", function () {
        var filename = $(this).data("filename");
        //alert(filename);
        $(this).parent(".img_block").html('');
        $.post(location.href, {filename: filename, deleteIMG: true});
    });

    $(document).on("click", ".js_delete_files", function () {
        var filename = $(this).data("filename");
        var id = $(this).data("id");
        $(this).closest(".files_block").remove();
        $.post(location.href, {filename:filename, id:id, deleteSertificate: true});
    });

    $(document).on("click", ".js_delete_quest_files", function () {
        var filename = $(this).data("filename");
        var id = $(this).data("id");
        $(this).parent(".files_block").html('');
        $.post(location.href, {filename:filename, id:id, deleteQuestFiles: true});
    });

    $(document).on("click", ".js_delete_docs_file", function () {
        var filename = $(this).data("filename");
        var id = $(this).data("id");
        $(this).closest(".files_block").remove();
        $.post(location.href, {filename:filename, id:id, deleteDocument: true});
    });


    $(document).on("change", ".js_chg_sertificate", function () {
        var id = $(this).data("id");
        var field = $(this).data("field");
        var value = $(this).val();
        $.post(location.href, {id: id, field:field, value: value, chgSertificate: true});
    });

    $(document).on("change", ".js_chg_document", function () {
        var id = $(this).data("id");
        var field = $(this).data("field");
        var value = $(this).val();
        $.post(location.href, {id: id, field:field, value: value, chgDocument: true});
    });


    $(".js_selectors").find(".js_edit_options").each(function () {
        var obj = $(this);
        loadSubSelect(obj, true);
    });

    $(document).on("change", ".js_edit_options", function () {
        var obj = $(this);
        loadSubSelect(obj, false);
    });

    $(document).on("change", ".js_check_options", function () {
        var options_id = $(this).data("options");
        var value = $(this).data("value");
        if ($(this).is(':checked')) {
            var flag = 1;
        }
        else {
            flag = 0;
        }
        $.post(location.href, {value: value, options_id: options_id, flag: flag, chgOptions: true}, function (data) {

        });
    });

    $(document).on("change", ".js_select_options", function () {
        var options_id = $(this).data("options");
        var value = $(this).val();

        $.post(location.href, {value: value, options_id: options_id, selectOptions: true}, function (data) {

        });
    });

    /* Эта логика пока скрыта*/
    $(document).on("click", ".js_save_option_line", function () {
        var tovar_id = $(this).data("id");
        var key = $(this).data("key");
        var options = [];

        var parent = $(this).closest(".js_selectors");
        parent.find(".js_edit_options").each(function () {
            options.push($(this).val());
        });
        //$.post("/modules/Vivod-spiska-tovarov/ajax.php", {tovar_id:tovar_id, options:options, key:key, saveOptions : true}, function () {
        $.post("/modules/Lichniy-kabinet/ajax.php", {
            tovar_id: tovar_id,
            options: options,
            key: key,
            saveOptions: true
        }, function () {
        });
    });



    function loadSubSelect(obj, needRecursion) {
        obj.addClass("current");
        var tovar_id = obj.data("id");
        var options_id = obj.val();
        var recursion = obj.data("recursion");
        //$.post("/modules/Vivod-spiska-tovarov/ajax.php", {tovar_id:tovar_id, options_id:options_id, editOptions : true}, function (data) {
        $.post("/modules/Lichniy-kabinet/ajax.php", {
            tovar_id: tovar_id,
            options_id: options_id,
            editOptions: true
        }, function (data) {
            var className = "";
            var parent_obj = obj.closest('.js_selectors');
            parent_obj.find('.js_edit_options').each(function () {
                $(this).addClass(className);
                if ($(this).hasClass("current")) {
                    className = "remove";
                    $(this).removeClass("current")
                }
            });
            parent_obj.find(".remove").remove();
            parent_obj.append(data);
            // Далее рекурсия, но работает корректно только на три уровня
            var new_parent = obj.closest('.js_selectors');
            new_parent.find('.js_edit_options').each(function () {
                var new_obj = $(this).closest('.js_selectors .recursion').last();

                if ((recursion != true) && (needRecursion == true)) {
                    loadSubSelect(new_obj, true);
                }
            });
        });
    }

    $(document).on("change", ".js_lk_brand_select", function () {
        var tovar_id = $(this).data("id");
        var brand = $(this).val();

        $.post("/modules/Lichniy-kabinet/ajax.php", {
            tovar_id: tovar_id,
            brand: brand,
            lk_brand_select: true
        }, function (data) {
            if (data == 1) {
                location.search = `?brand=${brand}&lk_tovar_edit_profile=${tovar_id}`;
            }
        });
    });

    $(document).on("click", ".js_pwd_chg_open", function () {
        $(this).hide();
        $(".js_pwd_anchor").removeClass("hidden");
    });

    $(document).on("click", ".js_pwd_chg_close", function () {
        $(".js_pwd_anchor").addClass("hidden");
        $(".js_pwd_chg_open").show();
    });

    $(document).on("click", ".js_pwd_chg", function () {

        var parent = $(this).closest(".js_register_form");
        var result = parent.find(".js_result");

        var old_pwd = parent.find('input[name|="old_pwd"]').val();
        var new_pwd1 = parent.find('input[name|="new_pwd1"]').val();
        var new_pwd2 = parent.find('input[name|="new_pwd2"]').val();

        if (old_pwd == '') {
            showMsg(result, 'Не введен старый пароль');
        } else if (new_pwd1 == '') {
            showMsg(result, 'Не введен новый пароль');
        } else if (new_pwd1 != new_pwd2) {
            showMsg(result, 'Ошибка при повторении пароля');
        } else {
            $.post("/modules/Lichniy-kabinet/ajax.php", {
                old_pwd: old_pwd,
                new_pwd: new_pwd1,
                reset_pwd: true
            }, function (data) {
                if (data === 'true') {
                    parent.html('Пароль успешно изменен');
                } else {
                    showMsg(result, 'Старый пароль введен неверно');
                }
            });
        }
    });

    $(document).on("change", ".js_lk_chg", function () {
        var value = $(this).val();
        var field = $(this).data("field");
        $.post("/modules/Lichniy-kabinet/ajax.php", {value: value, field: field, chg_user_field: true}, function () {

        });
    });

    $(document).on("click", ".js_open_order_list", function () {
        var parent = $(this).closest(".order__item");
        if ($(this).hasClass("open")) {
            parent.find(".order__item-list").addClass("hidden");
            /* parent.find(".js_msg_container").addClass("hidden");*/
            $(this).removeClass("open");
            $(this).html("Показать детали");
        } else {
            parent.find(".order__item-list").removeClass("hidden");
            /*  parent.find(".js_msg_container").removeClass("hidden");*/
            $(this).addClass("open");
            $(this).html("Скрыть детали");
        }
    });

    $(document).on("change", ".js_input_option", function () {
        var tovar = $(this).data("id");
        var option = $(this).data("option");
        var text = $(this).val();
        $.post("/modules/Lichniy-kabinet/ajax.php", {
            tovar: tovar,
            option: option,
            text: text,
            input_option: true
        }, function () {
        });
    });

    $(document).on("click", ".js_add_option_open", function () {
        $(this).hide();
    });

    $(document).on("change", ".js_add_option", function () {
        var obj = $(this);
        var option = obj.data("option");
        var output = obj.data("output");
        var title = obj.val();
        var parent = obj.closest(".lk_checkbox_group");

        $.post(location.href, {option: option, title: title, output: output, addOption: true}, function (data) {
            parent.find(".lk_checkbox_anchor").html(data);
            parent.find(".js_add_option_open").show();
        });
    });

   /* $(document).on("keyup", '.js_fast_filter_mark', function () {
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
    });*/

    $(document).on("keyup", '.js_check_user-data.tel', function () {
        if ($.isNumeric($(this).val().substr(17,1)))
        {
            $.post("/modules/Lichniy-kabinet/ajax.php", {checkAuthData: true, tel: $(this).val()}, function (data) {
           if(data){
               $('.js_alert_user-data.tel').html(data);
               $(".js_check_user-data-button").addClass("hidden");
           }else {
               $('.js_alert_user-data.tel').html("");
               $(".js_check_user-data-button").removeClass("hidden");
           }
         });
        }else{
            $(".js_check_user-data-button").addClass("hidden");
            $('.js_alert_user-data.tel').html("Введите полный номер");
        }
    });

    $(document).on("keyup", '.js_check_user-data.login', function () {
        if (validateEmail($(this).val()))
        {
            $.post("/modules/Lichniy-kabinet/ajax.php", {checkAuthDataMail: true, email: $(this).val()}, function (data) {
                if(data){
                    $('.js_alert_user-data.login').html(data);
                    $(".js_check_user-data-button").addClass("hidden");
                }else {
                    $('.js_alert_user-data.login').html("");
                    $(".js_check_user-data-button").removeClass("hidden");
                }
            });
        }else{
            $(".js_check_user-data-button").addClass("hidden");
            $('.js_alert_user-data.login').html("Введите корректный e-mail");
        }
    });


    $(document).on("keyup", '.js_check_new_tel', function () {
        $('.js_result').html("");
        if ($.isNumeric($(this).val().substr(17,1)))
        {
            $.post("/modules/Lichniy-kabinet/ajax.php", {checkNewTel: true, tel: $(this).val()}, function (data) {
                $('.js_check_new_tel_alert').html(data);
            });
        }else{
            $('.js_check_new_tel_alert').html("Введите полный номер");
        }
    });

    // НОВЫЙ ПОЛЬЗОВАТЕЛЬ: ввод кода из SMS/e-mail для верификации телефона/e-mail
    $(document).on("click", ".js_lk_tel_input", function () {
        var tel_code = $(".js_lk_tel_input_anchor").val();
        var id = $(this).data("id");
        var device = $(this).data("device");
        var parent = $(this).closest("p");
            $.post("/modules/Lichniy-kabinet/ajax.php", {telInput: true, id:id, device:device, tel_code: tel_code}, function (data) {
                if(isJSON(data)){
                    data = JSON.parse(data);
                    if (data.status == "1"){
                    location.href = data.url;
                    }
                }else{
                    $(".js_result").html(data);
                }
        });
    });

    $(document).on("click", '.js_mk_set_au', function () {
        var pwd = $(this).closest(".js_form").find(".js_pwd").val();
        $.post("/modules/Lichniy-kabinet/ajax.php", {au:$(this).data("au"), pwd: pwd}, function (data) {
             location.href = data;
        });
    });

    // СТАРЫЙ ПОЛЬЗОВАТЕЛЬ: запрос смены телефона с отправкой SMS
    $(document).on("click", '.js_lk_chg_tel', function () {
        var tel = $(this).data('tel');
        $.post("/modules/Lichniy-kabinet/ajax.php", {changeTel: true, tel: tel}, function (data) {
            $('.js_check_new_tel_alert').html("");
            $('.js_result').html(data);
        });
    });

    // СТАРЫЙ ПОЛЬЗОВАТЕЛЬ: ввод кода из SMS для смены телефона
    $(document).on("click", '.js_verificate_new_tel', function () {
        var tel_code = $(".js_verificate_new_tel_anchor").val();
        var tel = $(this).data('tel');
        $.post("/modules/Lichniy-kabinet/ajax.php", {proveTel: true, tel:tel, tel_code: tel_code}, function (data) {
           $('.js_result').html(data);
        });
    });

    $(document).on("change", ".js_check_tags", function () {
        var tag = $(this).data("tag");
        //var user = $(this).data("id"); // Переделали абстрактно для любого класса LK
        var id = $(this).data("id"); // new
        var subj_type = $(this).data("subj_type"); // new

        var root = $(this).data("root");
        var is_multi = $(this).data("is_multi");
        if ($(this).is(':checked')) {
            var flag = 1;
        }
        else {
            flag = 0;
        }
        var parent = $(this).closest(".lk_tag_box");
        var insert = parent.find(".js_second_level");

        var inner_level = false;
        if ($(this).closest(".js_second_level").length){
            inner_level = true;
        }

        $.post("/modules/Lichniy-kabinet/ajax.php", {/*user: user,*/ id : id, subj_type: subj_type, tag: tag, root: root, is_multi: is_multi, flag: flag, chgTags: true}, function (data) {
            if (!inner_level){
                insert.html(data);
            }

        });
    });

// Работает только для радио - по включенной кнопке добавляет к стране регион
if ($(".js_check_tags_second_level").is(':checked')){
    var obj = $(".js_check_tags_second_level[checked='checked']");
    var tag = obj.data("tag");
    //var user = obj.data("id");
    var id = obj.data("id"); // new
    var subj_type = obj.data("subj_type"); // new
    var is_multi = obj.data("is_multi");

    var parent = obj.closest(".lk_tag_box");
    var insert = parent.find(".js_second_level");

    $.post("/modules/Lichniy-kabinet/ajax.php", {/*user: user,*/id : id, subj_type: subj_type, tag: tag, is_multi: is_multi, addDefaultSecondTags: true}, function (data) {
        insert.html(data);
    });
}

    $(document).on("click", '.js_moderation_user', function () {
    var user = $(this).data("id");
    var parent = $(this).closest(".moderation_block");
        $.post("/modules/Lichniy-kabinet/ajax.php", {user: user, askModeration: true}, function (data) {
            parent.html(data);
        });
    });

    $(document).on("click", '.js_moderation_firm', function () {
        var firm = $(this).data("id");
        var parent = $(this).closest(".moderation_block");
        $.post("/modules/Lichniy-kabinet/ajax.php", {firm: firm, askModerationFirm: true}, function (data) {
            parent.html(data);
        });
    });

    $(document).on("click", '.js_moderation_quest', function () {
        var quest = $(this).data("id");
        var parent = $(this).closest(".moderation_block");
        $.post("/modules/Lichniy-kabinet/ajax.php", {quest: quest, askModerationQuest: true}, function (data) {
            parent.html(data);
        });
    });


   /* $(document).on("click", '.js_tag_title_toggle', function () {
        $(this).toggleClass("on");
        var parent = $(this).closest(".js_chg_element");
        parent.find(".tag_title_anchor").toggleClass("on");
    });*/


    $( ".sort_files" ).sortable({
        stop: function( event, ui ) {
            var pos = {};
            $(this).find(".sort_file_item").each(function(i) {
                pos[i] = {id:$(this).data("id"), pos:i};
            });
            $.post(location.href, {pos:pos, chgSertificatePosition:true, chgDocumentPosition:true});
        }
    });

    $(document).on("click", '.js_delete_tag', function () {
        var id = $(this).data("id");
        var user = $(this).data("user");
        var obj = $(this).closest(".tag_cloud").next().find(".tag_cloud_item[data-id="+id+"]");
        obj.removeClass("checked");
        $(this).closest(".tag_cloud_item").remove();

        $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, user:user, deleteTag: true}, function (data) {
            if(data){
                $(".js_reg_tag_anchor").html(data);
            }
        });
    });

    $(document).on("click", '.js_add_tag', function () {
        var id = $(this).data("id");
        var user = $(this).data("user");
        var title = $(this).find("span").html();
        if (!$(this).hasClass("checked")){
            $(this).addClass("checked");
            var obj = $(this).closest(".js_chg_element").find(".tag_cloud").first();
            obj.append( "<div class='tag_cloud_item checked'>"+title+" <span class='js_delete_tag cross_small' data-id="+id+" data-user="+user+"></span>");

            $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, user:user, addTag: true}, function (data) {
                if(data){
                    $(".js_reg_tag_anchor").html(data);
                }

            });
        }
    });

    $(document).on("click", '.js_delete_tag_firm', function () {
        var id = $(this).data("id");
        var firm = $(this).data("firm");
        var obj = $(this).closest(".tag_cloud").next().find(".tag_cloud_item[data-id="+id+"]");
        obj.removeClass("checked");
        $(this).closest(".tag_cloud_item").remove();

        $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, firm:firm, deleteTagFirm: true}, function (data) {
            if(data){
                $(".js_reg_tag_anchor").html(data);
            }
        });
    });

    $(document).on("click", '.js_add_tag_firm', function () {
        var id = $(this).data("id");
        var firm = $(this).data("firm");
        var title = $(this).find("span").html();
        if (!$(this).hasClass("checked")){
            $(this).addClass("checked");
            var obj = $(this).closest(".js_chg_element").find(".tag_cloud").first();
            obj.append( "<div class='tag_cloud_item checked'>"+title+" <span class='js_delete_tag_firm cross_small' data-id="+id+" data-firm="+firm+"></span>");

            $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, firm:firm, addTagFirm: true}, function (data) {
                if(data){
                    $(".js_reg_tag_anchor").html(data);
                }
            });
        }
    });

    $(document).on("click", '.js_delete_tag_quest', function () {
        var id = $(this).data("id");
        var quest = $(this).data("quest");
        var obj = $(this).closest(".tag_cloud").next().find(".tag_cloud_item[data-id="+id+"]");
        obj.removeClass("checked");
        $(this).closest(".tag_cloud_item").remove();

        $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, quest:quest, deleteTagQuest: true}, function (data) {
            if(data){
                $(".js_reg_tag_anchor").html(data);
            }
        });
    });

    $(document).on("click", '.js_add_tag_quest', function () {
        var id = $(this).data("id");
        var quest = $(this).data("quest");
        var title = $(this).find("span").html();
        if (!$(this).hasClass("checked")){
            $(this).addClass("checked");
            var obj = $(this).closest(".js_chg_element").find(".tag_cloud").first();
            obj.append( "<div class='tag_cloud_item checked'>"+title+" <span class='js_delete_tag_quest cross_small' data-id="+id+" data-quest="+quest+"></span>");

            $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, quest:quest, addTagQuest: true}, function (data) {
                if(data){
                    $(".js_reg_tag_anchor").html(data);
                }
            });
        }
    });



   /* $(document).on("change", '.js_accept_firm', function () {
        var firm = $(this).data("firm");
        var user = $(this).data("user");
        $.post("/modules/Lichniy-kabinet/ajax.php", {firm: firm, user:user, acceptFirm: true}, function () {
        });
    });*/


    $(document).on("click", ".js_accept_all_firm", function () {
        var parent = $(this).closest(".render_work");
        parent.find('input[name="is_my_firm"]').each(function () {

            var user = $(this).data("user");
            var firm = $(this).data("firm");
            var flag = $(this).is(":checked") ? "add" : "del";
            var alert = $(this).closest("label").find(".lk_checkbox_alert");

            $.post("/modules/Lichniy-kabinet/ajax.php", {firm: firm, user:user, flag:flag, acceptFirm: true}, function (data) {
            alert.html(data);
            });
        });

    });

    $(document).on("click", ".js_accept_all_client", function () {
        var parent = $(this).closest(".render_work");
        parent.find('input[name="i_am_client"]').each(function (data) {

            var id = $(this).data("id");
            var flag = $(this).is(":checked") ? "add" : "del";
            var alert = $(this).closest("label").find(".lk_checkbox_alert");

            $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, flag:flag, acceptClientStatus: true}, function (data) {
                alert.html(data);
            });
        });

    });

    $(document).on("click", ".js_activate_quest", function () {
        var id = $(this).data("id");
        var status = $(this).data("status");
        var text_tmp = (status == 0) ? "Активировать" : "Скрыть";
        var text_reset = (status == 1) ? "Активировать" : "Скрыть";

        $(this).html(text_tmp);
            $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, activateQuest: true}, function (data) {
               if (data){
                   $(".js_activate_quest").html(data);
                   $(".alerts_moderation").html("");
               }else{
                   $(".alerts_moderation").html("Вы не ввели вопрос либо ошибка записи в базу");
                   $(".js_activate_quest").html(text_reset);
               }
            });
    });

    $(document).on("change", ".js_add_tlg_quest", function () {
        var status = $(this).val();
        if (status == 1){
            var id = $(this).data("id");
            var title = $(this).data("title");
            $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, title:title, activateQuestAdmin: true});
        }

    });

    $('.open__popup_tag').click(function(e) {
        e.preventDefault();
        $('div.overlay').fadeIn();
        $($(this).attr('href')).fadeIn();

        var parent_tag = $(this).closest('.js_chg_element').find('.tag_title_toggle').html();
        var title = 'Новый тег раздела "'+parent_tag+'"';
        var parent_id = $(this).data("id");

        $('#popup__tag').find('.alert').html("");
        $('#popup__tag').find('input[name="tag"]').val("");
        $('#popup__tag').find('.form_title').html(title);
        $('#popup__tag').find('.form__button').attr("data-id", parent_id);
    });

    $(document).on("click", ".js_tag_from_user", function () {

        var obj = $(this);
        var parent =  obj.closest(".form__content");
        //var parent_id = obj.data("id");
        var parent_id = obj.attr("data-id");

        var title = parent.find('input[name="tag"]').val().trim();

        if (title == ""){
            parent.find(".alert").html("Пустой тег");
        }else {
            parent.find(".alert").html("Запрос принят");
            $.post("/modules/Lichniy-kabinet/ajax.php", {title: title, parent_id: parent_id, newTagFromUser: true}, function () {

            });
        }
    });

    $('.open__popup_param').click(function(e) {
        e.preventDefault();
        $('div.overlay').fadeIn();
        $($(this).attr('href')).fadeIn();

        var parent_tag = $(this).data("param");
        var title = 'Новый вариант параметра "'+parent_tag+'"';
        var parent_id = $(this).data("id");

        $('#popup__param').find('.alert').html("");
        $('#popup__param').find('input[name="tag"]').val("");
        $('#popup__param').find('.form_title').html(title);
        $('#popup__param').find('.form__button').attr("data-id", parent_id);
    });

    $(document).on("change", ".js_choose_reg_type", function () {
        var field = $(this).val();
        var anti_field = (field == "login") ? "tel" : "login";
        var form = $(".js_register_form");
        form.find("p.login, p.tel").toggleClass("hidden");
        form.find("input.login").toggleClass("notEmpty email");
        form.find("input.tel").toggleClass("notEmpty");
        form.find("input."+anti_field).val("");

        // Скрываем кнопку "Зерегистрироваться" и чистим алерты, если есть
        $('.js_alert_user-data.tel').html("");
        $(".js_check_user-data-button").addClass("hidden");
    });

    //Обрабатываем код подтверждения при восстановлении пароля по телефону на autoboss
    $(document).on("click", ".js_enter_pwd_resign_code", function () {
        var id = $(this).data("id");
        var parent = $(this).closest(".js_result");
        var tel_code = parent.find("input[name='tel_code']").val();
        var pwd = parent.find("input[name='pwd']").val();
        if (pwd != '' || tel_code != ''){
            $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, tel_code: tel_code, pwd: pwd, resignPwdByTel: true}, function (data) {
                if(data){
                    parent.html(data);
                }else{
                    parent.find(".alert").html("Код не подтвержден");
                }
            });
        }
        else{
            parent.find(".alert").html("Пустой пароль или код");
        }

    });

    // $(document).on("click", ".js_open_chg_device", function () {
    //     var parent = $(this).closest(".js_chg_device_anchor");
    //     var main_input = parent.closest(".input__item").find("input").first();
    //
    //     var id = $(this).data("id");
    //     var device = main_input.attr("type");
    //     var val = main_input.val();
    //
    //     if (device == "tel" && !$.isNumeric(val.substr(17, 1))) {
    //         parent.find(".alert").html("Введите полный номер телефона");
    //         return;
    //     } else if (device == "email" && !validateEmail(val)) {
    //         parent.find(".alert").html("Неправильный формат e-mail");
    //         return;
    //     }
    //     $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, device: device, val:val, chgCodeGenerate: true}, function (data) {
    //
    //         data = JSON.parse(data);
    //         if (data.status == "0"){
    //             parent.find(".alert").html(data.msg);
    //         }else{
    //             main_input.attr("disabled", "disabled");
    //             parent.find("input").removeClass("hidden");
    //             parent.find("a").removeClass("hidden");
    //             parent.find(".alert").html("");
    //             $(this).remove();
    //         }
    //     });
    // });

    $(document).on("click", ".js_open_chg_device_sbmt", function () {
        $(this).hide();
        //$(this).closest(".input__item").find(".js_open_chg_device").change();
    });

    $(document).on("change", ".js_open_chg_device", function () {
        var main_input = $(this);
        var parent = main_input.closest(".input__item");

        var id = main_input.data("id");
        var device = main_input.attr("type");
        var val = main_input.val();

        parent.find(".alert").html("");

        if (device == "tel" && !$.isNumeric(val.substr(17, 1))) {
            parent.find(".alert").html("Введите полный номер телефона");
            return;
        } else if (device == "email" && !validateEmail(val)) {
            parent.find(".alert").html("Неправильный формат e-mail");
            return;
        }else if (device == "text" && !validateTlg(val)) {
            parent.find(".alert").html("Неправильный формат телеграм");
            return;
        }

        $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, device: device, val:val, chgCodeGenerate: true}, function (data) {

            data = JSON.parse(data);
            if (data.status == "0"){
                parent.find(".alert").html(data.msg);
            }else{
                main_input.attr("disabled", "disabled");
                parent.find(".js_chg_device_anchor .js_open_chg_device_sbmt").addClass("hidden");
                parent.find(".js_chg_device_anchor input").removeClass("hidden");
                parent.find(".js_chg_device_anchor p").removeClass("hidden");
                parent.find(".js_chg_device_anchor a").removeClass("hidden");
                parent.find(".alert").html("");
            }
        });
    });

    $(document).on("click", ".js_chg_tel_lk", function () {
        var parent = $(this).closest(".input__item");
        var tel = parent.find("input[type='tel']").val();
        var tel_code = parent.find("input[type='text']").val();
        var id = $(this).data("id");
        if (tel_code.toString().length == 4 && $.isNumeric(tel_code)) {
            $.post("/modules/Lichniy-kabinet/ajax.php", {tel: tel, tel_code: tel_code, id: id, chgUserTel: true}, function (data) {
                data = JSON.parse(data);
                parent.find(".alert").html(data.msg);
                if (data.status == "1") {
                    parent.find(".js_chg_device_anchor input").addClass("hidden");
                    parent.find(".js_chg_device_anchor a").addClass("hidden");
                    parent.find("input[type='tel']").attr("disabled", false);
                    show_moderate();
                }
                });
        }else{
            parent.find(".alert").html("Введите полный 4-значный код подтверждения");
        }
    });

    function show_moderate(){
        $(".js_moderation_user").removeClass("hidden");
        $(".js_moderate_user_err_msg").hide();
    }

    $(document).on("click", ".js_chg_login_lk", function () {
        $(this).closest(".js_chg_device_anchor").find("p").hide();
        var parent = $(this).closest(".input__item");
        var login = parent.find("input[type='email']").val();
        var tel_code = parent.find("input[type='text']").val();
        var id = $(this).data("id");
        if (tel_code.toString().length == 4 && $.isNumeric(tel_code)) {
            $.post("/modules/Lichniy-kabinet/ajax.php", {login: login, tel_code: tel_code, id: id, chgUserLogin: true}, function (data) {
                data = JSON.parse(data);
                parent.find(".alert").html(data.msg);
                if (data.status == "1") {
                    parent.find(".js_chg_device_anchor input").addClass("hidden");
                    parent.find(".js_chg_device_anchor a").addClass("hidden");
                    parent.find("input[type='email']").removeAttribute("disabled");
                    show_moderate();
                }
            });
        }else{
            parent.find(".alert").html("Введите полный 4-значный код подтверждения");
        }
    });

 /*   $(document).on("click", ".js_chg_tlg_lk", function () {

        var parent = $(this).closest(".input__item");
        var tlg = parent.find("input.tlg").val();
        var tel_code = parent.find("input.tlg_label").val();
        var id = $(this).data("id");
        if (tel_code.toString().length == 4 && $.isNumeric(tel_code)) {
            $.post("/modules/Lichniy-kabinet/ajax.php", {tlg: tlg, tel_code: tel_code, id: id, chgUserTlg: true}, function (data) {
                data = JSON.parse(data);
                parent.find(".alert").html(data.msg);
                if (data.status == "1") {
                    parent.find(".js_chg_device_anchor input").addClass("hidden");
                    parent.find(".js_chg_device_anchor a").addClass("hidden");
                    parent.find(".js_chg_device_anchor p").addClass("hidden");
                    parent.find("input.tlg").attr("disabled", false);
                    show_moderate();
                }
            });
        }else{
            parent.find(".alert").html("Введите полный 4-значный код подтверждения");
        }
    });*/

    $(document).on("change", ".js_choose_state", function () {
        var id = $(this).data("id");
        var state_id = $(this).val();
        $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, state_id: state_id, chooseState: true}, function (data) {
            $(".js_choose_city").html(data);
        });
    });

    $(document).on("change", ".js_choose_city", function () {
        var id = $(this).data("id");
        var city_id = $(this).val();
                   $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, city_id: city_id, chooseCity: true}, function () {

        });
    });

    $(document).on("change", ".js_choose_state_brand", function () {
        var id = $(this).data("id");
        var state_id = $(this).val();
        $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, state_id: state_id, chooseState_brand: true}, function (data) {
            $(".js_choose_city_brand").html(data);
        });
    });

    $(document).on("change", ".js_choose_city_brand", function () {
        var id = $(this).data("id");
        var city_id = $(this).val();
        $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, city_id: city_id, chooseCity_brand: true}, function () {

        });
    });

    $(document).on("change", ".js_job_date_till", function () {
        var id = $(this).data("id");
        var till_now = ($(this).is(":checked")) ? 1 : 0;
        $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, till_now: till_now, chgDateTill: true}, function () {
        });
    });

    $(document).on("change", ".js_job_fields", function () {
        var id = $(this).data("id");
        var field = $(this).data("field");
        var val = $(this).val();
        $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, field: field, val: val, chgJobField: true}, function () {
        });
    });


    $(document).on('change', '.input__ym-m, .input__ym-y', function () {
        var parent = $(this).closest(".input__ym");
        var id = parent.data("id");
        var field = parent.data("field");
        if (parent.find('.input__ym-y').val() && parent.find('.input__ym-m').val()){
            var val = parent.find('.input__ym-y').val() + '-' + parent.find('.input__ym-m').val() + '-01';
            $.post("/modules/Lichniy-kabinet/ajax.php", {id: id, field: field, val: val, chgJobField: true}, function () {
            });
        }
    });

    $(document).on("click", ".js_add_user_job", function () {
        var user = $(this).data("user");
        $.post("/modules/Lichniy-kabinet/ajax.php", {user: user, addJob: true}, function (data) {
            $(".js_job_anchor").append(data);
            $(".js_job_anchor select.select").select2({
                minimumResultsForSearch: Infinity
            });
        });
    });
 
    $(document).on("click", ".js_del_user_job", function () {
        var obj = $(this);
        obj.closest('.job_item').hide();
        $.post("/modules/Lichniy-kabinet/ajax.php", {id: $(this).data("id"), deleteJob: true}, function (data) {
        });
    });

    $(document).on("change", ".js_check_firm_landing", function () {
        var obj = $(this);
        var flag = obj.is(':checked') ? 1 : 0;
        var landing = obj.siblings(".js_firm_landing_id").val();
        var firm = $('input.js_brand_id').val();
        $.post("/modules/Lichniy-kabinet/ajax.php", {firm:firm, landing: landing, flag:flag, checkFirmLanding: true}, function () {
        });
    });

    $(document).on("click", ".js_add_firm_multifield", function () {
       var parent = $(this).closest('.input__item');
       var input = parent.find('input');
       var id = input.data('id');
       var field = input.data('field');
       var cl = input.attr('class');
       var multikey = parent.find('input').last().data('multikey')+1;
       parent.find('.input__item_inner_block').append('<div class="input__item_inner"><input type="text" class="'+cl+'" data-field="'+field+'" value="" data-id="'+id+'" data-multikey="'+multikey+'"/></div>');
       if (field == 'f_phone'){
           $('input.tel').inputmask("+7 (999) 999-99-99");
       }
    });

    $(document).on("click", ".js_add_site", function () {
        var firm = $(this).data('id');
        $.post(location.href, {addSite: true, firm:firm}, function (data) {
            $('.site_anchor').append(data);
        });
    });

    $(document).on("click", ".js_delete_site", function () {
        var id = $(this).data('id');
        var parent = $(this).closest('.site_block');
        $.post(location.href, {deleteSite: true, id:id}, function (data) {
            if(data){
                parent.remove();
            }
        });
    });

    $(document).on("change", ".js_chg_site", function () {
        var id = $(this).data('id');
        var field = $(this).data('field');
        var val = $(this).val();
        $.post(location.href, {chgSite: true, id:id, field:field, val:val}, function () {
        });
    });

});

function showAlert(html, classname) {
    var timeVar = new Date().getTime();
    $(".alerts").prepend('<div class="alert alert' + timeVar + " " + classname + '"><button type="button" class="close" data-dismiss="alert">&times;</button>' + html + '</div>');
    setTimeout(function () {
        $(".alert" + timeVar).fadeOut(400, function () {
            $(".alert" + timeVar).remove()
        })
    }, 9000);
}

function isJSON(data) {
    try {
        JSON.parse(data);
        return true;
    } catch (ex) {
        return false;
    }
}

function validateEmail(email) {
    //var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
    var reg = /^(([^<>()[\].,;:\s@"]+(\.[^<>()[\].,;:\s@"]+)*)|(".+"))@(([^<>()[\].,;:\s@"]+\.)+[^0-9<>()[\].,;:\s@"]{2,4})$/iu;

    if (reg.test(String(email).toLowerCase()) == true) {
        return true;
    }else{
        return false;
    }
}

function validateTlg(tlg) {

    var reg = /@[a-zA-Z0-9]{5,32}/;
    if (reg.test(String(tlg).toLowerCase()) == true) {
        return true;
    }else{
        return false;
    }
}