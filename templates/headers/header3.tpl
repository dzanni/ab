<div class="header__top">
    <div class="container-fluid justify-center align-center header__line">
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
    </div>
</div>
<div class="header__bottom">
    <div class="container-fluid align-center">
        {if $mainParams.TEL !=""}
            <div class="header__contacts">
                <div class="header__contacts-icon">
                    <img src="/i/icon__phone-dark.svg" alt="" class="svg">
                </div>
                <div class="header__contacts-col">
                    <div class="header__contacts-time">
                        {$mainParams.WORKOURS}
                    </div>
                    <a href="tel:{$mainParams.TEL}" class="contacts-phone__link">
                        {$mainParams.TEL}
                    </a>
                </div>
            </div>
        {/if}
        <div class="header__logo">
            <a href="/" class="header__logo-link">
                <img src="/i/logo__vert.svg" class="header__logo-img" alt="">
            </a>
        </div>
        <div class="header__contacts-soc">
            {if $mainParams.SOCIAL_VK !=''}
                <a href="{$mainParams.SOCIAL_VK}" class="contacts-soc__link">
                    <img src="/i/soc__vk.svg" alt="" class="svg">
                </a>
            {/if}
            {if $mainParams.SOCIAL_FB !=''}
                <a href="{$mainParams.SOCIAL_FB}" class="contacts-soc__link">
                    <img src="/i/soc__fb.svg" alt="" class="svg">
                </a>
            {/if}
            {if $mainParams.SOCIAL_INST !=''}
                <a href="{$mainParams.SOCIAL_INST}" class="contacts-soc__link">
                    <img src="/i/soc__in.svg" alt="" class="svg">
                </a>
            {/if}
            {if $mainParams.SOCIAL_TLG !=''}
                <a href="{$mainParams.SOCIAL_TLG}" class="contacts-soc__link">
                    <img src="/i/soc__tg.svg" alt="" class="svg">
                </a>
            {/if}
            {if $mainParams.SOCIAL_WA !=''}
                <a href="{$mainParams.SOCIAL_WA}" class="contacts-soc__link">
                    <img src="/i/soc__wa.svg" alt="" class="svg">
                </a>
            {/if}
            {if $mainParams.SOCIAL_VB !=''}
                <a href="{$mainParams.SOCIAL_VB}" class="contacts-soc__link">
                    <img src="/i/soc__vi.svg" alt="" class="svg">
                </a>
            {/if}
        </div>
        <a href="#" class="header__menu-open">
            <span></span>
            <span></span>
            <span></span>
        </a>
    </div>
</div>