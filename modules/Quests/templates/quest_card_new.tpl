<div class="page-inner page-quest">
    <main>
        <div class="quest__wrap">
            <div class="quest__bar">
                <h1>Обсуждения</h1>
                <div class="quest__count">{$col_elements}</div>
                {if $current_user->auth}
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
