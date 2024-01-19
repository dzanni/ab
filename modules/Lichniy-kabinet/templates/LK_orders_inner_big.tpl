<section class="cart">
        {foreach from=$result item=r}
            <div class="lk_order_element js_order_element order_{$r.id}" data-order="{$r.id}">
                <div class="cart__inner">
                    <div class="cart__inner-row">
                        <div class="js_row_basket_item cart__row">
                            <div class="cart__row-info">
                                <div class="cart__row-articule">
                                    {$r.date_formatted}
                                </div>
                                <div class="cart__row-title">
                                    Заказ №{$r.id} на сумму: {$viewer->render_price($r.sum)} ₽
                                </div>
                            </div>
                            <div class="lk_order_status">
                                Статус заказа:&nbsp;&nbsp;&nbsp;{$obj->render_element("select","status", $r.status, true)}
                            </div>
                        </div>
                        {foreach from=$r.data->result item=item}
                            <div class="js_row_basket_item cart__row" data-id="{$item.id}">
                                <div class="cart__row-img">
                                    <img src="/images/photo/{$item.data_img}" alt="">
                                </div>
                                <div class="cart__row-info">
                                    {if $item.tovarId}
                                        <div class="cart__row-articule">
                                            Артикул: {$obj->render_element("input","tovarId", $item.tovarId)}
                                        </div>
                                    {/if}
                                    <div class="cart__row-title">
                                        {$obj->render_element("input","title", $item.title)}
                                    </div>
                                    {if $item.seller_id}
                                        <div class="cart__row-articule">
                                            Поставщик:
                                            {$obj->render_element("select","seller_id", $item.seller_id)}
                                        </div>
                                    {/if}
                                    {if $item.max_col}
                                        <div class="cart__row-articule">
                                            В наличии на складе на момент заказа:
                                            {$obj->render_element("input","max_col", $item.max_col)} шт.
                                        </div>
                                    {/if}
                                </div>



                                <div class="cart__price element_value">
                                    <span class="js_sum_local">{$viewer->render_price($item.price)}</span> ₽/шт.
                                </div>
                                <div class="cart__price chg_element_hide ">
                                    <input class="chg_element_value js_chg_order  slyle_input " type="text" value="{$item.price}" data-field="price">
                                </div>

                                <div class="cart__count">
                                    <div class="product__count js_plus_minus_chg">
                                        {*<span class="js_chg_col" data-type="minus">-</span>*}
                                        <input type="text" class="product__count-input js_col_item js_chg_order"
                                               data-id="{$item.id}" value="{$item.col}" data-max="{$item.max_col}"
                                               data-inpack="{$item.inpack}" data-field="col">
                                        {*<span class="js_chg_col" data-type="plus">+</span>*}

                                        <input class="js_add_in_basket_data" type="hidden" name="add_in_basket"
                                               value="{$item.add_in_basket}">
                                    </div>
                                </div>

                                <div class="cart__price">
                                    <span class="js_sum_local">{$item.sum_formatted}</span> ₽
                                </div>
                                <div class="cart__icon">
                                    {*<a href="#" class="cart__icon-fav">
                                        <img src="/i/cart/favorites.svg" class="svg" alt="">
                                    </a>*}
                                    <a class="cart__icon-trash js_order_remove" data-id="{$item.id}">
                                        <img src="/i/cart/trash.svg" class="svg" alt="">
                                    </a>
                                </div>
                            </div>
                        {/foreach}
                        <div class="js_row_basket_item cart__row">
                            <div class="cart__row-info">
                                <div class="cart__row-articule">

                                    <div class="add_in_order js_add_in_order">
                                        <input class="chg_element_value js_add_tovar_id slyle_input" type="text" value="" placeholder="Артикул товара">
                                        <input class="chg_element_value js_add_order_col slyle_input" type="text" value="" placeholder="К-во">
                                        <a class="button cart__order-button form__button js_add_in_order_btn">Добавить в заказ</a>
                                    </div>

                                    Доставка: {$obj->render_element("select","deliver", $r.deliver)}<br>
                                    Стоимость доставки: {$obj->render_element("input","deliverPrice", $r.deliverPrice)}<br>
                                    Способ оплаты: {$obj->render_element("select","payType", $r.payType)}

                                    <br><br>
                                    <strong>Покупатель: </strong><br>
                                    ФИО: {$obj->render_element("input","f", $r.f)} <br>
                                    Телефон: {$obj->render_element("input","tel", $r.tel)}<br>
                                    Почта: {$obj->render_element("input","email", $r.email)}<br>
                                    {if $r.comment}
                                        <strong>Комментарий покупателя:</strong><br>
                                        {$obj->render_element("textarea","comment", $r.comment)}
                                    {/if}
                                </div>
                                <div class="cart__row-title">

                                </div>
                            </div>
                            <div class="lk_order_status">
                                <div style="width: 100%;">
                                {if !$r.manager}
                                    <div>
                                        <a class="button cart__order-button form__button js_apply_order">Принять заказ</a>
                                    </div>
                                {else}
                                    <div>
                                        Менеджер: {$obj->render_value("manager", $r.manager)}
                                    </div>
                                {/if}

                                    <strong>Комментарий менеджера:</strong><br>
                                    {$obj->render_element("textarea","comment2", $r.comment2, true)}

                                    <div>
                                        <a class="button cart__order-button form__button js_chg_order_btn">Редактировать заказ</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        {/foreach}
</section>