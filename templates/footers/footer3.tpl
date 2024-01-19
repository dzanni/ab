<div class="footer__top">
    <div class="container-fluid justify-space align-center">
        <nav class="footer__nav">
            <ul class="footer__nav-list">
                {foreach item=data from=$APP->menu.topMenu}
                    <li class="footer__nav-item {if count($data.inner) > 0}parent{/if}">
                        <a href="{$data.URL}" class="footer__nav-link">{$data.title}</a>
                    </li>
                {/foreach}
            </ul>
        </nav>
        <a href="#" class="scroll__up">
            <img src="/i/icon__arrow-up.svg" alt="">
        </a>
    </div>
</div>

<div class="footer__bottom">
    <div class="container-fluid justify-space">
        <div class="footer__col">
            <a href="/" class="footer__logo">
                <img src="/i/logo__hor.png" class="footer__logo-img" alt="">
            </a>
            <div class="footer__copy">
                © 2021-2022. Все права защищены.
            </div>
            <a href="/Politika-obrabotki-personalnih-dannih/" class="footer__privacy-link">
                Политика обработки персональных данных
            </a>
            <div class="footer__create">
                {include file="copyright.tpl"}
            </div>
        </div>
        <div class="footer__col">
            {if $mainParams.ADDR !=""}
                <div class="footer__subtitle">
                    Адрес
                </div>
                <div class="footer__adress">
                    {$mainParams.ADDR}
                </div>
            {/if}

            {if $mainParams.SOCIAL_TLG !='' ||
            $mainParams.SOCIAL_VK !='' ||
            $mainParams.SOCIAL_INST !='' ||
            $mainParams.SOCIAL_WA !='' ||
            $mainParams.SOCIAL_VB !='' ||
            $mainParams.SOCIAL_FB !=''
            }
                <div class="footer__subtitle">
                    Мы в соцсетях
                </div>
            {/if}
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
        </div>
        <div class="footer__col">

            {if $mainParams.TEL !="" || $mainParams.EMAIL !=""}
                <div class="footer__subtitle">
                    Свяжитесь с нами
                </div>
            {/if}

            {if $mainParams.TEL !=""}
                <a href="tel:{$mainParams.TEL}" class="footer__contacts-phone">
                    {$mainParams.TEL}
                </a>
            {/if}
            {if $mainParams.EMAIL !=""}
                <a href="mailto:{$mainParams.EMAIL}" class="footer__contacts-mail">
                    {$mainParams.EMAIL}
                </a>
            {/if}
            <a href="#popup__order" class="footer__contacts-btn open__popup" data-title="Получить консультацию">
                Получить консультацию
            </a>
        </div>
    </div>

</div>