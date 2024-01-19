<input type="hidden" class="js_article" value="{$article}" />
{if $has_ws}
    {foreach from = $ws key=key item=w}
        <input type="hidden" data-id="{$key}" value="{$w}" class="js_ws_search_query_brands_tovar" />
    {/foreach}
{/if}

<div class="js_asearch_result"></div>