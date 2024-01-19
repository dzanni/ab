{foreach from=$result item=m}
    {* нужно оставить div т.к. внутри могут быть ссылки <a> и все развалится *}
    <div data-href="/account/messages/?user_to={$m.user_to_chat}" class="js_chg_url msg  messages__item {if $m.has_seen == 0}not_read{/if} {if $m.my == "true"}my_msg{/if}">
        <div class="messages__item-inner">
					<div class="messages__item-photo"><img src="{$viewer->get_icon_by_user($m.user_to_chat)}" class="messages__item-img"></div>
					<div class="messages__item-info">
						<div class="messages__item-header">
							<div class="messages__item-title">{$m.user_name}</div>
							<div class="messages__item-date">{$viewer->render_date($m.date)}</div>
							<!--a href="#" class="messages__item-del"><svg class="svg-sprite-icon icon-icon__q-del">
																<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-del"></use>
															</svg></a-->
						</div>
						{if $m.my == "true"}
						<div class="messages__item-inner-m">
							<div class="messages__item-photo">
								<img src="{$viewer->get_icon_by_user($m.user_from)}" class="messages__item-m-img">
							</div>
							<div class="messages__item-text">
								{$viewer->render_txt($m.txt)}
								{if $m.unread_col}<div class="messages__item-unread">{$m.unread_col}</div>{/if}
						
							</div>
						</div>
						{else}
						<div class="messages__item-text">
							{$viewer->render_txt($m.txt)}
							{if $m.unread_col}<div class="messages__item-unread">{$m.unread_col}</div>{/if}
						
						</div>
						{/if} {* иконка меня *}
						
						{if count($m.files)}
								<div class="files_inner">
										{foreach from=$m.files item=f}
												<p class="file"><a href="/account/messages/?file_id={$f.id}" target="_blank">{$f.name}</a> </p>
										{/foreach}
								</div>
						{/if}
						<!--p class="msg_from_info">
	
								<span class="from">{$m.login_from}</span>
								{if $m.order_id}<span>По заказу№: {$m.order_id}</span>{/if}
						</p-->
					</div>
				</div>
    </div>
{/foreach}