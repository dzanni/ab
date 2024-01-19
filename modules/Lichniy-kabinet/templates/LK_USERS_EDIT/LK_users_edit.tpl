<main>
    <div class="lk_menu lk_user">
        {assign var="res" value=$result.0}

        {if $res.id}
            <input type="hidden" value="{$res.id}" class="js_user_id">
            <h3>{$smarty_params.h1} (ID: {$res.id})</h3>
            {$msg_load_price}
            {*<a class="account__button button button--orange">Сохранить</a>*}
        <div class="content__block">
            Все изменения автоматически сохраняются.
        </div>

            <div class="content__block">
                <h4 class="block__title">Базовые данные</h4>
                <div class="row__input">
                    <div class="input__item w3">
                        <h4>Имя *</h4>
                        <input type="text" class="js_chg slyle_input" data-field="f_name" value="{$res.name}"
                               data-id="{$res.id}"/>
                    </div>
                    <div class="input__item w3">
                        <h4>Фамилия *</h4>
                        <input type="text" class="js_chg slyle_input" data-field="f_family_name"
                               value="{$res.family_name}"
                               data-id="{$res.id}"/>
                    </div>
                    <div class="input__item w3">
                        <h4>Отчество </h4>
                        <div class="input__show">
                            <input type="text" class="js_chg slyle_input" data-field="f_father_name"
                                   value="{$res.father_name}"
                                   data-id="{$res.id}"/>
                            <select class="js_chg lk_select" data-field="f_father_name_show" data-id="{$res.id}">
                                <option value="0" {if $res.father_name_show==0}selected="selected"{/if}>Не показывать
                                    пользователям
                                </option>
                                <option value="1" {if $res.father_name_show==1}selected="selected"{/if}>Показывать
                                    пользователям
                                </option>
                            </select>
                            <a href="#" class="input__show-button" data-view="f_father_name_show">
                                <svg class="svg-sprite-icon icon__eye-show {if $res.father_name_show==1} selected{/if}"
                                     data-text="Показывать пользователям">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-show"></use>
                                </svg>
                                <svg class="svg-sprite-icon icon__eye-hide {if $res.father_name_show==0} selected{/if}"
                                     data-text="Не показывать пользователям">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-hide"></use>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="row__input">
                    <div class="input__item w3">
                        <h4>Дата рождения *</h4>
                        <div class="input__show">
                            <div class="input__birthday">
                                <input type="text" name="input__birthday-day" class="input__birthday-day"
                                       value="{$smarty_params.date.3}">
                                <select name="input__birthday-month" class="select input__birthday-month">
                                    <option value="01" {if $smarty_params.date.2=="01"}selected{/if}>январь</option>
                                    <option value="02" {if $smarty_params.date.2=="02"}selected{/if}>февраль</option>
                                    <option value="03" {if $smarty_params.date.2=="03"}selected{/if}>март</option>
                                    <option value="04" {if $smarty_params.date.2=="04"}selected{/if}>апрель</option>
                                    <option value="05" {if $smarty_params.date.2=="05"}selected{/if}>май</option>
                                    <option value="06" {if $smarty_params.date.2=="06"}selected{/if}>июнь</option>
                                    <option value="07" {if $smarty_params.date.2=="07"}selected{/if}>июль</option>
                                    <option value="08" {if $smarty_params.date.2=="08"}selected{/if}>август</option>
                                    <option value="09" {if $smarty_params.date.2=="09"}selected{/if}>сентябрь</option>
                                    <option value="10" {if $smarty_params.date.2=="10"}selected{/if}>октябрь</option>
                                    <option value="11" {if $smarty_params.date.2=="11"}selected{/if}>ноябрь</option>
                                    <option value="12" {if $smarty_params.date.2=="12"}selected{/if}>декабрь</option>
                                </select>
                                <input type="text" name="input__birthday-year" value="{$smarty_params.date.1}"
                                       class="input__birthday-year">
                            </div>
                            <input type="hidden" class="js_chg slyle_input" data-field="f_birthday"
                                   value="{$res.birthday}"
                                   data-id="{$res.id}"/>
                            <select class="js_chg lk_select" data-field="f_birthday_show" data-id="{$res.id}">
                                <option value="0" {if $res.birthday_show==0}selected="selected"{/if}>Не показывать
                                    пользователям
                                </option>
                                <option value="1" {if $res.birthday_show==1}selected="selected"{/if}>Показывать
                                    пользователям
                                </option>
                            </select>
                            <a href="#" class="input__show-button" data-view="f_birthday_show">
                                <svg class="svg-sprite-icon icon__eye-show {if $res.birthday_show==1} selected{/if}"
                                     data-text="Показывать пользователям">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-show"></use>
                                </svg>
                                <svg class="svg-sprite-icon icon__eye-hide {if $res.birthday_show==0} selected{/if}"
                                     data-text="Не показывать пользователям">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-hide"></use>
                                </svg>
                            </a>
                        </div>
                    </div>
                    <div class="input__item w3">
                        <h4>Страна</h4>
                        <select class="select js_choose_state" data-id="{$res.id}">
                            <option value="0">Ничего не выбрано</option>
                            {foreach from=$smarty_params.states item=data}
                                <option value="{$data.id}"
                                        {if $obj->check_tag_select($data.id,1)}selected{/if}>{$data.title}</option>
                            {/foreach}

                        </select>
                    </div>
                    <div class="input__item w3">
                        <h4>Город</h4>
                        <select class="select js_choose_city" data-id="{$res.id}">
                            <option value="0">Ничего не выбрано</option>
                            {foreach from=$smarty_params.cities item=data}
                                <option value="{$data.id}"
                                        {if $obj->check_tag_select($data.id,-1)}selected{/if}>{$data.title}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="row__input">
                    <div class="input__item">
                        <h4>Фото *</h4>
                        <div class="input__foto">
                            <div class="input__foto-text">Фотография помогает персонализировать ваш аккаунт. <br> Рекомендуемый размер 500х500px. </div>
                            <div class="sort_foto">
                                <img class="logo js_img_logo" src="{$viewer->get_icon_by_user($res.id)}">
                            </div>
                            <form class="upload" data-type="user_foto" method="post"
                                  action="/account/users/?lk_users_edit_profile={$res.id}&upload"
                                  enctype="multipart/form-data">
                                <div class="drop">
                                    <input type="hidden" name="user" value="{$res.id}">
                                    <input type="hidden" name="loadFoto" value="true">
                                    <input type="file" name="upl" id="file" multiple="">
                                    <label for="file">
                                        <svg class="svg-sprite-icon icon-footer__logo">
                                            <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__upload"></use>
                                        </svg>
                                        Загрузить файл</label>
                                    <p>Или перетащите в эту область</p>
                                </div>
                                <ul></ul>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content__block">
                <h4 class="block__title" id="verificate">Контакты</h4>

                <p>Вы можете скрыть/открыть свою почту и телефон от пользователей, если нажмете значок "глаз" рядом со своими данными</p>
                <div class="row__input">
                    <div class="input__item w2">
                        <h4>Телефон * </h4>
                        <div class="input__show"><input type="tel" class="{*js_chg*} slyle_input tel js_open_chg_device"
                                                        data-field="f_tel"
                                                        value="{$res.tel}" data-id="{$res.id}"/>
                            <select class="js_chg lk_select" data-field="f_tel_show" data-id="{$res.id}">
                                <option value="0" {if $res.tel_show==0}selected="selected"{/if}>Не показывать
                                    пользователям
                                </option>
                                <option value="1" {if $res.tel_show==1}selected="selected"{/if}>Показывать
                                    пользователям
                                </option>
                            </select>
                            <a href="#" class="input__show-button" data-view="f_tel_show">
                                <svg class="svg-sprite-icon icon__eye-show {if $res.tel_show==1} selected{/if}"
                                     data-text="Показывать пользователям">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-show"></use>
                                </svg>
                                <svg class="svg-sprite-icon icon__eye-hide {if $res.tel_show==0} selected{/if}"
                                     data-text="Не показывать пользователям">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-hide"></use>
                                </svg>
                            </a>
                        </div>
                        <div class="js_chg_device_anchor">
                            {if !$res.tel_verification}
                                <br>
                                <a class="account__button button button--orange js_open_chg_device_sbmt" data-id="{$res.id}">Подтвердить телефон</a>
                            {/if}
                            <br>
                            <input type="text" class="slyle_input hidden" placeholder="Код подтверждения"/>
                            <br><br>
                            <a class="account__button button button--orange hidden js_chg_tel_lk" data-id="{$res.id}">Выполнить</a>
                            <div class="alert"></div>
                        </div>
                    </div>
                    <div class="input__item w2">
                        <h4>E-mail * </h4>
                        <div class="input__show"><input type="email" class="{*js_chg*} slyle_input js_open_chg_device"
                                                        data-field="f_login"
                                                        value="{$res.login}"
                                                        data-id="{$res.id}"/>
                            <select class="js_chg lk_select" data-field="f_login_show" data-id="{$res.id}">
                                <option value="0" {if $res.login_show==0}selected="selected"{/if}>Не показывать
                                    пользователям
                                </option>
                                <option value="1" {if $res.login_show==1}selected="selected"{/if}>Показывать
                                    пользователям
                                </option>
                            </select>
                            <a href="#" class="input__show-button" data-view="f_login_show">
                                <svg class="svg-sprite-icon icon__eye-show {if $res.login_show==1} selected{/if}"
                                     data-text="Показывать пользователям">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-show"></use>
                                </svg>
                                <svg class="svg-sprite-icon icon__eye-hide {if $res.login_show==0} selected{/if}"
                                     data-text="Не показывать пользователям">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-hide"></use>
                                </svg>
                            </a>
                        </div>
                        <div class="js_chg_device_anchor">
                            {if !$res.mail_verification}
                                <br>
                                <a class="account__button button button--orange js_open_chg_device_sbmt" data-id="{$res.id}">Подтвердить E-Mail</a>
                            {/if}
                            {* <a class="account__button button button--orange js_open_chg_device" data-id="{$res.id}">Сменить e-mail</a>*}
                            <br>
                            <p class="hidden">Проверьте почту и введите код из письма</p>
                            <input type="text" class="slyle_input hidden" placeholder="Код подтверждения"/>
                            <br><br>
                            <a class="account__button button button--orange hidden js_chg_login_lk" data-id="{$res.id}">Выполнить</a>
                            <div class="alert"></div>
                        </div>
                    </div>

                    {*<div class="input__item w2">
                        <h4>Телеграм (имя аккаунта, начиная со знака @)</h4>
                        <div class="input__show"><input type="text" class=" tlg slyle_input js_open_chg_device"
                                                        data-field="f_tlg"
                                                        value="{$res.tlg}" data-id="{$res.id}"/>
                            <select class="js_chg lk_select" data-field="f_tlg_show" data-id="{$res.id}">
                                <option value="0" {if $res.tlg_show==0}selected="selected"{/if}>Не показывать
                                    пользователям
                                </option>
                                <option value="1" {if $res.tlg_show==1}selected="selected"{/if}>Показывать
                                    пользователям
                                </option>
                            </select>
                            <a href="#" class="input__show-button" data-view="f_tlg_show">
                                <svg class="svg-sprite-icon icon__eye-show {if $res.tlg_show==1} selected{/if}"
                                     data-text="Показывать пользователям">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-show"></use>
                                </svg>
                                <svg class="svg-sprite-icon icon__eye-hide {if $res.tlg_show==0} selected{/if}"
                                     data-text="Не показывать пользователям">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-hide"></use>
                                </svg>
                            </a>
                        </div>
                        <div class="js_chg_device_anchor">
                            {if !$res.tlg_verification && $res.tlg}
                                <br>
                                <a class="account__button button button--orange js_open_chg_device_sbmt" data-id="{$res.id}">Подтвердить телеграм</a>
                            {/if}
                            <br>
                            <p class="hidden">Введите в <a href="https://t.me/aboss_expert_bot" target="_blank">телеграм-боте</a> команду /code и получите код подтверждения</p>
                            <input type="text" class="slyle_input hidden tlg_label" placeholder="Код подтверждения"/>
                            <br><br>
                            <a class="account__button button button--orange hidden js_chg_tlg_lk" data-id="{$res.id}">Выполнить</a>
                            <div class="alert"></div>
                        </div>
                    </div>*}

                </div>
            </div>
            <div class="content__block">
                <h4 class="block__title">Карьера</h4>
                <h4 class="block__subtitle">Опыт в автобизнесе</h4>

                <div class="js_job_anchor">
                    {foreach from=$smarty_params.jobs item=data}
                        <div class="job_item">
                            <div class="row__input">
                                <div class="input__item w3">
                                    <h4>Начало работы</h4>
                                    <div class="input__ym" data-field="date_start" data-id="{$data.id}">
                                        <select class="lk_select select input__ym-m">
                                            <option value="">Месяц</option>
                                            <option value="01" {if $data.date_start.2=="01"}selected{/if}>январь
                                            </option>
                                            <option value="02" {if $data.date_start.2=="02"}selected{/if}>февраль
                                            </option>
                                            <option value="03" {if $data.date_start.2=="03"}selected{/if}>март</option>
                                            <option value="04" {if $data.date_start.2=="04"}selected{/if}>апрель
                                            </option>
                                            <option value="05" {if $data.date_start.2=="05"}selected{/if}>май</option>
                                            <option value="06" {if $data.date_start.2=="06"}selected{/if}>июнь</option>
                                            <option value="07" {if $data.date_start.2=="07"}selected{/if}>июль</option>
                                            <option value="08" {if $data.date_start.2=="08"}selected{/if}>август
                                            </option>
                                            <option value="09" {if $data.date_start.2=="09"}selected{/if}>сентябрь
                                            </option>
                                            <option value="10" {if $data.date_start.2=="10"}selected{/if}>октябрь
                                            </option>
                                            <option value="11" {if $data.date_start.2=="11"}selected{/if}>ноябрь
                                            </option>
                                            <option value="12" {if $data.date_start.2=="12"}selected{/if}>декабрь
                                            </option>
                                        </select>
                                        <select class="lk_select select input__ym-y">
                                            <option value="">Год</option>
                                            {foreach from=$smarty_params.all_years item=year}
                                                <option value="{$year}"
                                                        {if $data.date_start.1=="{$year}"}selected{/if}>{$year}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="input__item w3">
                                    <h4>Окончание</h4>

                                    <div class="input__checkbox">
                                        <input class="js_job_date_till" name="till_{$data.id}" type="checkbox"
                                               id="check_{$data.id}" {if $data.till_now}checked{/if}
                                               data-id="{$data.id}">
                                        <label class="input__checkbox-label" for="check_{$data.id}">
                                            По настоящее время
                                        </label>
                                    </div>
                                </div>
                                <div class="input__item w3">
                                    <h4>&nbsp;</h4>
                                    <div class="input__ym" data-field="date_end" data-id="{$data.id}">
                                        <select class="lk_select select input__ym-m">
                                            <option value="">Месяц</option>
                                            <option value="01" {if $data.date_end.2=="01"}selected{/if}>январь</option>
                                            <option value="02" {if $data.date_end.2=="02"}selected{/if}>февраль</option>
                                            <option value="03" {if $data.date_end.2=="03"}selected{/if}>март</option>
                                            <option value="04" {if $data.date_end.2=="04"}selected{/if}>апрель</option>
                                            <option value="05" {if $data.date_end.2=="05"}selected{/if}>май</option>
                                            <option value="06" {if $data.date_end.2=="06"}selected{/if}>июнь</option>
                                            <option value="07" {if $data.date_end.2=="07"}selected{/if}>июль</option>
                                            <option value="08" {if $data.date_end.2=="08"}selected{/if}>август</option>
                                            <option value="09" {if $data.date_end.2=="09"}selected{/if}>сентябрь
                                            </option>
                                            <option value="10" {if $data.date_end.2=="10"}selected{/if}>октябрь</option>
                                            <option value="11" {if $data.date_end.2=="11"}selected{/if}>ноябрь</option>
                                            <option value="12" {if $data.date_end.2=="12"}selected{/if}>декабрь</option>
                                        </select>
                                        <select class="lk_select select input__ym-y">
                                            <option value="">Год</option>
                                            {foreach from=$smarty_params.all_years item=year}
                                                <option value="{$year}"
                                                        {if $data.date_end.1=="{$year}"}selected{/if}>{$year}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row__input">
                                <div class="input__item w2">
                                    <h4>Название компании</h4>
                                    <input type="text" class="js_job_fields slyle_input" data-field="firm_title"
                                           value='{$data.firm_title}'
                                           data-id="{$data.id}"/>
                                </div>
                                <div class="input__item w2">
                                    <h4>Должность</h4>
                                    <input type="text" class="js_job_fields slyle_input" data-field="job_title"
                                           value="{$data.job_title}"
                                           data-id="{$data.id}"/>
                                </div>
                            </div>

                            <div class="row__input">
                                <div class="input__item">
                                    <a class="js_del_user_job button button__add-work" data-id="{$data.id}">Удалить
                                        место
                                        работы</a>
                                    <br>
                                </div>
                            </div>
                        </div>
                    {/foreach}
                </div>

                <div class="row__input">
                    <div class="input__item">
                        <a class="js_add_user_job button button__add-work" data-user="{$res.id}">Добавить место
                            работы</a>
                    </div>
                </div>



                <div class="row__input">
                    <div class="input__item w3">
                        <h4>Опыт в автобизнесе</h4>
                        <select class="js_chg lk_select select" data-field="f_experience" data-id="{$res.id}">
                            <option value="">Не выбрано</option>
                            {foreach from=$obj->getExperienceList() item=data}
                                <option value="{$data.id}"
                                        {if $res.experience==$data.id}selected="selected"{/if}>{$data.title}</option>
                            {/foreach}
                        </select>
                        <div class="input__info">
                            <svg class="svg-sprite-icon icon__info">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__info"></use>
                            </svg>
                            не отражается на личной странице
                        </div>
                    </div>

                    <div class="input__item w3">
                        <h4>Уровень должности*</h4>
                        <select class="js_chg lk_select select" data-field="f_job_level" data-id="{$res.id}">
                            <option value="">Не выбрано</option>
                            {foreach from=$obj->getJobLevelList() item=data}
                                <option value="{$data.id}"
                                        {if $res.job_level==$data.id}selected="selected"{/if}>{$data.title}</option>
                            {/foreach}
                        </select>
                        <div class="input__info">
                            <svg class="svg-sprite-icon icon__info">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__info"></use>
                            </svg>
                            не отражается на личной странице
                        </div>
                        {* <div class="tag_cloud_item label gray">
                                <a href="#popup__param" class="filter-form__label-title open__popup_param" data-id="-2" data-param="Уровень должности">Предложить свой вариант</a>
                        </div>*}
                    </div>
                </div>

                {if $smarty_params.role_GAK >= 4}
                    <div class="row__input" style="background: #ccc;">
                        <h4 class="block__subtitle">Блок видит только администратор</h4>
                    <div class="input__item w3">
                        <h4>Основное место работы</h4>
                        <input type="text" class="js_chg slyle_input" data-field="f_job_place" value='{$res.job_place}' data-id="{$res.id}"/>
                        {*  <select class="js_chg lk_select" data-field="f_firm" data-id="{$res.id}">
                              <option value="0"
                                      {if $res.firm==0}selected="selected"{/if}>Другое
                              </option>
                              {foreach from=$smarty_params.firm item=data}
                                  <option value="{$data.id}"
                                          {if $data.id==$res.firm}selected="selected"{/if}>{$data.title}
                                  </option>
                              {/foreach}
                          </select>*}
                    </div>
                    <div class="input__item w3">
                        <h4>Должность *</h4>
                        <div class="input__show"><input type="text" class="js_chg slyle_input" data-field="f_job_title"
                                                        value="{$res.job_title}"
                                                        data-id="{$res.id}"/>
                            <select class="js_chg lk_select" data-field="f_job_title_show" data-id="{$res.id}">
                                <option value="0" {if $res.job_title_show==0}selected="selected"{/if}>Не показывать
                                    пользователям
                                </option>
                                <option value="1" {if $res.job_title_show==1}selected="selected"{/if}>Показывать
                                    пользователям
                                </option>
                            </select>
                            <a href="#" class="input__show-button" data-view="f_job_title_show">
                                <svg class="svg-sprite-icon icon__eye-show {if $res.job_title_show==1} selected{/if}"
                                     data-text="Показывать пользователям">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-show"></use>
                                </svg>
                                <svg class="svg-sprite-icon icon__eye-hide {if $res.job_title_show==0} selected{/if}"
                                     data-text="Не показывать пользователям">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-hide"></use>
                                </svg>
                            </a>
                        </div>
                    </div>

                </div>
                {/if}


                <div class="row__input">
                    <div class="input__item">
                        <h4 class="block__subtitle">Образование</h4>
                        <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_education"
                                  data-field="f_education"
                                  data-id="{$res.id}" rows="4">{$res.education}</textarea>

                    </div>
                </div>
                <div class="row__input">
                    <div class="input__item">

                        <h4 class="block__subtitle">Достижения в автобизнесе</h4>
                        <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_success"
                                  data-field="f_success"
                                  data-id="{$res.id}" rows="4">{$res.success}</textarea>

                    </div>
                </div>
                <div class="row__input">
                    <div class="input__item">
                        <h4 class="block__subtitle">Чем я могу быть полезен сообществу</h4>

                        <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_is_duty"
                                  data-field="f_is_duty" data-id="{$res.id}" rows="4">{$res.is_duty}</textarea>
                    </div>
                </div>
                <div class="row__input">
                    <div class="input__item">
                        <h4 class="block__subtitle">Мои выступления и публикации</h4>

                        <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_is_duty"
                                  data-field="f_my_publications" data-id="{$res.id}" rows="4">{$res.my_publications}</textarea>
                    </div>
                </div>
                <div class="row__input">
                    <div class="input__item">
                        <h4 class="block__subtitle">Несколько слов о себе</h4>
                        <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_about"
                                  data-field="f_about"
                                  data-id="{$res.id}" rows="4">{$res.about}</textarea>
                        {*<a class="account__button js_chg_field" data-id="field_about">Сохранить описание</a>*}
                    </div>
                </div>
                <div class="row__input">
                    <div class="input__item">
                        <h4 class="block__subtitle">Резюме (в формате PDF)</h4>
                        <div class="sort_cv">
                            {if $smarty_params.cv_exist == true}
                                <a class="underline" href="/images/cv/cv{$res.id}.pdf">cv{$res.id}.pdf</a>
                                <span class="js_delete_cv_file">
										<svg class="svg-sprite-icon icon__delete">
											<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__delete"></use>
										</svg>
                                </span>
                            {/if}
                        </div>
                        <form class="upload" data-type="user_cv" method="post"
                              action="/account/users/?lk_users_edit_profile={$res.id}&uploadCV"
                              enctype="multipart/form-data">
                            <div class="drop">
                                <input type="hidden" name="user" value="{$res.id}">
                                <input type="hidden" name="loadCV" value="true">
                                <input type="file" name="upl" id="cv" multiple="">
                                <label for="cv">
                                    <svg class="svg-sprite-icon icon-footer__logo">
                                        <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__upload"></use>
                                    </svg>
                                    Загрузить файл</label>
                                <p>Или перетащите в эту область</p>
                            </div>
                            <ul></ul>
                        </form>
                    </div>
                </div>
                <div class="row__input">
                    <div class="input__item">
                        <h4 class="block__subtitle">Сертификаты</h4>
                        <div class="sort_files">
                            {foreach from=$smarty_params.sertificates item=f}
                                <div class="files_block sort_file_item" data-id="{$f.id}">
                                    <div class="input__file">
                                        <div class="input__file-label">
                                            {$f.user_filename}
                                            <span class="js_delete_files cross" data-id="{$f.id}"
                                                  data-filename="{$f.filename}">

										<svg class="svg-sprite-icon icon__delete">
											<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__delete"></use>
										</svg>
												</span>
                                        </div>
                                        <div class="input__file-label"><input type="text"
                                                                              class="js_chg_sertificate slyle_input"
                                                                              value='{$f.title}' data-id="{$f.id}"
                                                                              data-field="title"
                                                                              placeholder="Наименование"/></div>
                                        <div class="input__file-label"><input type="text"
                                                                              class="js_chg_sertificate slyle_input"
                                                                              value='{$f.description}'
                                                                              data-id="{$f.id}" data-field="description"
                                                                              placeholder="Описание"/></div>
                                        <div class="input__file-label"><input type="date"
                                                                              class="js_chg_sertificate slyle_input"
                                                                              value="{$f.date}" data-id="{$f.id}"
                                                                              data-field="date"
                                                                              placeholder="Дата получения"/></div>


                                    </div>
                                </div>
                                {assign var="max_position" value=$f.position+1}
                            {/foreach}
                        </div>
                        <form class="upload" data-type="user_sertificate" method="post"
                              action="/account/users/?lk_users_edit_profile={$res.id}&uploadSertificate"
                              enctype="multipart/form-data">
                            <div class="drop">
                                <input type="hidden" name="loadSertificate" value="true">
                                <input type="hidden" name="user" value="{$res.id}">
                                <input type="hidden" class="js_max-position" name="max-position"
                                       value="{$max_position}">
                                <input type="file" name="upl" id="file_sertificate" multiple="">
                                <label for="file_sertificate">
                                    <svg class="svg-sprite-icon icon-footer__logo">
                                        <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__upload"></use>
                                    </svg>
                                    Загрузить файл</label>
                                <p>Или перетащите в эту область</p>
                            </div>
                            <ul></ul>
                        </form>
                    </div>
                </div>
            </div>
            {* Тег "страна" ($data.id == 1) хардкодим на два уровня *}
            <div class="content__block" style="display: none">
                <h4 class="block__title">Страна и регион</h4>
                <div class="lk_tag_box">
                    {foreach from=$smarty_params.tags item=data}
                        {if $data.id ==1}
                            <div class="lk_tag_box_two_colons"> {* Div для вывода страна-регион в две колонки*}
                                <div class="js_chg_element">
                                    <h4>{$data.title}</h4>
                                    <div class="filter_js_anchor">
                                        <input type="text" placeholder="Найти"
                                               class="js_fast_filter_mark filter_checkbox_search_lk" value="">

                                        <div {if count($data.inner) > 5}class="filter_content_lk"{/if}> {*div для локализации прокрутки контента*}
                                            {foreach from=$data.inner key=key item=data1}
                                                {if $data.is_multi==0 && $key == 0}
                                                    <div>
                                                        <label>
                                                            <input type="radio" name="radio{$data.id}"
                                                                   class="js_check_tags"
                                                                   data-subj_type="user"
                                                                   data-id="{$res.id}"
                                                                   data-tag="0"
                                                                   data-root="{$data.id}"
                                                                   data-is_multi="{$data.is_multi}">
                                                            <span class="filter-form__label-title">Ничего не выбрано</span>
                                                        </label>
                                                    </div>
                                                {/if}
                                                <div>
                                                    <label>
                                                        <input {if $data.is_multi==1}type="checkbox" {else}type="radio"
                                                               name="radio{$data.id}"{/if} {if $obj->check_tag_select($data1.id, $data.id)}checked="checked"{/if}
                                                               class="js_check_tags js_check_tags_second_level"
                                                               data-subj_type="user"
                                                               data-id="{$res.id}"
                                                               data-tag="{$data1.id}"
                                                               data-root="{$data.id}"
                                                               data-is_multi="{$data.is_multi}">
                                                        <span class="filter-form__label-title">{$data1.title}</span>
                                                    </label>
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="js_chg_element js_second_level"></div>
                        {/if}
                    {/foreach}
                </div>
            </div>
            <div class="content__block" id="tags">
                {* Теги кроме  "страна" ($data.id == 1) *}
                <h4 class="block__title">Теги<br></h4>
                <p>Вы можете выбрать любое количество тегов, стран и городов. В этом случае Вам будут приходить вопросы по конкретным регионам и тематикам</p>
                <div class="lk_tag_box">
                    {foreach from=$smarty_params.tags item=data}
                        {*{if $data.id !=-1}*}
                        <div class="lk_tag_box_two_colons"> {* Div для вывода страна-город в две колонки*}
                            <div class="js_chg_element">
                                <h4 class="tag_title_toggle js_tag_title_toggle">{$data.title}</h4>

                                <div class="tag_cloud">
                                    {foreach from=$data.inner key=key item=data1}
                                        {if $obj->check_tag_select($data1.id, 0)}
                                            <div class="tag_cloud_item checked">
                                                {$data1.title}
                                                <span class="js_delete_tag cross_small" data-id="{$data1.id}"
                                                      data-user="{$res.id}"></span>
                                            </div>
                                        {/if}
                                    {/foreach}
                                </div>

                                <div class="filter_js_anchor tag_title_anchor">
                                    <input type="text" placeholder="Найти"
                                           class="js_fast_filter_mark filter_checkbox_search_lk" value="">
                                    <div class="tag_cloud">
                                        {foreach from=$data.inner key=key item=data1}
                                            <div class="tag_cloud_item label {if $obj->check_tag_select($data1.id, 0)}checked{/if} js_add_tag"
                                                 data-id="{$data1.id}" data-user="{$res.id}">
                                                <span class="filter-form__label-title">{$data1.title}</span>
                                            </div>
                                        {/foreach}
                                        <div class="tag_cloud_item label gray">
                                            <a href="#popup__tag" class="filter-form__label-title open__popup_tag"
                                               data-id="{$data.id}">Предложить другой тег</a>
                                        </div>
                                    </div>
                                    {*<div {if count($data.inner) > 5}class="filter_content_lk"{/if}>
                                         {foreach from=$data.inner key=key item=data1}
                                             <div>
                                                 <label>
                                                     <input type="checkbox" {if $obj->check_tag_select($data1.id, 0)}checked="checked"{/if}
                                                            class="js_check_tags" data-id="{$res.id}"
                                                            data-tag="{$data1.id}"
                                                            data-root="{$data.id}" data-is_multi="{$data.is_multi}">
                                                     <span class="filter-form__label-title">{$data1.title}</span>
                                                 </label>
                                             </div>
                                         {/foreach}

                                     </div>*}
                                </div>

                            </div>
                        </div>
                        {* <div class="">

                               <!-- start селектора регионов-->
                               {if $data.id == 1}
                               <div class="lk_tag_box_two_colons">
                                   <div class="js_chg_element">
                                       <h4 class="tag_title_toggle js_tag_title_toggle">Регионы</h4>

                                       <div class="tag_cloud">
                                           {foreach from=$regions key=key item=reg}
                                               {if $obj->check_tag_select($reg.id, 0)}
                                                   <div class="tag_cloud_item checked">
                                                       {$reg.title}
                                                       <span class="js_delete_tag cross_small" data-id="{$reg.id}" data-user="{$res.id}"></span>
                                                   </div>
                                               {/if}
                                           {/foreach}
                                       </div>

                                       <div class="filter_js_anchor tag_title_anchor">
                                           <input type="text" placeholder="Найти"
                                                  class="js_fast_filter_mark filter_checkbox_search_lk" value="">
                                           <div class="tag_cloud">
                                               {foreach from=$regions key=key item=reg}
                                                   <div class="tag_cloud_item label {if $obj->check_tag_select($data1.id, 0)}checked{/if} js_add_tag" data-id="{$data1.id}" data-user="{$res.id}">
                                                       <span class="filter-form__label-title">{$data1.title}</span>
                                                   </div>
                                               {/foreach}
                                           </div>

                                       </div>
                                   </div>
                               </div>
                               {/if}<!-- end ---->


                            </div>*}
                        {*{/if}*}


                        {if $data.id ==1} {* К стране берем регионы*}
                            <div class="lk_tag_box_two_colons">
                                <div class="js_chg_element js_reg_tag_anchor">
                                    <h4 class="tag_title_toggle js_tag_title_toggle">Регион</h4>

                                    <div class="tag_cloud">
                                        {foreach from=$smarty_params.regions item=reg}
                                            {if $obj->check_tag_select($reg.id, 0)}
                                                <div class="tag_cloud_item checked">
                                                    {$reg.title}
                                                    <span class="js_delete_tag cross_small" data-id="{$reg.id}"
                                                          data-user="{$res.id}"></span>
                                                </div>
                                            {/if}
                                        {/foreach}
                                    </div>

                                    <div class="filter_js_anchor tag_title_anchor">
                                        <input type="text" placeholder="Найти"
                                               class="js_fast_filter_mark filter_checkbox_search_lk" value="">
                                        <div class="tag_cloud">
                                            {foreach from=$smarty_params.regions item=reg}
                                                <div class="tag_cloud_item label {if $obj->check_tag_select($reg.id, 0)}checked{/if} js_add_tag"
                                                     data-id="{$reg.id}" data-user="{$res.id}">
                                                    <span class="filter-form__label-title">{$reg.title}</span>
                                                </div>
                                            {/foreach}
                                            {if $smarty_params.regions}
                                                <div class="tag_cloud_item label gray">
                                                    <a href="#popup__tag"
                                                       class="filter-form__label-title open__popup_tag"
                                                       data-id="-1">Предложить другой тег</a>
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/if}

                    {/foreach}
                </div>
                {*  {if $smarty_params.role_GAK >= 4 || $res.status == 0}*}
            </div>
            <div class="content__block">
                <h4 class="block__title">Заполните информацию ниже, чтобы получить баллы и повысить свой рейтинг. (Не отражается на сайте)</h4>

                <div class="row__input">
                    <div class="input__item"><h4><label for="field_is_course_autoboss">Обучались ли Вы на курсах
                                Автобосса? Перечислите и укажите даты, если помните. Начислится от 10 до 200 баллов</label></h4>
                        <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_is_course_autoboss"
                                  data-field="f_is_course_autoboss" data-id="{$res.id}"
                                  rows="4">{$res.is_course_autoboss}</textarea>

                    </div>
                </div>
                <div class="row__input">
                    <div class="input__item"><h4><label for="field_is_course_other">Обучались ли Вы на курсах дистрибьютора, в специализированных учебных организациях и пр.? Перечислите и укажите даты, если помните. Загрузите свои сертификаты в поле в блоке выше, чтобы получить баллы. Начислится от 50 до 200 баллов</label></h4>
                        <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_is_course_other"
                                  data-field="f_is_course_other" data-id="{$res.id}" rows="4">{$res.is_course_other}</textarea>

                    </div>
                </div>
                <div class="row__input">
                    <div class="input__item"><h4><label for="field_is_speaker">Были ли Вы спикером на профессиональных
                                мероприятиях (конференциях,
                                вебинарах и пр.)?  Перечислите и укажите даты, если помните. Добавьте ссылки, чтобы получить баллы. Начислится от 10 до 200 баллов</label></h4>
                        <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_is_speaker"
                                  data-field="f_is_speaker" data-id="{$res.id}" rows="4">{$res.is_speaker}</textarea>

                    </div>
                </div>
                <div class="row__input">
                    <div class="input__item"><h4><label for="field_is_author">Являетесь ли Вы автором книг,
                                профессиональных статей, учебных курсов и
                                пр.?  Перечислите и укажите ссылки, если есть. Начислится от 50 до 1000 баллов</label></h4>
                        <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_is_author"
                                  data-field="f_is_author"
                                  data-id="{$res.id}" rows="4">{$res.is_author}</textarea></div>
                </div>

                {*{/if}*}
            </div>
            <div class="content__block">
                <h4 class="block__title">Технические параметры</h4>
                <div class="row__input">
                    <div class="input__item w2">
                        <h4>Режим видимости личной страницы на сайте </h4>
                        <select class="js_chg lk_select select" data-field="f_show_type" data-id="{$res.id}">
                            <option value="0" {if $res.show_type==0}selected="selected"{/if}>Для всех</option>
                            <option value="1" {if $res.show_type==1}selected="selected"{/if}>Для зарегистрированных
                            </option>
                        </select>
                    </div>
                    {if $smarty_params.role_GAK >= 4}
                    <div class="input__item w2">
                        <h4>Статус</h4>
                        <select class="js_chg lk_select select" data-field="f_status" data-id="{$res.id}">
                            <option value="-2" {if $res.status==-2}selected="selected"{/if}>Заблокирован</option>
                            <option value="-1" {if $res.status==-1}selected="selected"{/if}>Регистрация без
                                подтверждения
                                телефона
                            </option>
                            <option value="0" {if $res.status==0}selected="selected"{/if}>Регистрация с подтверждением
                                телефона
                            </option>
                            <option value="2" {if $res.status==2}selected="selected"{/if}>На модерации</option>
                            <option value="1" {if $res.status==1}selected="selected"{/if}>Активен</option>
                        </select>
                    </div>
                    {if $smarty_params.role_GAK >= 10}
                        <div class="input__item w2">
                            <h4>Роль (видно только разработчикам)</h4>
                            <select class="js_chg lk_select select" data-field="f_role_GAK" data-id="{$res.id}">
                                {foreach from=$smarty_params.GAK item=data}
                                    <option value="{$data.id}"
                                            {if $data.id == $res.role_GAK}selected="selected"{/if}>{$data.title}</option>
                                {/foreach}
                            </select>
                        </div>
                    {/if}
                    <div class="input__item w2">
                        <h4>Баллы</h4>
                        <input type="number" class="js_chg slyle_input" data-field="f_score" value="{$res.score}"
                               data-id="{$res.id}"/>
                    </div>
                </div>
                {*<h4>Экспертный статус </h4>
                <select class="js_chg lk_select" data-field="f_autoboss_status" data-id="{$res.id}">
                    <option value="0" {if $data.id==0}selected="selected"{/if}>Не выбрано</option>
                    {foreach from=$smarty_params.autoboss_status item=data}
                        <option value="{$data.id}"
                                {if $data.id==$res.autoboss_status}selected="selected"{/if}>{$data.title}</option>
                    {/foreach}
                </select>*}
                <h4></h4>
                <a class="account__button" href="/account/users/">Редактировать всех пользователей</a>
                <h4></h4>
                {/if}
            </div>
            <div class="moderation_block">
                {*{if $res.status == 0}
                    {if $res.mail_verification == 1 || $res.tel_verification == 1}
                        <a class="js_moderation_user account__button button button--orange" data-id="{$res.id}">Отправить на модерацию</a>
                    {else}
                        <a class="js_moderation_user account__button button button--orange hidden" data-id="{$res.id}">Отправить на модерацию</a>
                        <h4 class="js_moderate_user_err_msg block__title">Вы сможете отправить запрос на модерацию после того как <a href="#verificate"> подтвердите</a> или телефон или E-Mail!</h4>
                    {/if}
                {elseif $res.status == 2}
                    Запрос на модерацию отправлен
                {/if}*}

                {if $res.moderate == 0}
                    {if $res.mail_verification == 1 || $res.tel_verification == 1}
                        <a class="js_moderation_user account__button button button--orange" data-id="{$res.id}">Отправить на модерацию</a>
                    {else}
                        <a class="js_moderation_user account__button button button--orange hidden" data-id="{$res.id}">Отправить на модерацию</a>
                        <h4 class="js_moderate_user_err_msg block__title">Вы сможете отправить запрос на модерацию после того как <a href="#verificate"> подтвердите</a> или телефон или E-Mail!</h4>
                    {/if}
                {elseif $res.moderate == 1}
                    Запрос на модерацию отправлен
                {/if}
            </div>
            <div class="alerts"></div>
        {else}
            <h3>Доступ запрещен</h3>
        {/if}
    </div>
</main>
