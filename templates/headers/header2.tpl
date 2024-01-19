<div class="header__top">
    <div class="container-fluid justify-space align-center">
        <a href="/" class="header__logo">
            <img src="/i/logo__hor.png" class="header__logo-img" alt="">
        </a>
        <div class="header__contacts">
            <div class="header__contacts-col">
                {if $mainParams.TEL !=""}
                    <a href="tel:{$mainParams.TEL}" class="contacts-phone__link">
                        {$mainParams.TEL}
                    </a>
                {/if}
                {if $mainParams.EMAIL !=""}
                    <a href="mailto:{$mainParams.EMAIL}" class="contacts-mail__link">
                        <img src="/i/icon__mail.svg" alt="" class="svg">{$mainParams.EMAIL}
                    </a>
                {/if}
            </div>

            <div class="header__contacts-col">
                <a href="#popup__order" class="contacts-call__link open__popup" data-title="Заказать звонок">
                    Заказать звонок
                </a>
            </div>
        </div>
        <a href="#" class="header__menu-open">
            <span></span>
            <span></span>
            <span></span>
        </a>
    </div>
</div>
<div class="header__bottom">
    <div class="container-fluid justify-space align-center line__top">
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
    </div>
</div>