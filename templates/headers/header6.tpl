<div class="container"><a class="open__nav" href="#"> <span></span><span></span><span></span><span></span></a>
    <div class="logo">
        {*<a class="logo__link" href="/">
            <svg class="svg-sprite-icon icon-logo">
                <use xlink:href="/i/v2/svg/symbol/sprite.svg#logo"></use>
            </svg>
            <span class="logo__desc">Международная профессиональная сеть экспертов автобизнеса</span>
        </a>*}
        <a class="logo__link desctop_only" href="/">
            <img src="/i/logo/main_logo.svg?v2">
        </a>
        <a class="logo__link mobile_only" href="/">
            <img src="/i/logo/mobile_logo.svg?v1">
        </a>
    </div>
    <nav class="nav">
        <ul class="nav__list">
            {foreach item=data from=$APP->menu.topMenu}
                <li class="nav__item {if count($data.inner) > 0}parent{/if}">
                    <a href="{$data.URL}"
                       class="nav__link {if $data.URL == $APP->route->path_category}active{/if}">{$data.title}</a>
                    <ul class="nav__link-childs-list">
                        {foreach item=data1 from=$data.inner}
                            <li class="nav__link-child-item">
                                <a href="{$data1.URL}" class="nav__link-child">
                                    {$data1.title}
                                </a>
                            </li>
                        {/foreach}
                    </ul>
                </li>
            {/foreach}
        </ul>
    </nav>

    <!--<div class="header-auth__icon">
					<img src="/i/icon__auth.svg" alt="" class="svg">
			</div>
			<a href="/account/">{if $APP->user->login}{$APP->user->login}</a>
			&nbsp;/&nbsp;
			<a href="/account/?exit_from_lk"> Выход</a>
					{else}
			<a href="/account/">Войти </a>
			&nbsp;/&nbsp;
			<a href="/account/?lk_reg"> Регистрация</a>
			{/if}
			{* <div class="header-auth__icon basket" style="margin-left:20px">
				<img src="/i/icon__basket_20.svg" alt="" class="svg">
			</div>
			<a href="/basket/" class="js_basket">{$APP->order->render_mini_basket()}</a>*}-->

    {if $APP->user->auth && $APP->user->status == 1}
        <div class="profile__nav">
            {*<a class="profile__link" href="/account/">
                <svg class="svg-sprite-icon icon-profile__setting">
                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#profile__setting"></use>
                </svg>
            </a>*}
            {*<a class="profile__push" href="#">
                <svg class="svg-sprite-icon icon-profile__push">
                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#profile__push"></use>
                </svg>
            </a>*}
            {if $APP->user->status == 1}
            <a class="profile__push" href="/account/messages/">
                <div class="js_msg_new">{if $viewer->get_msg_count()}<span>{$viewer->get_msg_count()}</span>{/if}</div>
                <svg class="svg-sprite-icon icon-footer__logo">
                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#LK_messages"></use>
                </svg>
            </a>
            {/if}
           {* <a class="profile__ava" href="/users/?user={$APP->user->id}"><img class="profile__ava-img js_img_logo" src="{$viewer->get_icon_by_user($APP->user->id)}"  alt=""></a>*}
            <a class="profile__ava" href="/account/"><img class="profile__ava-img js_img_logo" src="{$viewer->get_icon_by_user($APP->user->id)}"  alt=""></a>


        </div>
    {elseif $APP->user->auth && $APP->user->status != 1}
        <div class="profile__nav">
            <a class="profile__link" href="/account/users/?lk_users_edit_profile={$APP->user->id}">
                <svg class="svg-sprite-icon icon-profile__setting">
                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#profile__setting"></use>
                </svg>
            </a>
        </div>

    {else}
        <div class="profile__auth">
            <a class="profile__link button" href="/account/?lk_reg">Регистрация</a>
            <a class="profile__link button button--orange" href="/account/">Вход</a>
        </div>

    {/if}

</div>


<!--
				{$mainParams.ADDR}

				<a href="tel:{$mainParams.TEL}" class="contacts-phone__link">
						{$mainParams.TEL}
				</a>

 

        {if $mainParams.SHOW_SEARCH == 1}
            <div class="header__form">
                <form action="/Poisk/" class="header-search">
                    <label for="search" class="header-search__label">
                        <input type="text" value="{$search_txt_val}" class="header-search__input" id="search" name="search">
                        <button type="submit" class="header-search__submit"><img src="/i/icon__search.svg" alt=""></button>
                    </label>
                    <div class="header-search__radio">
                        <input type="radio" name="radio__search" id="num" checked>
                        <label for="num" class="header-search__radio-item">по номеру</label>
                        <input type="radio" name="radio__search" id="name">
                        <label for="name" class="header-search__radio-item">по наименованию</label>
                    </div>
                </form>
            </div>
        {/if}

-->
