<table class="table">
    <tr>
        {foreach from=$firstRow item=fr}
            <th>
                <select class="set_settings_js">
                    {foreach from=$fr item=ft_item}
                        <option {if $ft_item.selected}selected="selected"{/if} value="{$ft_item.value}">{$ft_item.title}</option>
                    {/foreach}
                </select>
            </th>
        {/foreach}
    </tr>

    {foreach from=$price->data item=$p}
        <tr>
             {foreach from=$p item=v}
                 <td>{$v}</td>
             {/foreach}
        </tr>
    {/foreach}
</table>