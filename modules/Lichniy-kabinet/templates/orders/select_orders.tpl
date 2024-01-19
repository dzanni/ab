<select data-field="{$field}" class="chg_element_value  {if !$edit}chg_element_hide{/if}  js_chg_order">
    <option value="0">Не выбрано</option>
    {foreach from=$values item=v}
        <option value="{$v.id}" {if $v.id == $val}selected="selected"{/if}>{$v.title}</option>
    {/foreach}
</select>