<table border="1" style="margin-top: 10px;" cellpadding="5" cellspacing="0">
    <tr style="width: 600px; background:#00569e; color:#fff;">
        <th style="width:250px;">
            <div>Код, производитель, название</div>
        </th>
        <th style="width:100px;">
            <div>Цена за ед. (руб)</div>
        </th>
        <th style="width:100px;">
            <div>Количество (шт.)</div>
        </th>
        <th style="width:100px;">
            <div>Стоимость (руб.)</div>
        </th>
    </tr>
    {foreach from=$order.data->result item=od}
        <tr>
            <td>
                {$od.code}<br>
                {$od.firm} {$od.title}<br>
            </td>
            <td style='text-align:center;'>{$viewer->render_price($od.price)}</td>
            <td style='text-align:center;'>{$od.col}</td>
            <td style='text-align:center;'>{$viewer->render_price($od.sum)}</td>
        </tr>
    {/foreach}


    {if $order.deliverPrice > 0 || $order.deliverName.name}
        <tr>
            <td colspan="3">
                {if $order.deliverName.name}
                    Способ доставки: {$order.deliverName.name}
                {else}
                    Доставка
                {/if}
            </td>
            <td style='text-align:center;'>
                {if $order.deliverPrice > 0}
                    {$viewer->render_price($order.deliverPrice)}
                {else}
                    Бесплатно
                {/if}
            </td>
        </tr>
    {/if}

    <tr>
        <td colspan="3">ИТОГО</td>
        <td style='text-align:center;'>{$viewer->render_price($order.sum)}</td>

    </tr>
</table>