<section class="main-screen ver_04">
    <img src="/{$block.0.IMG}" class="main-screen__bg" alt="">
    <div class="container-fluid">
        <div class="main-screen__wrap">
            <div class="main-screen__info">
                {if $block.0.title !=""}
                <div class="main-screen__title">
                    {$block.0.title}
                </div>
                {/if}
                {if $block.0.text !=""}
                <div class="main-screen__desc">
                    {$block.0.text}
                </div>
                {/if}
            </div>
            <div class="main-screen__form form_block">
                <div class="form_title" style="display: none">{$block.0.title}</div>{* Отсюда берем в письмо заглавие формы*}
                <form method="post" class="form__content result">

                    {if $block.0.name != "Скрыть"}
                    <label class="form__label">
                        <input type="text" name="user_name" class="form__input data-provider {if $block.0.name == "Обязательное"}not-empty{/if} js_name" data-title="Имя" placeholder="Имя {if $block.0.name == "Обязательное"}*{/if}">
                    </label>
                    {/if}

                    {if $block.0.tel != "Скрыть"}
                    <label class="form__label">
                        <input type="tel" name="user_tel" class="form__input data-provider {if $block.0.tel == "Обязательное"}not-empty{/if} js_tel" data-title="Телефон" placeholder="Телефон  {if $block.0.tel == "Обязательное"}*{/if}">
                    </label>
                    {/if}

                    {if $block.0.email != "Скрыть"}
                    <label class="form__label">
                        <input type="text" name="user_email" class="form__input data-provider {if $block.0.email == "Обязательное"}not-empty{/if}" data-title="E-mail" placeholder="E-mail {if $block.0.email == "Обязательное"}*{/if}">
                    </label>
                    {/if}

                    {if $block.0.comment != "Скрыть"}
                    <label class="form__label">
                        <input type="text" name="user_comment" class="form__input data-provider {if $block.0.comment == "Обязательное"}not-empty{/if}" data-title="Комментарий" placeholder="Комментарий {if $block.0.comment == "Обязательное"}*{/if}">
                    </label>
                    {/if}

                    <div class="result_not"></div>

                    <input type="hidden" class="js_token_captcha" name="g-recaptcha-response">
                    <button type="button" class="button form__button js_send_form" data-recaptcha="{$mainParams.RE_CAPCHA_FRONT}">{if $block.0.button_text !="" }{$block.0.button_text}{else}Отправить{/if}</button>

                    <div class="form__check">
                    <input type="checkbox" name="form__checkbox" id="form__checkbox" class="agree form__checkbox" checked>
                        <label class="form__label-checkbox" for="form__checkbox">
                            Я согласен(на) с <a href="/">политикой конфиденциальности</a>
                            и даю согласие на <a href="/">обработку персональных данных</a>
                        </label>
                    </div>
                    <br>

                </form>
            </div>
        </div>
    </div>
</section>
