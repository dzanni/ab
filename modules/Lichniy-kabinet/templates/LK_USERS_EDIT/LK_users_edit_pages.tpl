{*{if count($pages)}
    <div class="catalog__pagination">
        <p>&nbsp;</p>
        Страницы:
        {foreach $pages as $p}
            <a data-page="{$p.page}" class="js_pages_chg catalog__pagination-page {if $p.active}active{/if}" >{$p.page}</a>
        {/foreach}
    </div>

{/if}*}