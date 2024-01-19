<h4 class="tag_title_toggle js_tag_title_toggle">Регион</h4>

<div class="tag_cloud">
    {foreach from=$obj->getRegTags($id) item=reg}
        {*{if $obj->check_tag_select($reg.id, 0)}*}
        {if $reg.id|in_array:$reg_arr}
            <div class="tag_cloud_item checked">
                {$reg.title}
                <span class="js_delete_tag{if $class=="firm"}_firm{elseif $class=="quest"}_quest{/if} cross_small" data-id="{$reg.id}"
                      data-{if $class="user"}user{elseif $class=="firm"}firm{elseif $class=="quest"}quest{/if}="{$id}"></span>
            </div>
        {/if}
    {/foreach}
</div>

<div class="filter_js_anchor tag_title_anchor">
    <input type="text" placeholder="Найти"
           class="js_fast_filter_mark filter_checkbox_search_lk" value="">
    <div class="tag_cloud">
        {foreach from=$obj->getRegTags($id) item=reg}
            <div class="tag_cloud_item label {*{if $obj->check_tag_select($reg.id, 0)}*}{if $reg.id|in_array:$reg_arr}checked{/if} js_add_tag{if $class=="firm"}_firm{elseif $class=="quest"}_quest{/if}"
                 data-id="{$reg.id}" data-{if $class=="user"}user{elseif $class=="firm"}firm{elseif $class=="quest"}quest{/if}="{$id}">
                <span class="filter-form__label-title">{$reg.title}</span>
            </div>
        {/foreach}
        {if $obj->getRegTags($id)}
            <div class="tag_cloud_item label gray">
                <a href="#popup__tag" class="filter-form__label-title open__popup_tag" data-id="-1">Предложить другой
                    тег</a>
            </div>
        {/if}
    </div>
</div>