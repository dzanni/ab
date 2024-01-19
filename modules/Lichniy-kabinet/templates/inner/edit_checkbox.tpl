{foreach from=$options_values item=data}
    <div class="lk_checkbox-item">
        {if $data.parent == 0}
            <input type="checkbox" {if $data.flag == 1}checked{/if} class="js_check_options"
                   data-options="{$data.id_options}" data-value="{$data.id}">
            <label {if $data.flag == 1}checked{/if}>{$data.title}</label>
        {/if}
    </div>
{/foreach}
