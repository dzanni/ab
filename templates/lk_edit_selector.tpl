<select class="js_edit_options {if $needRecursion == true}recursion{/if}" data-id="{$tovar_id}" data-recursion="{$needRecursion}">
        <option value="-1">ВЫБРАТЬ</option>
    {foreach from=$options_values item=data}
        <option value="{$data.id}" {if $data.flag == 1}selected="selected" class="js_options_anchor"{/if}>{$data.title}</option>
    {/foreach}
</select>