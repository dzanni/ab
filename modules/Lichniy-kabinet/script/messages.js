jQuery(document).ready(function () {

    $(document).on("click",".js_chg_url", function(){
        location.href = $(this).data('href');
    });
    $(".js_add_new_msg_txt").keyup(function(event) {
        if (event.keyCode === 13) {
            $(".js_add_new_msg").click();
        }
    });
     $(document).on("click", ".js_add_new_msg", function(){
         var obj = $(this).closest(".js_msg_container");
         var curr = $(this);
         if (curr.hasClass("just_send")){
             showAlert("Подождите. Сообщение уже отправляется.", "bad");
             return;
         }
         $(this).addClass("just_send");

         if (obj.find(".del_file").length == 0 && obj.find(".js_add_new_msg_txt").val() == "" ){
             showAlert("Пустое сообщение не отправляется", "bad");
             return false;
         }else{
             var fn = "";
             obj.find(".del_file").each(function () {
                 fn+="~~"+$(this).data("id");
             });
             var url = "/account/messages/";
             if (curr.data("user_to")){
                 url+="?user_to="+curr.data("user_to");
             }
             $.post(url,{"add_MSG":true, data:obj.find(".js_add_new_msg_txt").val(), files:fn, order:curr.data("order")}, function (data) {
                 data = $.parseJSON(data);
                 //showAlert(data.msg, data.class);
                 //obj.find(".js_msg_main_div").append(data.result);
                 curr.removeClass("just_send");
                 obj.find(".js_add_new_msg_txt").val("");
                 obj.find("ul").html("");
             });
         }
         return false;
     });

     if ($(".js_msg_inner_start").length){
         setTimeout(update_msg, 1000);
     }

     function update_msg() {
         var obj = $(".js_msg_main_div .js_msg");
         var last = $(".js_msg_inner_start").data("max");
         if (obj.length){
             var tmp = $(".js_msg_main_div .js_msg").last().data('id');
             if (tmp > last){
                 last = tmp;
             }
         }

         $.get(location.href,{get_new_from: last},function(data) {
             data = $.parseJSON(data);
             $(".js_msg_inner_start").find(".js_msg_main_div").append(data.result);

             if (data.result){
                 /* крутим к новому сообщению */
                 let $parentDiv = $('.message__list-wrap-inner');
                 let $innerListItem = $('.message__list ');
                 $parentDiv.scrollTop($innerListItem.outerHeight());
                 /* конец крутим к новому сообщению */
             }

             if (data.col_unread > 0){
                 $(".js_msg_new").html("<span>"+data.col_unread+"</span>");
                 set_favicon(data.col_unread);
             }else{
                 $(".js_msg_new").html("");
                 $('link[rel="shortcut icon"]').remove();
                 $('head').append('<link id="favicon" rel="shortcut icon" href="/favicon.ico" type="image/x-icon">');
             }
             setTimeout(update_msg, 1000); // Запускаем через секунду еще раз.
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