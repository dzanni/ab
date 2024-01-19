<div class="page-inner page-allusers">
    <p class="mobile_only text-align-center">Найдите нужного эксперта, используя фильтры:</p>

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

                {if $data.id == 135} {* К сфере деятельности *}
                    <div class="js_chg_element">
                        <h4 class="tag_title_toggle js_tag_title_toggle {if $smarty.get.job_level}on{/if}">Уровень должности</h4>

                        <div class="filter_js_anchor tag_title_anchor {if $smarty.get.job_level}on{/if}">

                            <select class="js_chg lk_select select js_send_form" name="job_level">
                                <option value="">Выбрать</option>
                                {foreach from=$obj->getJobLevelList() item=data}
                                    <option value="{$data.id}"
                                            {if $smarty.get.job_level==$data.id}selected="selected"{/if}>{$data.title}</option>
                                {/foreach}
                            </select>


                        </div>
                    </div>

                    <div class="js_chg_element">
                        <h4 class="tag_title_toggle js_tag_title_toggle {if $smarty.get.experience}on{/if}">Опыт в автобизнесе</h4>

                        <div class="filter_js_anchor tag_title_anchor {if $smarty.get.experience}on{/if}">

                            <select class="js_chg lk_select select js_send_form" name="experience">
                                <option value="">Выбрать</option>
                                {foreach from=$obj->getExperienceList() item=data}
                                    <option value="{$data.id}"
                                            {if $smarty.get.experience==$data.id}selected="selected"{/if}>{$data.title}</option>
                                {/foreach}
                            </select>

                        </div>
                    </div>
                {/if}
            {/foreach}

            <a class="account__button_render js_render_firm_filter button button--orange">Применить фильтр</a>

            <p class="refresh_filter"><a href="/users/">Сбросить фильтр</a></p>
        </div>
    </aside>

    <main>
        {if !$is_empty}


            <div class="users__wrap">
                <p class="desctop_only">Найдите нужного эксперта, используя фильтры слева</p>
                <div class="user__bar">

                    <h1>Эксперты</h1>
                    <div class="users__count">{$col_elements}</div>
                    <div class="users__view">
                        <a href="{$base_url_plate}" class="users__view-item {if $outputType=="plate"}active{/if}">
                            <svg class="svg-sprite-icon icon-icon__view-list">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__view-table"></use>
                            </svg>
                        </a>
                        <a href="{$base_url_list}" class="users__view-item {if $outputType=="list"}active{/if}"><svg class="svg-sprite-icon icon-icon__view-table">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__view-list"></use>
                            </svg>
                        </a>
                    </div>
                </div>
                <div class="users__nav">
                    <div class="user__search">
                        <div class="users__form">
                            <input type="text" class="users__form-input js_txt_search" value="{$search_txt}">
                            <button type="button"  class="users__form-button js_start_search"><svg class="svg-sprite-icon icon-icon__search">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__search"></use>
                                </svg></button>
                        </div>
                    </div>
                    <div class="user__sort">
                        <select class="js_chg lk_select select js_sort_change">
                            <option value="{$base_url_alphabet}" {if $sort == 'alphabet'}selected="selected"{/if}>По алфавиту</option>
                            <option value="{$base_url_popular}" {if $sort == 'popular'}selected="selected"{/if}>По рейтингу</option>
                        </select>

                    </div>
                </div>
                <div class="users__list {if $outputType=="list"}list{/if}">
                    {foreach from=$all_users item=data}

                        <div class="users__item-wrap">
                            <a href="/users/?user={$data.id}" class="users__item">


                                <div class="users__item-photo">
                                    <div class="users__label">
                                        {if $data.ab_status_txt}
                                            <div class="users__label-item">
                                                <svg class="svg-sprite-icon icon-icon__user">
                                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__user"></use>
                                                </svg>
                                                <p>{$data.ab_status_txt}</p>
                                            </div>
                                        {/if}
                                        {if $data.score}
                                            <div class="users__label-item">
                                                <svg class="svg-sprite-icon icon-icon__star">
                                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__star"></use>
                                                </svg>
                                                <p>Баллов: {$data.score} </p>
                                            </div>
                                        {/if}
                                    </div>

                                    <img  alt="{$data.name} {$data.family_name}" class="users__item-img lazyloaded" src="
					{$viewer->get_icon_by_user($data.id)}">
                                </div>
                                <div class="users__item-info">
                                    <div class="h4 users__item-name">{$data.family_name} {$data.name}</div>
                                    <div class="users__label">
                                        {if $data.ab_status_txt}
                                            <div class="users__label-item">
                                                <svg class="svg-sprite-icon icon-icon__user">
                                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__user"></use>
                                                </svg>
                                                <p>{$data.ab_status_txt}</p>
                                            </div>
                                        {/if}
                                        {if $data.score}
                                            <div class="users__label-item">
                                                <svg class="svg-sprite-icon icon-icon__star">
                                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__star"></use>
                                                </svg>
                                                <p>Баллов: {$data.score} </p>
                                            </div>
                                        {/if}
                                    </div>
                                    <div class="subtext users__item-occup">{$data.job_place}</div>
                                    <div class="subtext users__item-job">{$data.job_title}</div>
                                    {*<span class="subtext product-team-experience"></span>*}
                                </div>
                            </a>
                        </div>

                    {/foreach}
                </div>
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
        {else}
            По заданным параметрам ничего не найдено
            <br>
            <br>
        {/if}
    </main>

</div>



{* <a href="/users/?user={$data.id}">{$data.family_name} {$data.name}</a> <br>*}