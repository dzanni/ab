<div class="container-fluid justify-space align-center">
    <a href="/" class="header__logo">
        <img src="/i/logo__hor.png" class="header__logo-img" alt="">
    </a>
    <div class="header__contacts">
        <div class="header__contacts-col">
            {if $mainParams.TEL !=""}
                <a href="tel:{$mainParams.TEL}" class="contacts-phone__link">
                    <img src="/i/icon__phone.svg" alt="" class="svg">{$mainParams.TEL}
                </a>
            {/if}

            {assign var="cities" value=","|explode:$mainParams.CITY}
            {if $cities !=""}
                <div class="header__contacts-city">
                    <img src="/i/icon__point.svg" alt="" class="svg">{$cities.0|strip:''}
                </div>
            {/if}
        </div>
        <div class="header__contacts-col">
            <div class="header__contacts-soc">
                {if $mainParams.SOCIAL_TLG !=''}
                    <a href="{$mainParams.SOCIAL_TLG}" class="contacts-soc__link">
                        <img src="/i/soc__tg.svg" alt="" class="svg">
                    </a>
                {/if}
                {if $mainParams.SOCIAL_VK !=''}
                    <a href="{$mainParams.SOCIAL_VK}" class="contacts-soc__link">
                        <img src="/i/soc__vk.svg" alt="" class="svg">
                    </a>
                {/if}
                {if $mainParams.SOCIAL_INST !=''}
                    <a href="{$mainParams.SOCIAL_INST}" class="contacts-soc__link">
                        <img src="/i/soc__in.svg" alt="" class="svg">
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
                {if $mainParams.SOCIAL_FB !=''}
                    <a href="{$mainParams.SOCIAL_FB}" class="contacts-soc__link">
                        <img src="/i/soc__fb.svg" alt="" class="svg">
                    </a>
                {/if}

            </div>
            <a href="#popup__table" class="contacts-call__link open__popup-table" data-title="Заказать звонок">
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
