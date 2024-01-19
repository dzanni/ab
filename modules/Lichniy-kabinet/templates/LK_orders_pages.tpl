{if count($pages)}
    Страницы:
    {foreach $pages as $p}
        <a data-page="{$p.page}" class="js_pages_chg {if $p.active}selected{/if}" >{$p.page}</a>
    {/foreach}
{/if}