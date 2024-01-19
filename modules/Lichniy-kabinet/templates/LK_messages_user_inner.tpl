{foreach from=$result item=m}
    <div class="msg js_msg message__list-item {if $m.my == "true"}my_msg{/if}" data-id="{$m.id}">
        {*<img src="{$viewer->get_icon_by_user($m.user_from)}"> закоментировал тк все руинится*} {* иконка от кого *}
					<div class="message__list-photo">
					<img src="{$viewer->get_icon_by_user($m.user_from)}"  class="message__list-img">
					</div>
					<div class="message__list-info">
						<div class="message__list-title">
							<div class="message__list-title-login">
								{$m.login_from}
								{if $m.my == "true"}
								<div class="message__nav-icon">
									<a class="message__nav-del js_remove_msg">
										<svg class="svg-sprite-icon icon-icon__q-del">
											<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-del"></use>
										</svg>
									</a>
								</div>
								{/if}
							</div>

							<div class="message__list-date">{$viewer->render_date($m.date)}</div>
						</div>
						<div class="message__list-text">{$viewer->render_txt($m.txt)}</div>
						<div class="message__list-files">
							{if count($m.files)}
									<div class="files_inner">
											{foreach from=$m.files item=f}
												<p class="file"> 
														{if $f.type == "image/png" ||  $f.type == "image/gif" || $f.type == "image/jpeg" }
																<a href="/account/messages/?file_id={$f.id}" target="_blank" data-fancybox><img src="/account/messages/?file_id={$f.id}"> </a>
																<a href="/account/messages/?file_id={$f.id}" target="_blank"><svg class="svg-sprite-icon icon-icon__q-del">
																<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__file"></use>
															</svg>{$f.name}</a>
														{else}
																<a href="/account/messages/?file_id={$f.id}" target="_blank"><svg class="svg-sprite-icon icon-icon__q-del">
																<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__file"></use>
															</svg>{$f.name}</a>
														{/if}
												</p>
										{/foreach}
									</div>
							{/if}
						</div>
						<!--p class="msg_from_info">
								<span class="date">{$viewer->render_date($m.date)}</span>
								<span class="from">{$m.login_from}</span>
								{if $m.order_id}
										<span>По заказу№: {$m.order_id}</span>{/if}
						</p-->
					</div>
    </div>
{/foreach}