{foreach from=$values item=v}
    {if $v.id == $val}<span class="element_value">{$v.title}</span>{/if}
{/foreach}