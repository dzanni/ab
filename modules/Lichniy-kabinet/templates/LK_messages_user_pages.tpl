{if count($pages)}
    <div class="catalog__pagination">
        <p>&nbsp;</p>
        Страницы:
        {foreach $pages as $p}
            {if !$p.active}
                <a href="/account/messages/?page={$p.page}" class="catalog__pagination-page {if $p.active}active{/if}" >{$p.page}</a>
            {else}
                <a class="catalog__pagination-page {if $p.active}active{/if}" >{$p.page}</a>
            {/if}
        {/foreach}
    </div>

{/if}