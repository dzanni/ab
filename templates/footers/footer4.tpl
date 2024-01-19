<div class="footer__top">
    <div class="container-fluid justify-space align-center">
        <div class="footer__form-title">
            Оставьте телефон и мы перезвоним<br>вам в течении 15 минут
        </div>
        <div class="footer__form-wrap form_block">
            <div class="form_title" style="display: none"> Оставьте телефон и мы перезвоним вам в течении 15 минут
            </div>{* Отсюда берем в письмо заглавие формы*}
            <form method="post" class="footer__form-form result" style="color: var(--main-bg-color)">
                <div class="footer__form-row">
                    <input type="text" class="footer__form-input data-provider not-empty" name="user_tel"
                           data-title="Телефон" placeholder="Телефон">
                    <input type="hidden" class="js_token_captcha" name="g-recaptcha-response">
                    <button type="button" class="footer__form-button js_send_form"
                            data-recaptcha="{$mainParams.RE_CAPCHA_FRONT}">
                        Отправить
                    </button>
                </div>
                <div class="footer__form-row">
                    <input type="checkbox" id="footer__form-privacy" class="footer__form-checkbox agree"
                           name="form__checkbox">
                    <label for="footer__form-privacy" class="footer__form-chekbox__label">
                        Я согласен(на) с <a href="/Politika-obrabotki-personalnih-dannih/">политикой
                            конфиденциальности</a> и даю согласие на обработку персональных данных
                    </label>
                </div>
                <br>
                <div class="result_not"></div>
            </form>
        </div>
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
        </div>
        <div class="footer__col">
            <div class="footer__subtitle">
                Меню
            </div>
            <nav class="footer__nav">
                <ul class="footer__nav-list">
                    {foreach item=data from=$APP->menu.topMenu}
                        <li class="footer__nav-item">
                            <a href="{$data.URL}" class="footer__nav-link">{$data.title}</a>
                        </li>
                    {/foreach}
                </ul>
            </nav>
        </div>
        <div class="footer__col">

            <div class="footer__subtitle">
                Контакты
            </div>
            {if $mainParams.TEL != ""}
                <a href="tel:{$mainParams.TEL}" class="footer__contacts-phone">
                    <img src="/i/icon__phone.svg" class="svg" alt="">{$mainParams.TEL}
                </a>
            {/if}
            {if $mainParams.EMAIL != ""}
                <a href="mailto:{$mainParams.EMAIL}" class="footer__contacts-mail">
                    <img src="/i/icon__mail.svg" class="svg" alt="">{$mainParams.EMAIL}
                </a>
            {/if}
            {if $mainParams.ADDR != ""}
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
        <div class="footer__col">

            {if
            $mainParams.SOCIAL_VK !='' ||
            $mainParams.SOCIAL_INST !='' ||
            $mainParams.SOCIAL_FB !=''
            }
                <div class="footer__subtitle">
                    Мы в соцсетях
                </div>
            {/if}

            <div class="footer__contacts-soc">

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
                {if $mainParams.SOCIAL_FB !=''}
                    <a href="{$mainParams.SOCIAL_FB}" class="contacts-soc__link">
                        <img src="/i/soc__fb.svg" alt="" class="svg">
                    </a>
                {/if}

            </div>
            <div class="footer__create">
                {include file="copyright.tpl"}
            </div>
        </div>
    </div>

</div>