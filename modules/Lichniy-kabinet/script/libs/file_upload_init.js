jQuery(document).ready(function () {

    $('.drop a').click(function(){
        // Simulate a click on the file input button
        // to show the file browser dialog
        $(this).parent().find('input').click();
    });

    $(document).on("click", ".js_quest_add", function () {
        $(".js_quest_add").removeClass("__js_current_active_quest_el");
        $(this).addClass("__js_current_active_quest_el");
    });
    // Initialize the jQuery File Upload plugin
    $('.upload').each(function(){
        $(this).fileupload({

            // This element will accept file drag/drop uploading
            dropZone: $(this).find('.drop'),

            // This function is called when a file is added to the queue;
            // either via the browse button, or via drag/drop:
            add: function (e, data) {

                if (e.currentTarget == document && $(".js_quest_add").length){ // если идет вставка файла через CTRL+V
                    // и если мы на странице вопросов
                    if ($(this).closest(".__js_current_active_quest_el").length == 0){
                        console.log('file_ext');
                        return;
                    }
                }
                // console.log(e.currentTarget == document, e.currentTarget, e, data);
                var ul = $(this).find('ul');

                $('.comAdd').hide();
                $('.upLoading').show();
                var tpl = $('<li class="working"><input type="text" value="0" data-width="48" data-height="48"'+
                    ' data-fgColor="#fc1e05" data-readOnly="1" data-bgColor="#ff7105" /><p></p><span></span></li>');

                // Append the file name and file size
                tpl.find('p').text(data.files[0].name)
                    .append('<i>' + formatFileSize(data.files[0].size) + '</i>');

                // Add the HTML to the UL element
                data.context = tpl.appendTo(ul);

                // Initialize the knob plugin
                tpl.find('input').knob();

                // Listen for clicks on the cancel icon
                tpl.find('span').click(function(){

                    if(tpl.hasClass('working')){
                        jqXHR.abort();
                    }


                });


                // Listen for clicks on the cancel icon
                $(".working span").click(function(){
                    var block_file = $(this).closest(".working");

                    block_file.fadeOut(function(){
                        block_file.remove();
                    });

                });

                // Automatically upload the file once it is added to the queue
                var jqXHR = data.submit();
            },

            progress: function(e, data){

                // Calculate the completion percentage of the upload
                var progress = parseInt(data.loaded / data.total * 100, 10);

                // Update the hidden input field and trigger a change
                // so that the jQuery knob plugin knows to update the dial
                data.context.find('input').val(progress).change();
                if(progress == 100){
                    data.context.fadeOut();
                    data.context.fadeIn();
                }
            },

            fail:function(e, data){
                // Something has gone wrong!
                data.context.addClass('error');
            },

            done:function(e, data){

                if ($(this).data("type") == "brand_logo"){
                    $(this).find(".working").remove();
                    $(".js_img_logo_brand").attr("src", "/images/f/"+$(".js_brand_id").val()+".jpg?a="+Date.now());
                }else if ($(this).data("type") == "tovar_img") {
                    $(this).find(".working").remove();
                    $(".sort_img").append(data.result);
                    $(".js_max-position").val(parseInt($(".js_max-position").val()) + 1);

                }else if ($(this).data("type") == "tovar_files") {
                    $(this).find(".working").remove();
                    $(".sort_files").append(data.result);

                }else if ($(this).data("type") == "quest_files") {
                    $(this).find(".working").remove();
                    $(".sort_files").append(data.result);

                }else if ($(this).data("type") == "tovar_glb") {
                    $(this).find(".working").remove();
                    $(".sort_glb").html(data.result);

                }else if ($(this).data("type") == "user_sertificate" || $(this).data("type") == "firm_document") {
                    $(this).find(".working").remove();
                    $(".sort_files").append(data.result);

                }else if ($(this).data("type") == "user_cv") {
                    $(this).find(".working").remove();
                    $(".sort_cv").html(data.result);

                }else if ($(this).data("type") == "answer_files") {
                    $(this).find(".working").remove();
                    $(this).closest(".js_quest_add").find(".sort_files").append(data.result);

                }else if ($(this).data("type") == "user_foto") {
                    $(this).find(".working").remove();
                    $(".js_img_logo").attr("src", "/images/u/"+$(".js_user_id").val()+".jpg?a="+Date.now());
                }else{
                    var itog = data.result;

                    $('.filelist').val(itog);
                    data.context.find('span').attr('filen',data.result);
                    data.context.find('span').addClass('ready');
                    if ($(this).data("type") !== "brand_logo"){
                        data.context.append('<a class="del_file account__button" data-id="'+data.result+'">Удалить</a>');
                    }
                }

            }

        });
    });

    /*function loadIMG(){
        $.post(location.href, {getImages:true}, function(data){
            data = JSON.parse(data);
            $('.sort_img').html(data);
        });
    }*/


    // Prevent the default action when a file is dropped on the window
    $(document).on('drop dragover', function (e) {
        e.preventDefault();
    });
    $(document).on("click", ".send_director_js", function() {
        $(".send_director_block-modal").arcticmodal();
    });

    $(document).on("click", ".del_file", function() {

        $(this).closest(".working").remove();
    });

});
// Helper function that formats the file sizes
function formatFileSize(bytes) {
    if (typeof bytes !== 'number') {
        return '';
    }

    if (bytes >= 1000000000) {
        return (bytes / 1000000000).toFixed(2) + ' GB';
    }

    if (bytes >= 1000000) {
        return (bytes / 1000000).toFixed(2) + ' MB';
    }

    return (bytes / 1000).toFixed(2) + ' KB';
}