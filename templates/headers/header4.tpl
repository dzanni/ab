<div class="header__top">
    <div class="container-fluid justify-space align-center header__line">
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

        <a href="/account/" class="header__auth">
            <div class="header-auth__icon">
                <img src="/i/icon__auth.svg" alt="" class="svg">
            </div>
            {if $APP->user->login}ВхКабинет {$APP->user->login}од{else}Войти / Регистрация{/if}
        </a>

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
        <div class="header__contacts">
            <div class="header__contacts-col">
                <div class="header__contacts-time">
                    {$mainParams.WORKOURS}
                </div>
                <a href="tel:{$mainParams.TEL}" class="contacts-phone__link">
                    {$mainParams.TEL}
                </a>
            </div>
        </div>

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

        <div class="js_basket">{$APP->order->render_mini_basket()}</div>
    </div>
</div>