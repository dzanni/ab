<div class="page-inner page-profile">
    {if $current_user->auth || !$user.show_type}
        <main>
            <div class="content__block profile__content">
                <div class="content__profile-img">
                        <a href="{$viewer->get_icon_by_user($user.id)}" data-fancybox>
                            <img src="{$viewer->get_icon_by_user($user.id)}"  alt=""> </a>
                </div>
                <div class="content__profile-info">
                    <h1 class="block__title">{$user.family_name} {$user.name} {if $user.father_name_show}{$user.father_name}{/if}</h1>

                    {$viewer->gen_share()}

                    <div class="block__label">

                        {if $user.score}
                            <div class="block__label-item">
                            <svg class="svg-sprite-icon icon-icon__star">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__star"></use>
                            </svg>
                            <p>баллов: {$user.score}</p>
                            </div>{/if}
                        {if $user.ab_status_txt}
                            <div class="block__label-item">
                            <svg class="svg-sprite-icon icon-icon__user">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__user"></use>
                            </svg>
                            <p>{$user.ab_status_txt}</p>
                            </div>{/if}
                    </div>
                    <div class="block__list-spec">
                        {if count($user.companies)}
                            <div class="block__list-item list__companies">
                                {foreach from=$user.companies item=company}
                                    <a class="list__companies-item-link" href="/firms/?firm={$company.id}">
                                        <div class="list__companies-item-photo"><img class="comp__user-img" src="{$viewer->get_icon_by_firm($company.id)}" alt="Axis"></div>
                                        <div class="list__companies-item-title">{$company.title}</div>
                                    </a>
                                {/foreach}
                            </div>
                        {elseif $user.job_place}
                            <div class="block__list-item">
                                <svg class="svg-sprite-icon icon-icon__users">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__users"></use>
                                </svg>
                                <p><strong>{$user.job_place}</strong></p>
                            </div>
                        {/if}
                        {if $user.job_title && $user.job_title_show}
                            <div class="block__list-item">
                            <svg class="svg-sprite-icon icon-icon__spec">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__spec"></use>
                            </svg>
                            <p>{$user.job_title}</p>
                            </div>{/if}
                        {if $user.region || $user.country}
                            <div class="block__list-item">
                            <svg class="svg-sprite-icon icon-icon__point">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__point"></use>
                            </svg>
                            <p>{$user.region}{if $user.region && $user.country}, {/if}{$user.country}</p>
                            </div>{/if}
                    </div>
                    {if $tags}
                        <div class="block__tags">
                            {foreach from=$tags item=data}
                                {if $data.title != ''} <a class="block__tags-link" href="/users/?tag={$data.id}">
                                    #{$data.title}</a>{/if}
                            {/foreach}
                        </div>
                    {/if}
                    {if $user.id != $current_user->id && $current_user->status == 1}
                        <a class="button button--orange" href="/account/messages/?user_to={$user.id}">Отправить
                            сообщение</a>
                    {/if}


                    {if $obj->checkUserForMyFirms($user.id)}
                        <div class="render_work_parent">
                            <br>
             
                                <a class="button button--orange js_render_work_button">Добавить в сотрудники</a>
                 
                            <div class="render_work firm hidden"><div class="render_popup-inner">

                                <div class="render_work-cross"><span
                                            class="cross_small_render js_render_work_button"></span></div>
<div class="render_popup-title">Добавить</div>
                                <div class="render_work-info">Пользователь {$user.name} {$user.family_name} отразится в
                                    списках выбранных компаний, если подтвердит запрос
                                </div>

                                {foreach from=$obj->checkUserForMyFirms($user.id) item=data}
                            
                                        <label class="d-f a-c">
                                            <input type="checkbox" name="is_my_worker"
                                                   {if isset($data.agree)}checked{/if} class="{*js_add_user_to_firm*}"
                                                   data-firm="{$data.id}" data-user="{$user.id}"><span
                                                    class="render_checkbox_title">{$data.title}</span>

                                            <span class="render_checkbox_alert">{if isset($data.agree)}{if $data.agree}- запрос подтвержден{else}- запрос отправлен{/if}{/if}</span>
                                        </label>
                             
                                {/foreach}
                  
                                <a class="js_add_all_users_to_firm account__button_render button button--orange js_render_work_button">Сохранить</a>
                            </div>
                            <div class="alert"></div>
                        </div></div>
                    {/if}

                    {if $user.can_edit}
                        <br>
                        <div class="render_work_button">
                            <a class="button button--orange js_render_work_button" href="/account/users/?lk_users_edit_profile={$user.id}">Редактировать</a>
                        </div>
                    {/if}

                </div>
            </div>

            {if $user.job}
                <div class="content__block">
                    <div class="block__title">Опыт работы в автобизнесе</div>
                    {foreach from=$user.job item=data}
                        <div class="block__content">
                            <div class="block__list-exp">
                                <div class="block__item">{*<img class="block__item-img" src="/i/v2/content/exp__logo.png" alt="">*}
                                    <div class="block__item-info">
                                        <div class="block__item-title">{$data.job_title}</div>
                                        <div class="block__item-brand">{$data.firm_title}</div>
                                        <div class="block__item-worktime">{$data.date_start}
                                            - {if $data.till_now}настоящее время{else}{$data.date_end}{/if}
                                            · {$data.period}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br>
                    {/foreach}
                </div>
            {/if}

            {if $user.education_txt}
                <div class="content__block">
                    <div class="block__title">Образование</div>
                    <div class="block__content list__star">
                        {$user.education_txt}
                    </div>
                </div>
            {/if}

            {if $user.success_txt}
                <div class="content__block">
                <div class="block__title">Достижения в автобизнесе</div>
                <div class="block__content list__star">
                    {$user.success_txt}
                </div>
                </div>
            {/if}
            {if $user.cv}
                <div class="content__block">
                <div class="block__title">Резюме</div>
                <div class="block__content">
                    <p>Нажмите, чтобы ознакомиться с резюме.</p>
                    <a class="button" href="/images/cv/cv{$user.id}.pdf" data-fancybox>Посмотреть</a>
                </div>
                </div>{/if}
            {if $user.is_duty_txt}
                <div class="content__block">
                <div class="block__title">Чем я могу быть полезен сообществу</div>
                <div class="block__content">
                    {$user.is_duty_txt}
                </div>
                </div>{/if}
            {if $user.about ||    $user.birthday_show ||    $user.region_show ||    $user.login_show ||    $user.tel_show}
                <div class="content__block">
                    <div class="block__title">Общие сведения</div>
                    <div class="block__content">
                        <p>{$user.about_txt}</p>
                        <div class="block__list-data">
                            {if $user.birthday_show && $user.birthday}
                                <div class="block__item">
                                <div class="block__item-inner">
                                    <svg class="svg-sprite-icon icon-icon__day">
                                        <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__day"></use>
                                    </svg>
                                    <div class="block__item-info">
                                        <div class="block__item-label">Дата рождения:</div>
                                        <div class="block__item-value">{$user.birthday}</div>
                                    </div>
                                </div>
                                </div>{/if}
                            {if $user.region_show && $user.region}
                                <div class="block__item">
                                <div class="block__item-inner">
                                    <svg class="svg-sprite-icon icon-icon__point">
                                        <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__point"></use>
                                    </svg>
                                    <div class="block__item-info">
                                        <div class="block__item-label">Местоположение:</div>
                                        <div class="block__item-value">{$user.region}</div>
                                    </div>
                                </div>
                                </div>{/if}
                            {if $user.login_show && $user.login}
                                <div class="block__item">
                                <div class="block__item-inner">
                                    <svg class="svg-sprite-icon icon-icon__mail">
                                        <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__mail"></use>
                                    </svg>
                                    <div class="block__item-info">
                                        <div class="block__item-label">Email:</div>
                                        <div class="block__item-value">{$user.login}</div>
                                    </div>
                                </div>
                                </div>{/if}
                            {if $user.tel_show && $user.tel}
                                <div class="block__item">
                                <div class="block__item-inner">
                                    <svg class="svg-sprite-icon icon-icon__phone">
                                        <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__phone"></use>
                                    </svg>
                                    <div class="block__item-info">
                                        <div class="block__item-label">Телефон:</div>
                                        <div class="block__item-value">{$user.tel}</div>
                                    </div>
                                </div>
                                </div>{/if}
                        </div>
                    </div>
                </div>
            {/if}




        </main>
        {if $user.honor || $user.sertificat}
            <aside>
            {if $user.honor}
                <div class="content__block profile__awards">
                    <div class="block__title">Награды</div>
                    <div class="block__content">
                        <div class="block__list-awards">
                            {foreach from=$user.honor item=data}
                                <div class="block__item">
                                    {if $data.type == 1}
                                        <svg class="svg-sprite-icon icon-icon__sert-gold">
                                            <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__sert-gold"></use>
                                        </svg>
                                    {/if}
                                    {if $data.type == 2}
                                        <svg class="svg-sprite-icon icon-icon__sert-silver">
                                            <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__sert-silver"></use>
                                        </svg>
                                    {/if}
                                    {if $data.type == 3}
                                        <svg class="svg-sprite-icon icon-icon__sert-bronze">
                                            <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__sert-bronze"></use>
                                        </svg>
                                    {/if}
                                    {if $data.type == 4}
                                        <svg class="svg-sprite-icon icon-icon__sert-user">
                                            <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__sert-user"></use>
                                        </svg>
                                    {/if}
                                    {if $data.type == 5}
                                        <svg class="svg-sprite-icon icon-icon__spiker">
                                            <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__spiker"></use>
                                        </svg>
                                    {/if}
                                    {if $data.type == 6}
                                        <svg class="svg-sprite-icon icon-icon__author-curs">
                                            <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__author-curs"></use>
                                        </svg>
                                    {/if}
                                    {if $data.type == 7}
                                        <svg class="svg-sprite-icon icon-icon__author-master">
                                            <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__author-master"></use>
                                        </svg>
                                    {/if}
                                    {if $data.type == 8}
                                        <svg class="svg-sprite-icon icon-icon__author-master">
                                            <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__author-master"></use>
                                        </svg>
                                    {/if}
                                    {if $data.type == 9}
                                        <svg class="svg-sprite-icon icon-icon__author-metod">
                                            <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__author-metod"></use>
                                        </svg>
                                    {/if}
                                    <div class="block__item-info">
                                        <div class="block__item-title">{$data.title}</div>
                                        <!--div class="block__item-date">24 мая 2022</div-->
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                        {* если сертификатов более 2
                        <div class="block__hidden">
                            <div class="block__list-awards">

                            </div>
                        </div><a class="block__more" href="#"> </a>
                        *}
                    </div>
                </div>
            {/if}
            {if $user.sertificat}
                <div class="content__block">
                    <div class="block__title">Сертификаты</div>
                    <div class="block__content">
                        <div class="block__list-sert">
                            {foreach from=$user.sertificat key=key item=data}
                                <div class="block__item">
                                    <div class="block__item-img">
                                        <a href="/files/{$data.filename}" style="text-decoration: underline" data-fancybox>
                                            <img src="/img.php?filename=/files/{$data.filename}&width=64" alt="">
                                        </a>
                                    </div>
                                    <div class="block__item-info">
                                        {if $data.title}
                                            <div class="block__item-title">{$data.title}</div>{else}
                                            <div class="block__item-title">Без названия</div>
                                        {/if}
                                        {if $data.description}
                                            <div class="block__item-desc">{$data.description}</div>{/if}
                                        {if $data.date}
                                            <div class="block__item-date">{$data.date}</div>{/if}
                                        <a class="button" href="/files/{$data.filename}" data-fancybox>Показать</a>
                                    </div>
                                </div>
                                <br>
                            {/foreach}
                        </div>
                        {* если сертификатов более 2
                        <div class="block__hidden">
                            <div class="block__list-sert">
                                <div class="block__item">
                                    <div class="block__item-img"><img src="static/images/content/sert_min.jpg" alt=""></div>
                                    <div class="block__item-info">
                                        <div class="block__item-title">Золотой сертификат по курсу Директор по маркетингу</div>
                                        <div class="block__item-desc">Автобосс</div>
                                        <div class="block__item-date">24 мая 2022</div><a class="button" href="static/images/content/sert.jpg" data-fancybox>Показать</a>
                                    </div>
                                </div>
                                <div class="block__item">
                                    <div class="block__item-img"><img src="static/images/content/sert_min.jpg" alt=""></div>
                                    <div class="block__item-info">
                                        <div class="block__item-title">Золотой сертификат по курсу Директор по маркетингу</div>
                                        <div class="block__item-desc">Автобосс</div>
                                        <div class="block__item-date">24 мая 2022</div><a class="button" href="static/images/content/sert.jpg" data-fancybox>Показать</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a class="block__more" href="#"> </a>
                        *}
                    </div>
                </div>
            {/if}
            </aside>{/if}
    {else}
        <div>Этот пользователь виден только зарегистрированным пользователям.&nbsp;
            <a href="/account/">Войдите</a>&nbsp;или&nbsp;<a href="/account/?lk_reg">зарегистрируйтесь.</a>
        </div>
    {/if}
</div>
<!--

<section class="user_card">
    <div class="container-fluid">
        <div class="user_card_full">


            {if $current_user->auth || !$user.show_type}
                <div class="user_card_left">

                    <h1>{$user.family_name} {$user.name} {if $user.father_name_show}{$user.father_name}{/if} </h1>

                    <h2 style="padding-bottom: 10px;"><span
                                class="autoboss_status">{if $user.autoboss_status}{$user.autoboss_status}{/if}{if $user.score} {$user.score} баллов{/if}</span>
                    </h2>

                    <div class="user_card_foto_inner">
                        <img style="max-width: 100%;" alt="{$user.name} {$user.family_name}"
                             src="/images/u/{if $user.foto}{$user.id}.jpg{else}incognito.svg{/if}">
                        {if $user.score}
                            <div class="user_card_item">
                                <div class="user_card_item_title">
                                    Рейтинг: {$user.score}
                                </div>
                            </div>
                        {/if}
                    </div>

                    {if $user.honor}
                        <div class="user_card_item">
                            <div class="user_card_item_title">
                                Награды
                            </div>
                            {foreach from=$user.honor item=data}
                                <div class="user_card_item_text">
                                    {$data.title}
                                </div>
                            {/foreach}

                        </div>
                    {/if}

                    {if $user.job_title_show}
                        <div class="job_title">{$user.job_title}</div>
                    {/if}
                    <br>
                    {if $tags}
                        <div class="tags">
                            {foreach from=$tags item=data}
                            {if $data.title != ''} <a href="/users/?tag={$data.id}">#{$data.title}{/if}
                                {/foreach}

                        </div>
                    {/if}

                    <div class="job_place">{$user.job_place}</div>

                    {if $user.login_show}
                        <div class="user_card_contact">
                            <div class="user_card_item_text">
                                <img src="/i/icon__mail.svg" class="user_card_item_img">
                                <a href="mailto:{$user.login}">{$user.login}</a>
                            </div>
                        </div>
                    {/if}
                    {if $user.tel_show}
                        <div class="user_card_contact">
                            <div class="user_card_item_text">
                                <img src="/i/icon__phone.svg" class="user_card_item_img">
                                <a href="tel:{$user.tel}">{$user.tel}</a>
                            </div>
                        </div>
                    {/if}
                    <br>
                    {if $user.birthday_show}
                        <div class="user_card_birthday">
                            Дата рождения:
                            {$user.birthday}
                        </div>
                    {/if}
                    {if $user.country_show}
                        <div class="user_card_birthday">
                            Страна: {$user.country}
                        </div>
                    {/if}
                    {if $user.region_show}
                        <div class="user_card_birthday">
                            Регион: {$user.region}

                        </div>
                    {/if}

                    <br><br>

                    <div class="user_card_item">
                        <div class="user_card_item_title">
                            Образование
                        </div>
                        <div class="user_card_item_text">
                            {$user.education}
                        </div>
                    </div>
                    <div class="user_card_item">
                        <div class="user_card_item_title">
                            Достижения в автобизнесе
                        </div>
                        <div class="user_card_item_text">
                            {$user.success}
                        </div>
                    </div>
                    <div class="user_card_item">
                        <div class="user_card_item_title">
                            Чем я могу быть полезен сообществу
                        </div>
                        <div class="user_card_item_text">
                            {$user.is_duty}
                        </div>
                    </div>
                    <div class="user_card_item">
                        <div class="user_card_item_title">
                            О себе
                        </div>
                        <div class="user_card_item_text">
                            {$user.about}
                        </div>
                    </div>

                    {if $user.cv}
                        <div class="user_card_item">
                            <div class="user_card_item_title">
                                Резюме
                            </div>
                            <div class="user_card_item_text">
                                <a class="underline" href="/images/cv/cv{$user.id}.pdf" target="_blank">Скачать
                                    резюме</a>
                            </div>
                        </div>
                    {/if}


                    {if $user.sertificat}
                        <div class="user_card_item">
                            <div class="user_card_item_title">
                                Сертификаты
                            </div>
                            {foreach from=$user.sertificat key=key item=data}
                                <div class="user_card_item_text">
                                    <a href="/files/{$data.filename}" style="text-decoration: underline">{$key+1}
                                        . {if $data.title}{$data.title}{else}Без названия{/if}<br></a>
                                    {if $data.description}Описание: {$data.description}<br>{/if}
                                    {if $data.date != 0}Дата получения: {$data.date}<br>{/if}
                                </div>
                                <br>
                            {/foreach}
                        </div>
                    {/if}


                    <br>


                    {*

												{foreach from=$user key=key item=data}
														<div class="user_card_item">
														{$key}:<br>
																{$data}
														</div>
												{/foreach}

                    *}
                  {if $user.id != $current_user->id}
                        <a href="/account/messages/?user_to={$user.id}" class="account__button_render black">Отправить
                            сообщение</a>
                        <br>
                        <br>
                    {/if}

                    {if $obj->checkUserForMyFirms($user.id)}
                        <div class="render_work_parent">
                            <div class="render_work_button">
                                <a class="account__button_render js_render_work_button">Добавить в сотрудники</a>
                            </div>
                            <div class="render_work hidden">

                                <div class="render_work-cross"><span
                                            class="cross_small_render js_render_work_button"></span></div>

                                <div class="render_work-info">Пользователь {$user.name} {$user.family_name} отразится в
                                    списках выбранных компаний, если подтвердит запрос
                                </div>

                                {foreach from=$obj->checkUserForMyFirms($user.id) item=data}
                                    <div>
                                        <label>
                                            <input type="checkbox" name="is_my_worker"
                                                   {if isset($data.agree)}checked{/if} class="{*js_add_user_to_firm*}"
                                                   data-firm="{$data.id}" data-user="{$user.id}"><span
                                                    class="render_checkbox_title">{$data.title}</span>

                                            <span class="render_checkbox_alert">{if isset($data.agree)}{if $data.agree}- запрос подтвержден{else}- запрос отправлен{/if}{/if}</span>
                                        </label>
                                    </div>
                                {/foreach}
                                <br>
                                <a class="js_add_all_users_to_firm account__button_render">Сохранить</a>
                            </div>
                            <div class="alert"></div>
                        </div>
                    {/if}


                </div>
                <div class="user_card_right">
                    <img style="max-width: 100%;" alt="{$user.name} {$user.family_name}"
                         src="/images/u/{if $user.foto}{$user.id}.jpg{else}incognito.svg{/if}">
                    {if $user.score}
                        {*<div class="user_card_item">
                            <div class="user_card_item_title">
                                Рейтинг: {$user.score} баллов
                            </div>
                        </div>*}
                    {/if}

                </div>
            {else}
                <div>Этот пользователь виден только зарегистрированным пользователям.&nbsp;
                    <a href="/account/">Войдите</a>&nbsp;или&nbsp;<a href="/account/?lk_reg">зарегистрируйтесь.</a>
                </div>
            {/if}
        </div>
    </div>
</section>

-->