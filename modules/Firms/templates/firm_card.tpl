<div class="page-inner page-comp03">
    <aside>
        {include file='../../../templates/left.tpl'}
    </aside>
    <main>

        {if $menu}
            <div class="content__block">
                <div class="content__block_firm_menu">
                    <a href="/firms/?firm={$firm.id}" class="button button--orange">Главная</a>
                    {foreach from=$menu item=m}
                        <a href="/firms/?firm={$firm.id}&firmpage={$m.id}" class="button button--orange">{$m.title}</a>
                    {/foreach}
                </div>
            </div>
        {/if}

        <div class="content__block comp__content">
            <a class="content__comp-img" href="/firms/?firm={$firm.id}"><img src="{$viewer->get_icon_by_firm($firm.id)}" alt="{$firm.title}"></a>
            <div class="content__comp-info">
                <div class="comp__info">
                    <div class="block__title">{$firm.title}
                        {if $firm.moderate == 2}
                            <div class="block__confirmed">
                                <img src="/i/build/content/svg/icon_check_03.svg" alt="">
                                <div class="block-confirmed__popup">Профиль компании подтвержден</div>
                            </div>
                        {/if}
                    </div>

                    <div class="comp__item-rating">
                            {*{if $obj->get_col_rating()}*}
                            <div class="comp__item-rating-count">{$firm.rating}</div>
                            <div class="comp__item-rating-stars js_reviews">
                                <div class="comp__item-rating-stars active"
                                     style="width: width: {$firm.rating_persent}%">
                                    {if $obj->get_col_rating()}
                                    {for $i=1 to $firm.rating|ceil}
                                    <img src="/i/build/content/svg/icon_star-full_03.svg" alt="">
                                    {/for}
                                    {/if}
                                </div>
                                <img src="/i/build/content/svg/icon_star_03.svg" alt="">
                                <img src="/i/build/content/svg/icon_star_03.svg" alt="">
                                <img src="/i/build/content/svg/icon_star_03.svg" alt="">
                                <img src="/i/build/content/svg/icon_star_03.svg" alt="">
                                <img src="/i/build/content/svg/icon_star_03.svg" alt="">
                            </div>
                            <div class="comp__item-rating-reviews">({$obj->get_col_rating()})</div>
                            {*{/if}*}
                        </div>

                </div>
                <div class="comp__button">

                    <a class="comp-button__link js_share">Поделиться<img class="svg" src="/i/build/content/svg/icon_share_03.svg" alt=""></a>
                    <a class="comp-button__link js_open_test_alert">Связаться</a>
                    <a class="comp-button__link js_open_test_alert">Я клиент</a>

                    {if $current_user->auth && $current_user->status == 1}
                        {assign var="personal" value=$obj->checkPersonalRight($firm.id)}
                        {assign var="rating" value=$personal.rating}

                        {*<a class="comp-button__link js_reviews">Оставить отзыв</a>*}

                        <div class="comp-button__link_wrap">
                        <a class="comp-button__link closed js_firm_other_action">Другие действия</a>
                            <div class="comp-button__link_inner">

                                {if $firm.can_be_a_worker == 1}
                                    <a class="comp-button__link_item js_send_request_for_sotrudnik" data-id="{$firm.id}">Я
                                        сотрудник</a>
                                    <div class="js_send_request_for_sotrudnik_result txt-center"></div>
                                {elseif $firm.can_be_a_worker == -1}
                                    <span class="comp-button__link_item">
                                        Ваш запрос в сотрудники пока не одобрен компанией, ожидайте</span>
                                {elseif $firm.can_be_a_worker == -2}
                                    <a class="comp-button__link_item js_send_request_for_sotrudnik" data-id="{$firm.id}">Подтвердить, что я сотрудник компании</a>
                                    <div class="js_send_request_for_sotrudnik_result txt-center"></div>
                                {/if}


                                <!-- Старый дизайн --->

                                {if $obj->checkClientForMyFirms($firm.id)}
                                    <div class="render_work_parent">
                                        <a class="comp-button__link_item comp-button__link_parent js_render_work_button">Добавить в клиенты</a>
                                        <div class="render_work firm hidden">

                                            <div class="render_popup-inner">
                                                <div class="render_work-cross"><span
                                                            class="cross_small_render js_render_work_button"></span></div>
                                                <div class="render_popup-title">Добавить</div>


                                                <div class="render_work-info">Клиент {$firm.title} отразится в списках клиентов
                                                    выбранных компаний,
                                                    если подтвердит запрос
                                                </div>

                                                {foreach from=$obj->checkClientForMyFirms($firm.id) item=data}
                                                    <div>
                                                        <label class="d-f a-c j-s">
                                                            <input type="checkbox" name="is_my_client"
                                                                   {if isset($data.agree)}checked{/if}
                                                                   data-firm="{$data.id}" data-client="{$firm.id}"><span
                                                                    class="render_checkbox_title">{$data.title}</span>

                                                            <span class="render_checkbox_alert">{if isset($data.agree)}{if $data.agree}- запрос подтвержден пользователем{else}- запрос отправлен{/if}{/if}</span>
                                                        </label>
                                                    </div>
                                                {/foreach}

                                                <a class="js_add_all_clients_to_firm account__button_render button button--orange">Сохранить</a>
                                            </div>
                                            <div class="alert"></div>
                                        </div>
                                    </div>
                                {/if}

                                {if count($firm.workers) == 0}
                                    <div class="render_work_parent comp-button__link_parent">
                                        <a class="comp-button__link_item js_send_request_for_brand" data-id="{$firm.id}">Запросить
                                            управление компанией</a>
                                        <div class="js_send_request_for_brand_result"></div>
                                    </div>
                                {/if}
                                <!-- Конец старого дизайна -->


                                {if $firm.can_edit}
                                    <a class="comp-button__link_item" href="/account/brands/?lk_brands_edit_profile={$firm.id}">Редактировать</a>

                                {/if}

                            </div>
                        </div>
                    {/if}
                </div>

            </div>
        </div>

        <div class="content__block js_test_alert_anchor hidden">
            <div class="render_work-cross">
                <span class="cross_small_render js_open_test_alert"></span>
            </div>
            <span style="color:red">Я всплывающее окно, у меня нет функционала. Закрой меня.</span>
        </div>

        <div class="content__block js_share_alert_anchor hidden">
            <div class="render_work-cross">
                <span class="cross_small_render js_open_share_alert"></span>
            </div>
            {$viewer->gen_share('', true)}
        </div>

        <!-- Панель кнопок, которым пока нет нового дизайна -->

        {*{if $current_user->auth && $current_user->status == 1}*}
            {*<div class="content__block comp__content">*}
                {*<div class="content__comp-info">*}
                    {*<div class="comp__info" style="color:red">Нет в новом дизайне</div>*}
                    {*<div class="comp__button">*}
                        {*{if $obj->checkClientForMyFirms($firm.id)}*}
                            {*<div class="render_work_parent">*}
                                {*<a class="comp-button__link js_render_work_button">Добавить в клиенты</a>*}
                                {*<div class="render_work firm hidden">*}

                                    {*<div class="render_popup-inner">*}
                                        {*<div class="render_work-cross"><span*}
                                                    {*class="cross_small_render js_render_work_button"></span></div>*}
                                        {*<div class="render_popup-title">Добавить</div>*}


                                        {*<div class="render_work-info">Клиент {$firm.title} отразится в списках клиентов*}
                                            {*выбранных компаний,*}
                                            {*если подтвердит запрос*}
                                        {*</div>*}

                                        {*{foreach from=$obj->checkClientForMyFirms($firm.id) item=data}*}
                                            {*<div>*}
                                                {*<label class="d-f a-c j-s">*}
                                                    {*<input type="checkbox" name="is_my_client"*}
                                                           {*{if isset($data.agree)}checked{/if}*}
                                                           {*data-firm="{$data.id}" data-client="{$firm.id}"><span*}
                                                            {*class="render_checkbox_title">{$data.title}</span>*}

                                                    {*<span class="render_checkbox_alert">{if isset($data.agree)}{if $data.agree}- запрос подтвержден пользователем{else}- запрос отправлен{/if}{/if}</span>*}
                                                {*</label>*}
                                            {*</div>*}
                                        {*{/foreach}*}

                                        {*<a class="js_add_all_clients_to_firm account__button_render button button--orange">Сохранить</a>*}
                                    {*</div>*}
                                    {*<div class="alert"></div>*}
                                {*</div>*}
                            {*</div>*}
                        {*{/if}*}

                        {*{if count($firm.workers) == 0}*}
                            {*<div class="render_work_parent">*}
                                {*<a class="comp-button__link js_send_request_for_brand" data-id="{$firm.id}">Запросить*}
                                    {*управление компанией</a>*}
                                {*<div class="js_send_request_for_brand_result"></div>*}
                            {*</div>*}
                        {*{/if}*}
                    {*</div>*}
                {*</div>*}
            {*</div>*}
        {*{/if}*}

        {if $firm.email || $firm.phone || $firm.address || $firm.site || $firm.docs}
        <div class="comp__column">
            <div class="comp__block">
        {/if}

                {if $firm.description_txt}
                    <div class="content__block">
                        <div class="block__title">Что мы делаем</div>
                        <div class="block__content">
                            {$firm.description_txt}
                        </div>
                    </div>
                {/if}

                {if $tags}
                    <div class="content__block">
                        <div class="block__title">Теги</div>
                        <div class="block__content">
                            <div class="tags__list">
                                {foreach from=$tags item=data}
                                    {if $data.title != ''} <a href="/firms/?tag={$data.id}"
                                                              class="tags__link">{$data.title}</a>{/if}
                                {/foreach}
                            </div>
                        </div>
                    </div>
                {/if}

                {foreach from=$APP->content->html item=d}
                    {$d}
                {/foreach}

                {if $firm.workers}
                <div class="content__block">
                    <div class="block__title">Наши сотрудники</div>
                    <div class="block__content">
                        <div class="comp__users-list block__hidden">
                            {foreach from=$firm.workers key=key item=data}
                                <div class="comp__users-item {if $key > 2}to_hide hidden{/if}">
                                    <a class="comp__user-photo" href="/users/?user={$data.id}">
                                        <img class="comp__user-img" src="{$viewer->get_icon_by_user($data.id)}" alt="{$data.family_name} {$data.name}">
                                    </a>
                                    <div class="comp__user-info">
                                        <a class="comp__user-title" href="/users/?user={$data.id}">{$data.family_name} {$data.name}</a>
                                        <div class="comp__user-spec">{$data.job_title}</div>
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                        {if count($firm.workers) > 3}
                            <a class="show__all js_show_all" data-msg="Показать всех сотрудников">Показать всех
                                сотрудников</a>
                        {/if}
                    </div>
                </div>
                {/if}

                {if $firm.clients}
                    <div class="content__block">
                        <div class="block__title">Клиенты</div>
                        <div class="block__content">
                            <div class="clients__list block__hidden">
                                {foreach from=$firm.clients key=key item=data}
                                    <a class="clients__link {if $key > 2}to_hide hidden{/if}"
                                       href="/firms/?firm={$data.id}">
                                        <div class="clients__img">
                                            <img src="{$viewer->get_icon_by_firm($data.id)}" alt="">
                                        </div>
                                        <span class="client__title">{$data.title}</span>
                                    </a>
                                {/foreach}
                            </div>
                            {if count($firm.clients) > 3}
                                <a class="show__all js_show_all" data-msg="Показать всех клиентов">Показать всех
                                    клиентов</a>
                            {/if}
                        </div>
                    </div>
                {/if}
            {if $firm.email || $firm.phone || $firm.address || $firm.site || $firm.docs}
            </div>
            <div class="comp__contacts">
                <div class="content__block">
                    <div class="block__title">Контакты</div>
                    {assign var="a" value=$firm.tarif}
                        <div class="comp-contacts__list">
                        {if $firm.email}
                            <div class="comp-contacts__title">Почта</div>
                            <div class="comp-contacts__value">
                                {if ($firm.email|is_array)}
                                    {if $a}
                                        {foreach from=$firm.email item=data}
                                            <div class="comp-contacts__value_inner">
                                                <a href="mailto:{$data}">{$data}</a>
                                            </div>
                                        {/foreach}
                                    {else}
                                        {$firm.email.0}
                                    {/if}
                                {else}
                                    {if $a}
                                        <a href="mailto:{$firm.email}">{$firm.email}</a>
                                    {else}
                                        {$firm.email}
                                    {/if}
                                {/if}
                            </div>
                        {/if}
                        {if $firm.phone}
                            <div class="comp-contacts__title">Телефон{if (count($firm.phone)>1) && $a}ы{/if}</div>
                            <div class="comp-contacts__value">
                                {if ($firm.phone|is_array)}
                                    {if $a}
                                        {foreach from=$firm.phone item=data}
                                            <div class="comp-contacts__value_inner">
                                                <a href="tel:{$data}">{$data}</a>
                                            </div>
                                        {/foreach}
                                    {else}
                                        {$firm.phone.0}
                                    {/if}
                                {else}
                                    {if $a}
                                        <a href="tel:{$firm.phone}">{$firm.phone}</a>
                                    {else}
                                        {$firm.phone}
                                    {/if}
                                {/if}
                            </div>
                        {/if}
                        {if $firm.address}
                            <div class="comp-contacts__title">Адрес{if count($firm.address)>1}а{/if}</div>
                            <div class="comp-contacts__value">
                                {if ($firm.address|is_array)}
                                    {foreach from=$firm.address item=data}
                                        <div class="comp-contacts__value_inner">
                                            {$data}
                                        </div>
                                    {/foreach}
                                {else}
                                    {$firm.address}
                                {/if}
                            </div>
                        {/if}
                        {if $firm.site.0}
                            <div class="comp-contacts__title">Сайт{if (count($firm.site.0)>1) && $a}ы{/if}</div>
                            <div class="comp-contacts__value">
                                {if $a}
                                    {foreach from=$firm.site.0 item=data}
                                        <div class="comp-contacts__value_inner">
                                            <a href="{$data.URL}"
                                        target="_blank">{if $data.title}{$data.title}{else}{$data.URL}{/if}
                                            </a>
                                        </div>
                                    {/foreach}
                                {else}
                                    {$firm.site.0.0.URL}
                                {/if}
                            </div>
                        {/if}
                        {if $firm.site.1 && $a}
                            <div class="comp-contacts__title">Другие ссылки</div>
                            <div class="comp-contacts__value">
                                {foreach from=$firm.site.0 item=data}
                                    <div class="comp-contacts__value_inner">
                                        <a href="{$data.URL}"
                                            target="_blank">{if $data.title}{$data.title}{else}{$data.URL}{/if}</a>
                                    </div>
                                {/foreach}
                            </div>
                        {/if}

                    </div>
                </div>

                {if $firm.docs}
                <div class="content__block">
                    <div class="block__title">Документы</div>
                    <div class="documents__list block__hidden">
                        {foreach from=$firm.docs key=key item=data}
                            <div class="documents__item {if $key > 2}to_hide hidden{/if}">
                                <div class="documents__img"><img class="svg" src="/i/build/content/svg/icon_document_03.svg" alt=""></div>
                                <div class="documents__desc">
                                    <div class="documents__title">{if $data.title}{$data.title}{else}Без названия{/if}</div>
                                    {if $data.date}
                                    <div class="documents__date">{$data.date}</div>
                                    {/if}
                                    <a class="documents__link" href="/files/docs/{$data.filename}" target="_blank">Открыть</a>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                    {if count($firm.docs) > 3}
                        <a class="show__all js_show_all" data-msg="Показать все документы">Показать все документы</a>
                    {/if}
                </div>
                {/if}
            </div>
            {/if}
        {if $firm.email || $firm.phone || $firm.address || $firm.site || $firm.docs}
        </div>
        {/if}
<br>
        <div class="page-inner page-comp">
            <main>
                <div class="js_remark_anchor">
                    {$remarks}
                </div>
            </main>
        </div>

    </main>
</div>

<div class="popup" id="share"> <a class="popup__close"><img src="/i/build/content/svg/icon_close_03.svg" alt=""></a>
    <div class="popup__desc">
        <div class="popup__title">Выберите, где хотите поделиться</div><script src="https://yastatic.net/share2/share.js"></script><div class="ya-share2" data-title="Привет! Я уже участник профессиональной сети экспертов автобизнеса АвтоБосс. Эксперт. Жду тебя здесь!" data-curtain data-size="m" data-shape="round" data-limit="8" data-services="vkontakte,odnoklassniki,telegram,viber,whatsapp" data-url="https://expert.a-boss.ru/firms/?firm={$firm.id}&u_from={$current_user->id}"></div>
    </div>
</div>

<div class="popup render_work" id="reviews" data-firm="{$firm.id}">
    <a class="popup__close"><img src="/i/build/content/svg/icon_close_03.svg" alt=""></a>
    <div class="popup__desc">
        <div class="popup__title">Отзыв о компании</div>
        {assign var="checkRatingAndRemarkRight" value=$obj->checkRatingAndRemarkRight($firm.id)}
        {if !$checkRatingAndRemarkRight}
            <input type="hidden" class="js_firm_title_select" name="firm_title_select"
                   value="0">
        {else}
            <select class="select js_firm_title_select" name="firm_title_select">
                <option value=0>От себя</option>
                {foreach from=$checkRatingAndRemarkRight item=data}
                    <option value="{$data.id}">{$data.title}</option>
                {/foreach}
            </select>
        {/if}
        <div class="form__reviews">
            <div class="reviews-rating__stars">
                <br>
                <div class="reviews-stars__title">Поставьте оценку</div>

                <div class="rating-area" data-client="0">
                    {*<div class="render_work_title">От себя</div>*}
                    <div class="reviews-stars__block">
                        <input class="js_change_rating" type="radio" name="rating" value="5" {if $rating > 4 && $rating <= 5}checked{/if} id="star-5" >
                        <label class="reviews-rating__star" for="star-5"></label>
                        <input class="js_change_rating" type="radio" name="rating" value="4" {if $rating > 3 && $rating <= 4}checked{/if} id="star-4" >
                        <label class="reviews-rating__star" for="star-4"></label>
                        <input class="js_change_rating" type="radio" name="rating" value="3" {if $rating > 2 && $rating <= 3}checked{/if} id="star-3" >
                        <label class="reviews-rating__star" for="star-3"></label>
                        <input class="js_change_rating" type="radio" name="rating" value="2" {if $rating > 1 && $rating <= 2}checked{/if} id="star-2" >
                        <label class="reviews-rating__star" for="star-2"></label>
                        <input class="js_change_rating" type="radio" name="rating" value="1" {if $rating > 0 && $rating <= 1}checked{/if} id="star-1" >
                        <label class="reviews-rating__star" for="star-1"></label>
                    </div>
                </div>

                {foreach from=$obj->checkRatingAndRemarkRight($firm.id) key=key item=data}
                <div class="rating-area hidden" data-client="{$data.id}">
                    {*<div class="render_work_title">{$data.title}</div>*}
                    <div class="reviews-stars__block">
                        <input class="js_change_rating" type="radio" name="rating_{$key}" value="5" id="star-5_{$key}" {if $data.rating > 4 && $data.rating <= 5}checked{/if}>
                        <label class="reviews-rating__star" for="star-5_{$key}"></label>
                        <input class="js_change_rating" type="radio" name="rating_{$key}" value="4" id="star-4_{$key}" {if $data.rating > 3 && $data.rating <= 4}checked{/if}>
                        <label class="reviews-rating__star" for="star-4_{$key}"></label>
                        <input class="js_change_rating" type="radio" name="rating_{$key}" value="3" id="star-3_{$key}" {if $data.rating > 2 && $data.rating <= 3}checked{/if}>
                        <label class="reviews-rating__star" for="star-3_{$key}"></label>
                        <input class="js_change_rating" type="radio" name="rating_{$key}" value="2" id="star-2_{$key}" {if $data.rating > 1 && $data.rating <= 2}checked{/if}>
                        <label class="reviews-rating__star" for="star-2_{$key}"></label>
                        <input class="js_change_rating" type="radio" name="rating_{$key}" value="1" id="star-1_{$key}" {if $data.rating > 0 && $data.rating <= 1}checked{/if}>
                        <label class="reviews-rating__star" for="star-1_{$key}"></label>
                    </div>
                </div>
                {/foreach}
            </div>
            <label class="reviews-text__label remark-area" data-client=0>
                <textarea class="reviews-text__textarea remark" placeholder="">{$personal.remark}</textarea>
            </label>
            {foreach from=$obj->checkRatingAndRemarkRight($firm.id) key=key item=data}
                <label class="reviews-text__label remark-area hidden" data-client="{$data.id}">
                    <textarea class="reviews-text__textarea remark" placeholder="">{$data.remark}</textarea>
                </label>
            {/foreach}
            <button class="js_change_remark reviews__button">Сохранить</button>

        <div class="alert"></div>


        </div>
    </div>
</div>