<div class="page-inner page-quest">
    <p class="mobile_only text-align-center">Задайте свой вопрос или найдите интересную тему для обсуждения используя фильтры:</p>

    <aside>
        <div class="lk_tag_box">
            {foreach from=$tags item=data}
                <div class="js_chg_element">
                    <h4 class="tag_title_toggle js_tag_title_toggle">{$data.title}</h4>

                    <div class="tag_cloud">

                        {foreach from=$data.inner key=key item=data1}
                            {if $obj->checkTag($data1.id)}
                                <div class="tag_cloud_item checked">
                                    {$data1.title}
                                    <span class="js_delete_tag_render cross_small" data-id="{$data1.id}"></span>
                                </div>
                            {/if}
                        {/foreach}

                    </div>

                    <div class="filter_js_anchor tag_title_anchor">
                        <input type="text" placeholder="Найти"
                               class="js_fast_filter_mark filter_checkbox_search_lk" value="">
                        <div class="tag_cloud">
                            {foreach from=$data.inner key=key item=data1}
                                <div class="tag_cloud_item label js_add_tag_render {if $obj->checkTag($data1.id)}checked{/if}" data-id="{$data1.id}">
                                    <span class="filter-form__label-title">{$data1.title}</span>
                                </div>
                            {/foreach}
                        </div>

                    </div>
                </div>
                {if $data.id ==1} {* К стране берем регионы*}
                    <div class="js_chg_element">
                        <h4 class="tag_title_toggle js_tag_title_toggle">Регион</h4>

                        <div class="tag_cloud">
                            {foreach from=$regions item=reg}
                                {if $obj->checkTag($reg.id)}
                                    <div class="tag_cloud_item checked">
                                        {$reg.title}
                                        <span class="js_delete_tag_render cross_small" data-id="{$reg.id}"></span>
                                    </div>
                                {/if}
                            {/foreach}
                        </div>

                        <div class="filter_js_anchor tag_title_anchor">
                            <input type="text" placeholder="Найти"
                                   class="js_fast_filter_mark filter_checkbox_search_lk" value="">
                            <div class="tag_cloud">
                                {foreach from=$regions item=reg}
                                    <div class="tag_cloud_item label js_add_tag_render {if $obj->checkTag($reg.id)}checked{/if}" data-id="{$reg.id}">
                                        <span class="filter-form__label-title">{$reg.title}</span>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    </div>
                {/if}
            {/foreach}

            {if $current_user->auth}
                <div class="js_chg_element">
                    <h4 class="tag_title_toggle js_tag_title_toggle on">Тип вопроса и новости</h4>

                    <div class="filter_js_anchor tag_title_anchor on">

                        <select class="js_chg lk_select select js_send_form" name="q_type">
                            <option value="">Все</option>
                            <option value="quests" {if $smarty.get.q_type == "quests"}selected="selected"{/if}>Только вопросы</option>
                            <option value="news" {if $smarty.get.q_type == "news"}selected="selected"{/if}>Только новости</option>
                            <option value="interests" {if $smarty.get.q_type == "interests"}selected="selected"{/if}>По моим интересам</option>
                            <option value="answers" {if $smarty.get.q_type == "answers"}selected="selected"{/if}>Где я отвечал</option>
                            <option value="my" {if $smarty.get.q_type == "my"}selected="selected"{/if}>Мои</option>
                        </select>
                    </div>
                </div>
            {/if}
            <a class="account__button_render js_render_firm_filter button button--orange">Применить фильтр</a>

            <p class="refresh_filter"><a href="/quests/">Сбросить фильтр</a></p>
        </div>

    </aside>
    <main>
        <div class="quest__wrap">
            <p class="desctop_only">Задайте свой вопрос или найдите интересную тему для обсуждения используя фильтры слева </p>
            <div class="quest__bar">
                <h1>Вопросы и новости</h1>
                <div class="quest__count">{$col_elements}</div>
                {if $current_user->auth && $current_user->status == 1}
                    <a class="button button--orange quest__create js_create_new_quest" data-news="1">Разместить новость</a>
                    <a class="button button--orange quest__create js_create_new_quest">Создать вопрос</a>

                {/if}

            </div>
            <div class="quest__nav">
                <div class="quest__search">
                    <div class="quest__form">
                        <input class="quest__form-input js_txt_search" value="{$search_txt}" type="text">
                        <button class="quest__form-button js_start_search" type="button">
                            <svg class="svg-sprite-icon icon-icon__search">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__search"></use>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>


            {if $all_quest}
                {$all_quest}
            {else}
                По заданным параметрам ничего не найдено
                <br>
                <br>
                {if $url_profile_tags}
                    Вы можете расширить параметры интересов, привязав дополнительные теги для поиска в <a href="{$url_profile_tags}">настройках профиля</a>.
                {/if}
            {/if}

            {if count($pages) > 1}
                <div class="pagination">

                    {if $page_current != 1}
                        <a href="{$left_url}" class="pagination-link">
                            <svg class="svg-sprite-icon icon-icon__arrow-l">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__arrow-l"></use>
                            </svg>
                        </a>
                    {/if}

                    {foreach $pages as $p}
                        {if $p.page == "..."}
                            <span class="pagination-link">{$p.page}</span>
                        {else}
                            <a href="{$p.url}" class="pagination-link {if $p.active}active{/if}">{$p.page}</a>
                        {/if}
                    {/foreach}

                    {if $page_current != count($pages)}
                        <a href="{$right_url}" class="pagination-link">
                            <svg class="svg-sprite-icon icon-icon__arrow-r">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__arrow-r"></use>
                            </svg>
                        </a>
                    {/if}

                </div>
            {/if}
        </div>




    </main>
</div>
