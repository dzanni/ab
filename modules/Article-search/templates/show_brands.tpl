{foreach from=$brands item=b}
    <p><a class="js_" href="{$URL}?br_search&{$b.searchArg}&article={$article}">{$b.brands} {$b.name}</a> </p>
{/foreach}