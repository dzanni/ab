<aside>
	<nav class="aside">
	<a href="#" class="mobile__aside-open"><span class="aside__burger"> <span></span><span></span><span></span><span></span></span>МОЙ КАБИНЕТ</a>
		<ul class="aside__list">
    {foreach from=$menu item=m}
        {if !$m.no_show}

            <li class="aside__item {if $m.selected}selected{/if}"><a href="{$m.url}" class=" aside__link">
						<svg class="svg-sprite-icon icon-footer__logo">
							<use xlink:href="/i/v2/svg/symbol/sprite.svg#{$m.class}"></use>
						</svg>{$m.title} {if $m.unread}<div class="js_msg_new">{if $m.unread > 0}<span>{$m.unread}</span>{/if}</div>{/if}</a></li>

			{*{if $m.class == "LK_quest"}
				<li class="aside__item "><a href="/quests/?tag=&q_type=interests" class=" aside__link">
						<svg class="svg-sprite-icon icon-footer__logo">
							<use xlink:href="/i/v2/svg/symbol/sprite.svg#{$m.class}"></use>
						</svg>Интересные вопросы</a></li>
				<li class="aside__item "><a href="/quests/?tag=&q_type=answers" class=" aside__link">
						<svg class="svg-sprite-icon icon-footer__logo">
							<use xlink:href="/i/v2/svg/symbol/sprite.svg#{$m.class}"></use>
						</svg>С моими ответами</a></li>
			{/if}*}
        {/if}
    {/foreach}

{*
        {if $user->role_GAK < 4}
      <li class="aside__item"><a href="/account/users/?lk_users_edit_profile={$user->id}" class="aside__link">Личные_данные</a></li>
        {/if}
        *}

        <li class="aside__item"><a class="aside__link" href="/account/?exit_from_lk"><svg class="svg-sprite-icon icon-footer__logo">
							<use xlink:href="/i/v2/svg/symbol/sprite.svg#LK_logout"></use>
						</svg>Выход</a></li>

   {*{if $user->role_GAK >= 4}
        <li class="aside__item"><a class="techno_button_on js_edit_header_and_footer" href="/account/?chg_header_footer">Редактировать хедер и футер</a></li>
    {/if} *}


			<!--li class="aside__item"><a class="aside__link" href="#">
					<svg class="svg-sprite-icon icon-icon__users">
						<use xlink:href="static/images/svg/symbol/sprite.svg#icon__users"></use>
					</svg><span class="aside__title">Компании</span></a></li-->

 
		</ul>
	</nav>
</aside>
