<main>
    {*<a class="account__button button button--orange">Сохранить</a><br>*}
    {if !$user->tlg_id}
    <a class="account__button button button--orange" href="https://t.me/aboss_expert_bot" target="_blank">Привязать профиль к телеграм</a><br>
    {/if}

    <div class="lk_menu label_style">
        <div class="content__block">
            Отправляйте реферальную ссылку: https://expert.a-boss.ru/account/?lk_reg&u_from={$user->id}
            и получайте баллы, если по ней будут регистрироваться новые пользователи!
						<br><br>
            {$viewer->gen_share("https://expert.a-boss.ru/account/?lk_reg&u_from={$user->id}", true)}

        </div>
        <div class="content__block">

            {*<div class="row__input">
                <div class="input__item w2">
                    <label><h4 class="label_title">Ваше имя:</h4> <span class="account__item-coment"><input type="text" class="js_lk_chg slyle_input" data-field="name" placeholder="{$user->name}"></span></label></p>
                </div><div class="input__item w2">
                    <label><h4 class="label_title">Ваш телефон:</h4> <span class="account__item-coment"><input type="tel" class="*}{*js_lk_chg*}{* slyle_input js_check_new_tel" name="phone" data-field="tel" placeholder="{$user->tel}"></span></label>
                    <span class="js_check_new_tel_alert">
                {if $user->tel_verification == 0}
                    <a class="account__button js_lk_chg_tel" data-tel="{$user->tel}">Подтвердить телефон</a>
                {/if}

            </span>
                    </p>
                    <div class="js_result"></div>
                </div></div>*}

            <a class="js_pwd_chg_open account__button button button--orange">Сменить пароль</a>

            <div class="js_pwd_anchor hidden">

                <h4 class="block__title">Смена пароля</h4>

                <form class="js_register_form">

                    <div class="row__input">
                        <div class="input__item ">
                            <label><h4 class="label_title">Старый пароль:</h4> <span class="account__item-coment"><input
                                            type="password" class="slyle_input" name="old_pwd"></span> </label>
                        </div></div>
                    <div class="row__input">
                        <div class="input__item ">
                            <label><h4 class="label_title">Новый пароль:</h4> <span class="account__item-coment"><input
                                            type="password" class="slyle_input" name="new_pwd1"></span> </label>
                        </div></div>
                    <div class="row__input">
                        <div class="input__item ">
                            <label><h4 class="label_title">Повторите новый пароль:</h4> <span
                                        class="account__item-coment"><input type="password" class="slyle_input" name="new_pwd2"></span></label>
                        </div></div>

                    <div class="js_result"></div>

                    <a class="js_pwd_chg account__button button button--orange">Сменить</a>
                    <a class="js_pwd_chg_close account__button button">Отмена</a>
                </form>
            </div>
        </div>
        <div class="content__block">
            {if $obj->checkMyFirms()}
                <h4 class="block__title">Эти компании указали вас в качестве сотрудника</h4>
                <div class="render_work lk__brand-list-wrap">
                    <!--div class="render_work-info">
                        Поставьте галочку, если согласны<br>
                        Снимите галочку, если не согласны
                    </div-->
                    <div class="lk__brand-list">
                        {foreach from=$obj->checkMyFirms() item=data}

                            <label>
                                <a href="/firms/?firm={$data.firm_id}" class="render_checkbox_list">{$data.firm_title}</a>
                                <span><input type="checkbox" name="is_my_firm" {if $data.agree}checked{/if} data-firm="{$data.firm_id}" data-user="{$data.user_id}">
                             Согласиться</span>
                                <span class="lk_checkbox_alert"></span>
                            </label>

                        {/foreach} </div>
                    <br>
                    <a class="js_accept_all_firm account__button_render button button--orange">Сохранить</a>
                </div>
            {/if}
        </div>
        <div class="content__block">
            {if $obj->checkMyClientStatus()}
                <h4 class="block__title">Заявки на указание ваших компаний в качестве клиентов</h4>
                <div class="render_work lk__brand-list-wrap">
                    <!--div class="render_work-info">
                        Поставьте галочку, если согласны<br>
                        Снимите галочку, если не согласны
                    </div-->

                    {foreach from=$obj->checkMyClientStatus() item=data}
                        <div class="render_work_title">{$data.title} - клиент компаний:</div>
                        <div class="lk__brand-list">{foreach from=$data.inner item=data_inner}
                                <div>
                                    <label>
                                        <a href="/firms/?firm={$data_inner.firm_id}" class="render_checkbox_list">{$data_inner.firm_title}</a>
                                        <span><input type="checkbox" name="i_am_client" {if $data_inner.agree}checked{/if} data-id="{$data_inner.id}">
                                    Согласиться</span>
                                        <span class="lk_checkbox_alert"></span>
                                    </label>
                                </div>

                            {/foreach}</div>
                    {/foreach}
                    <br>
                    <a class="js_accept_all_client account__button_render button button--orange">Сохранить</a>
                </div>
            {/if}

        </div>
    </div></main>



