<select class="js_select_options lk_select" data-options="{$options_values.0.id_options}">
    <option value="-1">НЕ ВЫБРАНО</option>
    {foreach from=$options_values item=data}
        {if $data.parent == 0}
            <option value="{$data.id}" {if $data.flag == 1}selected="selected" class="js_options_anchor"{/if}>{$data.title}</option>
        {/if}
    {/foreach}
</select>
