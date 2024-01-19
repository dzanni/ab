{if count($values) > 0}
    <select class="filter__select search__form-select js_select_{$name}" data-name="{$name}">
        <option value="0">{$screen_name}</option>
        {foreach from=$values item=data}
            <option value="{$data.value}" {if $data.selected==1}selected="selected"{/if}>{$data.title}</option>
        {/foreach}
    </select>
{/if}
