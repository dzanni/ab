<tr>
    <td colspan="10"><hr></td>
</tr>
{foreach from=$res item=r}
    <tr>
        <td>{$r.code}</td>
        <td>{$r.firm}</td>
        <td>{$r.title}</td>
        <td>{$r.price}</td>
        <td>{$r.col}</td>
        <td>{$r.days_avg}/{$r.days_max}</td>
        <td>{$r.add_basket}</td>
    </tr>

    {*  [wsID] => ADEO_WS
                            [firm] => UFI
                            [code] => 2311200
                            [title] => 23.112.00_фильтр масляный  H140 d97 John Deere Series 2050 83
                            [price] => 352.9
                            [buyPrice] => 342.62
                            [col] => 9
                            [persent] =>
                            [codePostavki] => 81721
                            [location] => Санкт-Петербург
                            [quant] =>
                            [onStock] => 1
                            [days_avg] => 3
                            [days_max] => 4
                            [id] => 81721
                            [seller_id] => -18
                            [seller_priority] => 1
                            [seller_deliver] => 2
                            [fc_index] => UFI2311200
                            [price_hash] => a71e8a22384e39c39c2852c7678a1b15 *}
{/foreach}