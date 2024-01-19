<section class="cart">
    <div class="container-fluid">
        <h1 class="page_h1 {*page__title*}">Корзина</h1>

        {if count($order->orderData()) > 0}
        <div class="js_cart_all_item_page">
            <div class="js_basket_all_items cart__inner">
                <div class="cart__inner-select">
                    <label class="cart__label-checkbox">
                        <input type="checkbox" class="js_basket_delay_all cart__checkbox">
                        <span class="cart__label-title">Выбрать все</span>
                    </label>
                </div>
                <div class="cart__inner-row">

                    {foreach from=$order->orderData() item=od}
                        <div class="js_row_basket_item cart__row">
                            <label class="cart__label-checkbox">
                                <input type="checkbox" class="js_basket_delay cart__checkbox" data-id="{$od.id}"
                                       {if !$od.delay}checked="true"{/if}>
                                <span class="cart__label-title"></span>
                            </label>
                            <div class="cart__row-img">
                                <img src="/images/photo/{$od.data_img}" alt="">
                            </div>
                            <div class="cart__row-info">
                                <div class="cart__row-articule">
                                    {$od.code}
                                </div>
                                <a href="#" class="cart__row-title">
                                    {$od.title}
                                </a>
                            </div>

                            <div class="cart__count">
                                <div class="product__count js_plus_minus_chg">
                                    <span class="js_chg_col" data-type="minus">-</span>
                                    <input type="text" class="product__count-input js_col_item js_basket_chg_col"
                                           data-id="{$od.id}" value="{$od.col}" data-max="{$od.max_col}"
                                           data-inpack="{$od.inpack}">
                                    <span class="js_chg_col" data-type="plus">+</span>

                                    <input class="js_add_in_basket_data" type="hidden" name="add_in_basket"
                                           value="{$item.add_in_basket}">
                                </div>
                            </div>

                            <div class="cart__price">
                                <span class="js_sum_local">{$od.sum_formatted}</span> ₽
                            </div>
                            <div class="cart__icon">
                               {* <a href="#" class="cart__icon-fav">
                                    <img src="/i/cart/favorites.svg" class="svg" alt="">
                                </a>*}
                                <a class="cart__icon-trash js_basket_remove" data-id="{$od.id}">
                                    <img src="/i/cart/trash.svg" class="svg" alt="">
                                </a>
                            </div>
                        </div>
                    {/foreach}

                    <div class="cart__cost">
                        Стоимость товаров в корзине:
                        <span class="cart__cost-price">
                        <span class="js_sum_all">{$order->sum_formatted()}</span> ₽
					</span>
                    </div>
                </div>
            </div>
            <form action="#" class="cart__order">
                <div class="cart__order-title">Оформление заказа</div>
                <div class="row">
                    <div class="col-12 col-lg-4">
                        <div class="cart__order-subtitle">1. Личные данные</div>
                        <label class="cart__order-label">
                            <input type="text" name="comment-edit-name" class="js_chg_values_order"
                                   value="{$order->getOrderParam('f')}" data-field="f" placeholder="ФИО">
                        </label>
                        <label class="cart__order-label">
                            <input type="text" name="comment-edit-tel"
                                   class="js_chg_values_order notEmptyOrder tel js_check_order_tel"
                                   value="{$order->getOrderParam('tel')}" data-field="tel" placeholder="Телефон">
                            <div class="js_check_order_tel_alert">
                                {if ($order->getOrderParam('tel') != $user->tel) || $user->tel_verification == 0}
                                <div class="js_prove_order_tel button cart__order-button form__button">Подтвердить телефон заказа</div>
                                {/if}
                            </div>
                        </label>
                        {if !$user->auth}
                        <label class="cart__order-label">
                            <input type="text" name="comment-edit-email"
                                   class="js_chg_values_order e_mail notEmptyOrder"
                                   value="{$order->getOrderParam('email')}" data-field="email" placeholder="E-mail">
                        </label>
                        {/if}

                    </div>
                    <div class="col-12 col-lg-4">
                        <div class="cart__order-subtitle">2. Оплата и доставка</div>
                        <div class="cart__order-pay">
                            <div class="cart__order-smalltitle">Выберите способ оплаты</div>
                            {foreach from=$PayType key=key item=data}
                                <label class="cart__order-radio" for="radio_item_pay{$key}">
                                    <input type="radio" name="order__pay" class="js_chg_values_order"
                                           id="radio_item_pay{$key}" data-id="{$data.id}" data-field="payType"
                                           value="{$data.id}"
                                           {if $order->getOrderParam('payType') == $data.id}checked="checked"{/if}>
                                    <span class="cart__order-radio-title">
									{$data.title}</span>
                                </label>
                            {/foreach}

                        </div>
                        <div class="cart__order-delivery">
                            <div class="cart__order-smalltitle">Выберите способ доставки</div>

                            {foreach from=$deliver key=key item=data}
                                <label class="cart__order-radio" for="radio_item_del{$key}">
                                    <input type="radio" name="order__delivery" class="js_chg_values_order"
                                           id="radio_item_del{$key}" data-id="{$data.id}" data-field="deliver"
                                           value="{$data.id}"
                                           {if $order->getOrderParam('deliver') == $data.id}checked{/if}>
                                    <span class="cart__order-radio-title">
									{$data.name}{if $data.price} ({$data.price} руб.){/if}</span>
                                </label>
                            {/foreach}

                        </div>
                    </div>
                    <div class="col-12 col-lg-4">
                        <div class="cart__order-subtitle">3. Оформление заказа</div>
                        <div class="cart__order-label">
                            <textarea name="comment-edit-textarea" class="js_chg_values_order"
                                      value="{$order->getOrderParam('comment')}" data-field="comment"
                                      placeholder="Комментарий к заказу">{$order->getOrderParam('comment')}</textarea>

                        </div>
                        <div class="cart__order-cost">
                            Итого: <span class="cart__order-cost-price"><span class="js_sum_all">{$order->sum_formatted()}</span> ₽</span>
                        </div>

                        <div class="cart__order-check">
                            <label class="cart__order-checkbox">
                                <input type="checkbox" name="form__checkbox" checked="checked">
                                <span class="cart__order-checkbox-title">
									Я согласен(на) с <a href="/Politika-obrabotki-personalnih-dannih/">политикой конфиденциальности</a>
									и даю согласие на <a href="/Politika-obrabotki-personalnih-dannih/">обработку персональных данных</a>
								</span>
                            </label>
                        </div>

                      <div class="js_mk_order_wrap">
                          {if $order->getOrderParam('tel') == $user->tel && $user->tel_verification == 1}
                        <div class="js_mk_order button cart__order-button form__button">Оформить заказ</div>
                      {/if}
                      </div>
                        <br>
                        <div class="js_mk_order_result"></div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    {else}
    <div class="cart__inner">
        <div class="cart__inner-select">
            Корзина пуста
        </div>
    </div>
    {/if}

    {* Отключено, нужно просто выводить каталог без выбранных товаров

    <section class="card__product-item">
        <div class="product__more">
            <div class="container-fluid">
                <div class="product__more-title">
                    Другие<br>товары
                </div>

                <div class="cards__product product__more-slider">
                    <div class="product__more-slick">

                        тут выводим каталог

                    </div>
                </div>
            </div>
        </div>
    </section>
    *}

</section>

