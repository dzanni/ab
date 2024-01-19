{if count($pages)}

    <div class="pagination">
        {foreach $pages as $p}
            {if !$p.active}
                <a href="/account/messages/?page={$p.page}" class="pagination-link {if $p.active}active{/if}" >{$p.page}</a>
            {else}
                <a class="pagination-link {if $p.active}active{/if}" >{$p.page}</a>
            {/if}
        {/foreach}
    </div>

{/if}
 