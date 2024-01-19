<h3>Заказ №{$order->getOrderParam('id')} успешно оформлен! </h3>

<p>Пользователь: {$order->getOrderParam('f')}</p>
<p>Телефон: {$order->getOrderParam('tel')}</p>

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
    {foreach from=$order->orderData() item=od}
        <tr>
            <td>
                {$od.code}<br>
                {$od.firm} {$od.title}<br>
            </td>
            <td style='text-align:center;'>{$od.price}</td>
            <td style='text-align:center;'>{$od.col}</td>
            <td style='text-align:center;'>{$od.sum}</td>
        </tr>
    {/foreach}

    {assign var="deliverName" value=$order->getOrderParam("deliverName")}

    {if $order->getOrderParam("deliverPrice") > 0 || $deliverName.name}
        <tr>
            <td colspan="3">
                {if $deliverName.name}
                    Способ доставки: {$deliverName.name}
                {else}
                    Доставка
                {/if}
            </td>
            <td style='text-align:center;'>
                {if $order->getOrderParam("deliverPrice") > 0}
                    {$order->getOrderParam("deliverPrice")}
                {else}
                    Бесплатно
                {/if}
            </td>
        </tr>
    {/if}
</table>
{assign var="payTypeName" value=$order->getOrderParam("payTypeName")}
{if $payTypeName.title}
    <p>Способ оплаты: {$payTypeName.title}</p>
{/if}

{if $order->getOrderParam("comment")}
    <p>Комментарий к заказу: {$order->getOrderParam("comment")}</p>
{/if}

    <hr>
    Дата совершения заказа: {$order->getOrderParam("date_")|date_format:"%d.%m.%Y %H:%M"}
    <hr>

<p>Если Вы не совершали заказы - просто проигронируйте это письмо</p>