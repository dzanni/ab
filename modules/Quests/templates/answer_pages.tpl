{foreach from=$answers key=key item=data}
    <div class="user_card_item">
        <div class="firm_card_item_title">
            <a href="/users/?user={$data.user}">{$data.full_name}</a><br>
        </div>
        <div class="firm_card_item_date">
            {$data.date}
        </div>
        {if $current_user->role_GAK >= 4 || $current_user->id == $data.user}
            <textarea class="quest_answer">{$data.title}</textarea>
            {foreach from=$data.files item=$data1}
                <div class="firm_card_item_text">
                    <a href="/files/answer/{$data1.filename}" target="_blank">{$data1.user_filename}.{$data1.ext}</a>
                </div>
            {/foreach}
            <a class="js_change_quest_answer account__button_render" data-id="{$data.id}">Сохранить</a>
            <a class="js_delete_quest_answer black account__button_render" data-id="{$data.id}">Удалить</a>
        {else}
            <div class="firm_card_item_text">
                {$data.title}
            </div>
            {foreach from=$data.files item=$data1}
                <div class="firm_card_item_text">
                    <a href="/files/answer/{$data1.filename}" target="_blank">{$data1.user_filename}.{$data1.ext}</a>
                </div>
            {/foreach}
        {/if}
        <div class="firm_card_item_like">
            <img src="/i/like1.svg" width="20" height="20" {if $current_user->auth}class="js_like_counter like_img" data-id="{$data.id}" data-obj="answer"{/if}> (<span class="js_like_counter_anchor">{$data.like}</span>)<br>
        </div>
    </div>
{/foreach}

{if count($pages_answer) >1}
    <div class="catalog__pagination justify-center" data-quest="{$quest_id}">

        {if $page_current_answer != 1}
            <a class="js_change_answer_page catalog__pagination-prev"
               data-page="{$page_current_answer-1}">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                     xmlns="http://www.w3.org/2000/svg">
                    <path d="M15.8334 10H4.16669" stroke="#4C5475" stroke-width="1.66667"
                          stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M10 15.8334L4.16669 10.0001L10 4.16675" stroke="#4C5475"
                          stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </a>
        {/if}

        {foreach $pages_answer as $p}
            {if $p.page == "..."}
                <span class="catalog__pagination-link">{$p.page}</span>
            {else}
                <a class="js_change_answer_page catalog__pagination-link {if $page_current_answer == $p.page}active{/if}"
                   data-page="{$p.page}">{$p.page}</a>
            {/if}
        {/foreach}

        {if $page_current_answer != count($pages_answer)}
            <a class="js_change_answer_page catalog__pagination-next"
               data-page="{$page_current_answer+1}">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                     xmlns="http://www.w3.org/2000/svg">
                    <path d="M4.16671 10H15.8334" stroke="#4C5475" stroke-width="1.66667"
                          stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M10 15.8334L15.8334 10.0001L10 4.16675" stroke="#4C5475"
                          stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </a>
        {/if}

    </div>
{/if}