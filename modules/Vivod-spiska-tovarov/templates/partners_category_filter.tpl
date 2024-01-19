{* Скрыто, так как категория всего одна, без дочерей

<div class="breadcrumbs">
    Выбор библиотеки:
    {foreach from=$category key=k item=c}
        {if $k!=0}|{/if} <a href="/brand/?brand={$brand}&c={$c.id}" class="">{$c.title}</a>
    {/foreach}

</div> *}