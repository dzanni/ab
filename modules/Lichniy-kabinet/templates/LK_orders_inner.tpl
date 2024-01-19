<div class="order_lk_v1">
    {foreach from=$result item=r}
        <div class="order_element js_order_element order_{$r.id}" data-order="{$r.id}">
            <div class="container-fluid">
                <div class="row order_head">
                    <div class="col-3">Заказ №{$r.id}</div>
                    <div class="col-3">{$r.date_formatted}</div>
                    <div class="col-3"> {$viewer->render_price($r.sum)} ₽</div>
                    <div class="col-3">{$obj->render_element("select","status", $r.status, true)}</div>
                </div>
                {foreach from=$r.data->result item=item}

                    <div class="row order_element_item js_row_basket_item" data-id="{$item.id}">
                        <div class="col-1"><img style="width: 60px;" src="/images/photo/{$item.data_img}" alt=""></div>
                        <div class="col-5">
                            {$obj->render_element("input","title", $item.title)}
                            <br>
                            Артикул: {$obj->render_element("input","tovarId", $item.tovarId)}
                            <br>
                            Поставщик:
                            {$obj->render_element("select","seller_id", $item.seller_id)}
                            <br>{$viewer->getXmlCode($item.tovarId)}
                        </div>
                        <div class="col-2">
                            <span class="js_sum_local element_value">{$viewer->render_price($item.price)} ₽/шт.</span>
                            <input class="chg_element_hide chg_element_value js_chg_order  slyle_input " type="text" value="{$item.price}" data-field="price">
                        </div>
                        <div class="col-1">
                            <input type="text" class="product__count-input js_col_item js_chg_order"
                                   data-id="{$item.id}" value="{$item.col}" {*data-max="{$item.max_col}"*}data-max="1000"
                                   data-inpack="{$item.inpack}" data-field="col">
                        </div>

                        <div class="col-2">
                            <span class="js_sum_local">{$item.sum_formatted}</span> ₽
                        </div>
                        <div class="col-1">
                            <a class="cart__icon-trash js_order_remove" data-id="{$item.id}">
                                <img src="/i/cart/trash.svg" class="svg" alt="">
                            </a>
                        </div>
                    </div>
                {/foreach}

                <div class="row">
                    <div class="col-4">
                        <div class="js_add_in_order chg_element_hide">
                            <div class="row">
                                <div class="col-4">
                                    <input class="chg_element_value js_add_tovar_id slyle_input" type="text" value="" placeholder="Артикул товара">
                                </div>
                                <div class="col-4">
                                    <input class="chg_element_value js_add_order_col slyle_input" type="text" value="" placeholder="К-во">
                                </div>
                                <div class="col-4">
                                    <a class="order_link js_add_in_order_btn">Добавить в заказ</a>
                                </div>
                            </div>
                        </div>

                        Доставка: {$obj->render_element("select","deliver", $r.deliver)}<br>
                       {* Стоимость доставки: {$obj->render_element("input","deliverPrice", $r.deliverPrice)}<br>*}
                       {* Способ оплаты: {$obj->render_element("select","payType", $r.payType)}*}

                    </div>
                    <div class="col-4">
                        <strong>Покупатель: </strong><br>
                        ФИО: {$obj->render_element("input","f", $r.f)} <br>
                        Телефон: {$obj->render_element("input","tel", $r.tel)}<br>
                        Почта: {$obj->render_element("input","email", $r.email)}<br>
                        {if $r.comment}
                            <strong>Комментарий покупателя:</strong><br>
                            {$obj->render_element("textarea","comment", $r.comment)}
                        {/if}
                    </div>
                    <div class="col-4">
                        {if !$r.manager}
                            <div>
                                <a class="order_link js_apply_order">Принять заказ</a>
                            </div>
                        {else}
                            <div>
                                Менеджер: {$obj->render_value("manager", $r.manager)}
                            </div>
                        {/if}

                        <strong>Комментарий менеджера:</strong><br>
                        {$obj->render_element("textarea","comment2", $r.comment2, true)}

                        <div>
                            <a class="order_link js_chg_order_btn">Редактировать заказ</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {/foreach}
</div>