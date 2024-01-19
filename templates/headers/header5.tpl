<div class="header__top">
    <div class="container-fluid justify-space align-center header__line">
        {assign var="cities" value=","|explode:$mainParams.CITY}
        <div class="header__city">
            {*<a class="header__city-current"><div class="js_city_anchor">{$cities.0|strip:''}</div>
                <img src="/i/icon__arrow.svg" class="svg" alt="">
            </a>*}
            <div class="header__city-popup">
                {foreach from=$cities item=data}
                    <a class="city-popup__link js_chg_city" data-city="{$data|strip:''}">{$data|strip:''}</a>
                {/foreach}
            </div>
        </div>
        <div class="header__contacts">
            {if $mainParams.TEL != ""}
            <a href="tel:{$mainParams.TEL}" class="contacts-phone__link">
                <img src="/i/icon__phone.svg" class="svg" alt="">{$mainParams.TEL}
            </a>
            {/if}
            {if $mainParams.EMAIL != ""}
            <a href="mailto:{$mainParams.EMAIL}" class="contacts-mail__link">
                <img src="/i/icon__mail.svg" class="svg" alt="">{$mainParams.EMAIL}
            </a>
            {/if}
        </div>
        {if $mainParams.SHOW_SEARCH == 1}
            <div class="header__form">
                <form action="/Poisk/" class="header-search">
                    <label for="search" class="header-search__label">
                        <input type="text" value="{$search_txt_val}" class="header-search__input" id="search" name="search">
                        <button type="submit" class="header-search__submit"><img src="/i/icon__search.svg" alt=""></button>
                    </label>
                </form>
            </div>
        {/if}

        {if $APP->user->login}
            <a href="/account/" class="header__auth">Кабинет {$APP->user->login}</a>
        {else}
            <div class="header-auth__icon">
                <img src="/i/icon__auth.svg" class="svg" alt="">
            </div>
            <a href="/account/" class="header__auth">Войти / Регистрация</a>
        {/if}

    </div>
</div>

<div class="header__bottom">
    <div class="container-fluid align-center">
        <a href="#" class="header__menu-open">
            <span></span>
            <span></span>
            <span></span>
        </a>
        <div class="header__logo">
            <a href="/" class="header__logo-link">
                <img src="/i/logo__hor.png" class="header__logo-img" alt="">
            </a>
        </div>
        <nav class="header__nav">
            <ul class="header__nav-list">

                {foreach item=data from=$APP->menu.topMenu}
                    <li class="header__nav-item {if count($data.inner) > 0}parent{/if}">
                        <a href="{$data.URL}" class="header__nav-link">{$data.title}</a>
                        <ul class="header__nav-childs-list">
                            {foreach item=data1 from=$data.inner}
                                <li class="header__nav-childs-item">
                                    <a href="{$data1.URL}" class="header__nav-childs-link">
                                        {$data1.title}
                                    </a>
                                </li>
                            {/foreach}
                        </ul>
                    </li>
                {/foreach}

            </ul>
        </nav>
        <div class="js_basket">{$APP->order->render_mini_basket()}</div>

    </div>
</div>