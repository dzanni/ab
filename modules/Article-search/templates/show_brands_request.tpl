<input type="hidden" class="js_article" value="{$article}" />
{if $has_ws}
    {foreach from = $ws item=w}
        <input type="hidden" value="{$w.id}" class="js_ws_search_query_brands" />
    {/foreach}
{/if}

<div class="js_asearch_result"></div>