<main class="message__user "><div class="content__block">

		<div class="message__user-nav">
			<a href="/account/messages/" class="message__user-back"><svg class="svg-sprite-icon icon-icon__arrow-l">
                      <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__arrow-l"></use>
                    </svg>Назад</a>
			<div class="message__user-header">
					<div class="message__user-header-photo">
						<img src="{$viewer->get_icon_by_user($smarty_params.user_to)}"  class="message__user-header-img">
					</div>
					<div class="message__user-header-title">{$viewer->get_name_user($smarty_params.user_to)}</div>
			</div>
			
		</div>

    <h3>{$smarty_params.h1}</h3>

    <div class="js_msg_container js_msg_inner_start" data-max="{$obj->get_max_id()}">
        {if $rule_get}
					<div class="message__list-wrap"><div class="message__list-wrap-inner">
						<div class="js_msg_main_div message__list ">{$html_inner}</div>
					</div></div>
        {/if}
				<div class="message__user-send-wrap">
				<div class="message__user-send">
          <textarea name="comment-edit-textarea" class="textarea_autoheight comment-edit-textarea-input js_add_new_msg_txt"></textarea>
					<a class="js_add_new_msg account__button button" data-order="0" {if $smarty_params.user_to}data-user_to="{$smarty_params.user_to}"{/if}>Отправить</a>
				</div>
						<form class="upload" id="upload_files" method="post" action="/modules/Lichniy-kabinet/loadFilesQuick.php" enctype="multipart/form-data">
								<ul></ul><div class="drop">
										<input type="file" name="upl" id="file" multiple="">
										<label for="file">Прикрепить файл</label>
										<p>Или перетащите файлы в эту область</p>
								</div>
								
						</form>

					
    <div class="alerts"></div>
		</div>

    </div>

   {* <div class="js_pages">{$html_pages}</div>*}

		</div>
</main>