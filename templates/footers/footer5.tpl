<div class="footer__top">
    <div class="container-fluid justify-space">
        {foreach item=data key=key from=$APP->menu.topMenu2}
        {if $key < 2}
        <div class="footer__col">
            <div class="footer__title"">{$data.title}</div>
        <div class="footer__nav">
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
    </div>
    {/if}
    {/foreach}
    <div class="footer__col">
        <div class="footer__title">Оставайтесь на связи</div>
        <div class="footer__contacts">

            <a href="tel:{$mainParams.TEL}" class="footer__contacts-phone">
                {$mainParams.TEL} <div class="footer__contacts-time">({$mainParams.WORKOURS})</div>
            </a>

            <div class="footer__contacts-city">
                {$mainParams.ADDR}
            </div>

        </div>
        <div class="footer__form-wrap form_block">
            <form class="footer__form-form result">
                <div class="footer__form-title form_title">Заказать звонок</div>
                <div class="footer__form-row">
                    <input type="text" class="footer__form-input data-provider not-empty" name="user_tel"  data-title="Телефон" placeholder="Телефон">
                    <input type="hidden" class="js_token_captcha" name="g-recaptcha-response">
                    <button type="button" class="footer__form-button js_send_form" data-recaptcha="{$mainParams.RE_CAPCHA_FRONT}">
                        <img src="/i/icon__send.svg" alt="">
                    </button>
                </div>
                <div class="footer__form-row">
                    <input type="checkbox" id="footer__form-privacy2" class="footer__form-checkbox agree">
                    <label for="footer__form-privacy2" class="footer__form-chekbox__label">
                        Я согласен(на) с <a href="/Politika-obrabotki-personalnih-dannih/">политикой конфиденциальности</a> и даю согласие на обработку персональных данных
                    </label>
                </div>
                <br>
                <div class="result_not"></div>
            </form>
        </div>
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
</div>

<div class="footer__bottom">
    <div class="container-fluid justify-space align-center line__top">
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