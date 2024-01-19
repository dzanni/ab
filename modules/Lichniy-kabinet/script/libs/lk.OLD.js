jQuery(document).ready(function () {



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


    $(document).on("click", ".js_otkaz .canceled-button", function(e){
        var obj = $(this).closest(".js_otkaz");
        var checked = obj.find(".order__item-list-canceled-reason-label input:checked");
        if (checked.length == 0 && obj.find(".canceled-message-input").val() == ''){
            showAlert("Укажите причину отказа пожалуйста", "bad");
            return false;
        }
        $.post("/account/orders/", {mk_otkaz:true, id:$(this).data('id'), reason:checked.closest("label").find("span").text(), comment:obj.find(".canceled-message-input").val()}, function (data) {
            data = $.parseJSON(data);
            showAlert(data.msg, data.class);
        });

    });
    $(document).on("click", ".js_send_register_request", function(e){
        var parent = $(this).closest(".js_register_form");
        var result = parent.find(".js_result");
        var show_err = true;

        var msg = '';
        parent.find(".email").each(function(){
            var pattern = /^[a-z0-9_-]+@[a-z0-9-]+\.[a-z]{2,6}$/i;
            if(!($(this).val().search(pattern) == 0)) {
                msg+="<p>Поле e-mail заполнено некорректно "+$(this).data("title")+"</p>";
            }
        });
        parent.find(".notEmpty").each(function(){
            if($(this).val() == '' || $(this).val() == 0) {
                msg+="<p>Ошибка: не заполнено обязательное поле "+$(this).data("title")+"</p>";
            }
        });
        if (msg !=''){
            showMsg(result, msg, "bad");
            return;
        }
        result.html("");

        grecaptcha.ready(function() {
            e.preventDefault();
            grecaptcha.execute('6LejM-kbAAAAAB_xjSFPNew3MuBJ2QndoLlsYLip', {action: 'submit'}).then(function(token) {
                parent.find(".js_token_captcha").val(token);
                $.post("/modules/Lichniy-kabinet/ajax.php", parent.serialize(), function (data) {
                    data = JSON.parse(data);
                    showMsg(result, data.msg, data.err);
                });
                show_err = false;
            });
        });
        if (!show_err){
            showMsg(result, '* Вы не прошли проверку "Я не робот"', "bad");
        }
    });
    $(document).on("click", ".js_mk_auth_init", function(e){
        var parent = $(this).closest(".js_auth_form");
        var result = parent.find(".js_result");
        var show_err = true;
        grecaptcha.ready(function() {
            e.preventDefault();
            grecaptcha.execute('6LejM-kbAAAAAB_xjSFPNew3MuBJ2QndoLlsYLip', {action: 'submit'}).then(function(token) {
                parent.find(".js_token_captcha").val(token);
                parent.submit();
                show_err = false;
            });
        });
        if (!show_err){
            showMsg(result, '* Вы не прошли проверку "Я не робот"', "bad");
        }
    });


    $(document).on("click", ".js_mk_forget_pwd", function (e) {
        var parent = $(this).closest(".js_mk_forget_pwd_obj");
        var result = parent.find(".js_result");
        var login = parent.find(".js_login").val();
        var show_err = true;
        grecaptcha.ready(function() {
            e.preventDefault();
            grecaptcha.execute('6LejM-kbAAAAAB_xjSFPNew3MuBJ2QndoLlsYLip', {action: 'submit'}).then(function(token) {
                parent.find(".js_token_captcha").val(token);
                if (login !== ''){
                    $.post("/modules/Lichniy-kabinet/ajax.php", {login:login, forget_pwd:true, "g-recaptcha-response":token}, function (data) {
                        data = JSON.parse(data);
                        showMsg(result, data.msg, data.err);
                    });
                }else{
                    showMsg(result, "Укажите пожалуйста почту, на которую у Вас зарегистрирован аккаунт", 1);
                }
                show_err = false;
            });
        });
        if (!show_err){
            showMsg(result, '* Вы не прошли проверку "Я не робот"', "bad");
        }
    });

    $(document).on("click", ".js_add_new_obj", function () {
        var root = $(this).closest(".js_add_new_element");
        var res = {};
        root.find(".js_add").each(function (i) {
            res[$(this).data("field")] = $(this).val();
        });
        $.post(location.href,res,function(data){
            data = $.parseJSON(data);
            root.find(".result").html(data.msg);
            if (data.id > 0){
                var res = {"s_id":data.id};
                show_data(1,res);
                root.find('.js_showAll').removeClass("hidden");
            }
        });
    });

    $(document).on("click", ".js_remove_id_add_filer", function () {
        var root = $(this).closest(".js_showAll").addClass("hidden");
        show_data(1,'');
    });


    $(document).on("click", ".js_set_edit", function () {
        $(this).closest(".js_chg_row").find(".js_val").addClass("hidden");
        $(this).closest(".js_chg_row").find(".js_chg").removeClass("hidden");
    });

    $(document).on("change", ".js_chg", function () {
        var res = {};
        res["chg_data"] = true;
        res["f_id"] = $(this).data("id");
        res[$(this).data("field")] = $(this).val();
        $.post(location.href,res,function(data){
            data = $.parseJSON(data);
            showAlert(data.msg, data.class);
        });
    });

    $(document).on("click", ".js_set_remove", function () {
        var res = {};
        var obj = $(this).closest(".js_chg_row");
        res["delete_data"] = true;
        res["f_id"] = $(this).data("id");
        $.post(location.href,res,function(data){
            data = $.parseJSON(data);
            showAlert(data.msg, data.class);
            if (data.class="good"){
                obj.remove();
            }
        });
    });

    $(document).on("click", ".js_pages_chg", function(){
        show_data($(this).data("page"),'');
    });
    $(document).on("click", ".js_sort_block .sort", function(){
        if ($(this).hasClass("selected")){
            return false;
        }
        $(".js_sort_block .sort").removeClass("selected");
        $(this).addClass("selected");
        show_data(1,'');
    });
    $(document).on("change", ".js_search", function(){
        show_data(1,'');
    });

    function show_data(page, res){
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
        $.get(location.href,res,function(data){
            data = $.parseJSON(data);
            $('.js_inner_result_data').html(data.html);
            $('.js_pages').html(data.pageHtml);
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

    $( ".sort_img" ).sortable({
        stop: function( event, ui ) {
            var pos = {};
            $(this).find(".sort_img_item").each(function(i) {
                pos[i] = {id:$(this).data("id"), pos:i};
            });
            $.post(location.href, {pos:pos, chgTovarImgPosition : true});
        }
    });

   $(document).on("click", ".js_delete_img", function(){
        var filename;
        filename = $(this).data("filename");
        //alert(filename);
        $(this).parent(".img_block").html('');
        $.post(location.href, {filename:filename, deleteIMG : true});
    });

    $(document).on("click", ".js_delete_files", function(){
        var filename;
        filename = $(this).data("filename");
        $(this).parent(".files_block").html('');
        $.post(location.href, {filename:filename, deleteFiles : true});
    });

    $(document).on("change", ".js_chg_filename", function(){
        var id;
        var new_user_filename;
        id = $(this).data("id");
        new_user_filename = $(this).val();
        $.post(location.href, {id:id, new_user_filename : new_user_filename, chgFilename : true});
    });

    $(document).on("change", ".js_edit_options", function(){
        var obj = $(this);
        obj.addClass("current");
        var tovar_id = obj.data("id");
        var options_id = obj.val();

        $.post("/modules/Vivod-spiska-tovarov/ajax.php", {tovar_id:tovar_id, options_id:options_id, editOptions : true}, function (data) {
            var className = "";
            var parent_obj = obj.closest('.js_selectors');
            parent_obj.find('.js_edit_options').each(function () {
                $(this).addClass(className);
                if ($(this).hasClass("current")){
                    className = "remove";
                    $(this).removeClass("current")
                }
            });
            parent_obj.find(".remove").remove();
            parent_obj.append(data);
        });

        //Рекурсия не работает - зацикливается

        /*  var new_parent_obj = obj.closest('.js_selectors');
          new_parent_obj.find(".js_edit_options").each(function () {

            var a = $(this).val();
            var b = $(this).closest('.js_edit_options').prev().val();

            if ((b) && (a != -1) && (a != b)) {
                 alert("Тест " + a + " " + b);
              //$(this).closest('.js_edit_options').trigger("change");
             }
           });*/
        // Конец неработающего кода рекурсии

    });

    $(document).on("change", ".js_check_options", function(){
        var tovar_id;
        var options_id;
        var flag;
        tovar_id = $(this).data("id");
        options_id = $(this).data("options");
        if ($(this).is(':checked')){
            flag = 1;
        }
        else{
            flag = 0;
        }
        $.post("/modules/Vivod-spiska-tovarov/ajax.php", {tovar_id:tovar_id, options_id:options_id, flag:flag, chgOptions : true}, function (data) {

        });
    });

  $(".js_selectors").find(".js_edit_options").each(function() {
      //$(this).html('Это this');
        //$(this).trigger("change");
        LoadSubSelect($(this));
    });


    function LoadSubSelect(obj) {
        var tovar_id = obj.data("id");
        var options_id = obj.val();

        $.post("/modules/Vivod-spiska-tovarov/ajax.php", {
            tovar_id: tovar_id,
            options_id: options_id,
            editOptions: true
        }, function (data) {
            var parent_obj = obj.closest('.js_selectors');
            parent_obj.append(data);
        });

        /*$(".js_selectors .js_edit_options").each(function() {

           var parent_obj = $(this).closest(".js_selectors");
           parent_obj.add('.js_edit_options').each(function () {
              $(this).trigger("change");
          });
    
        });*/
    }

    $(document).on("click", ".js_save_option_line", function(){
       var tovar_id = $(this).data("id");
       var key = $(this).data("key");
       var options = [];

      var parent = $(this).closest(".js_selectors");
      parent.find(".js_edit_options").each(function () {
            options.push($(this).val());
       });
       $.post("/modules/Vivod-spiska-tovarov/ajax.php", {tovar_id:tovar_id, options:options, key:key, saveOptions : true}, function () {
        });
    });

});