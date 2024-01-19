<div class="footer__top">
    <div class="container-fluid justify-center align-center">
        <nav class="footer__nav">
            <ul class="footer__nav-list">
                {foreach item=data from=$APP->menu.topMenu}
                    <li class="footer__nav-item {if count($data.inner) > 0}parent{/if}">
                        <a href="{$data.URL}" class="footer__nav-link">{$data.title}</a>
                    </li>
                {/foreach}
            </ul>
        </nav>
    </div>
</div>

<div class="footer__bottom">
    <div class="container-fluid justify-center align-center">
        <div class="footer__contacts-soc">
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
        <a href="/" class="footer__logo">
            <img src="/i/logo__vert.svg" class="footer__logo-img" alt="">
        </a>
        <div class="footer__copy">
            © 2021-2022. Все права защищены.
        </div>
        <a href="/Politika-obrabotki-personalnih-dannih/" class="footer__privacy-link">
            Политика обработки персональных данных
        </a>
    </div>
    <div class="footer__create line__top">
        {include file="copyright.tpl"}
    </div>
</div>