<div class="footer__top">
    <div class="container-fluid justify-space align-center">
        <div class="footer__left">
            <a href="/" class="footer__logo">
                <img src="/i/logo__hor-w.svg" class="footer__logo-img" alt="">
            </a>
            <div class="footer__contacts">

                {if $mainParams.TEL !=""}
                    <a href="tel:{$mainParams.TEL}" class="footer__contacts-phone">
                        <img src="/i/icon__phone.svg" class="svg" alt="">{$mainParams.TEL}
                    </a>
                {/if}
                {if $mainParams.EMAIL !=""}
                    <a href="mailto:{$mainParams.EMAIL}" class="footer__contacts-mail">
                        <img src="/i/icon__mail.svg" class="svg" alt="">{$mainParams.EMAIL}
                    </a>
                {/if}
                {if $mainParams.ADDR !=""}
                    <div class="footer__contacts-city">
                        <img src="/i/icon__point.svg" class="svg" alt="">{$mainParams.ADDR}
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
        </div>
        <div class="footer__right">
            {foreach item=data key=key from=$APP->menu.topMenu2}
                {if $key<3}
                    <div class="footer__nav">
                        <div class="footer__nav-title">{$data.title}</div>

                        <ul class="footer__nav-list">
                            {foreach item=data1 from=$data.inner}
                                <li class="footer__nav-item">
                                    <a href="{$data1.URL}" class="footer__nav-link">
                                        {$data1.title}
                                    </a>
                                </li>
                            {/foreach}
                        </ul>

                    </div>
                {/if}
            {/foreach}
        </div>
    </div>
</div>
<div class="footer__bottom">
    <div class="container-fluid justify-space align-center">
        <div class="footer__copy">
            © 2021-2022. Все права защищены.
        </div>
        <div class="footer__create">
            {include file="copyright.tpl"}
        </div>
        <div class="footer__privacy text-right">
            <a href="/Politika-obrabotki-personalnih-dannih/" class="footer__privacy-link">
                Политика обработки персональных данных
            </a>
        </div>
    </div>
</div>