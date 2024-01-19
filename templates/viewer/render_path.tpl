{if count($path)}
    <div class="breadcrumbs">
        <span class="breadcrumbs__item"><a href="/" class="breadcrumbs__link breadcrumbs__link-home">Главная</a></span>
        {foreach from=$path key=key item=d}
            <span class="breadcrumbs__item">
                {if ($key+1) !== count($path)}<a href="{$d.URL}" class="breadcrumbs__link">{/if}
                    {$d.title}
                {if ($key+1) !== count($path)}{/if}
                </a>
            </span>
        {/foreach}
    </div>
{/if}



