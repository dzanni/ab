{if count($order->orderData())}
 <section>
         <div class="cart-conf__section">
             <div class="section__title">Подтверждение</div>


             <div class="cart-conf__list">

                 <div class="cart-conf__list-title">
                     <div class="cart-conf__item-title">Наименование</div>
                     <div class="cart-conf__item-title">Цена за ед.</div>
                     <div class="cart-conf__item-title">Количество</div>
                     <div class="cart-conf__item-title">Сумма</div>
                     <div class="cart-conf__item-title">Комментарий</div>
                 </div>

                 {foreach from=$order->orderData() item=od}
                     <div class="js_row_basket_item cart-conf__item-list-row">
                         <div class="cart__item-img">
                             <img src="/" alt="">
                         </div>
                         <div class="cart-conf__item-name">
                             {$od.title}
                         </div>
                         <div class="cart-conf__item-price">
                             {$od.price}
                         </div>
                         <div class="cart-conf__item-qnt">
                             {$od.col}
                         </div>
                         <div class="js_sum_local cart-conf__item-amount">
                             {$od.sum}
                         </div>
                         <div class="cart-conf__item-coment">
                             {$od.comment}
                         </div>
                     </div>
                 {/foreach}

                 <div class="cart-conf__item-list-amount">

                     <div class="cart-conf__item-list-cost">
                         Итого: <span class="cart-conf__item-list-allcount"><span class="js_col_all">{$order->col()}</span> шт.</span> / <span class="cart-conf__item-list-allprice"><span class="js_sum_all">{$order->sum()}</span></span>
                     </div>
                 </div>

             </div>


             <div class="cart-conf__info">
                 <div class="cart-conf__info-item">
                     <div class="cart-conf__info-title">
                         Тип оплаты
                     </div>
                     <div class="cart-conf__info-value">
                         {if $order->getOrderParam('payType') == 0}{$PayType.0.title}
                         {else}
                         {foreach from=$PayType item=data}
                             {if $order->getOrderParam('payType') == $data.id}{$data.title}{/if}
                         {/foreach}
                         {/if}
                     </div>
                 </div>
                 <div class="cart-conf__info-item">
                     <div class="cart-conf__info-title">
                         Адрес доставки
                     </div>
                     <div class="cart-conf__info-value">
                         {if ($order->getOrderParam('address_id') == 0) and ($order->getOrderParam('address') == "")}
                             {$userAddress.0.address}
                         {elseif $order->getOrderParam('address_id') == 0}
                             {$order->getOrderParam('address')}
                         {else}
                             {foreach from=$userAddress item=data}
                                 {if $order->getOrderParam('address_id') == $data.id}{$data.address}{/if}
                             {/foreach}
                         {/if}
                     </div>
                 </div>
                 <div class="cart-conf__info-item">
                     <div class="cart-conf__info-title">
                         Контактное лицо
                     </div>
                     <div class="cart-conf__info-value">
                         {if ($order->getOrderParam('contact_id') == 0) && ($order->getOrderParam('contact') == "")}
                             {$userContacts.0.contact}
                         {elseif $order->getOrderParam('contact_id') == 0}
                             {$order->getOrderParam('contact')}
                         {else}
                             {foreach from=$userContacts item=data}
                                 {if $order->getOrderParam('contact_id') == $data.id}{$data.contact}{/if}
                             {/foreach}
                         {/if}
                     </div>
                 </div>
                {* <div class="cart-conf__info-item">
                     <div class="cart-conf__info-title">
                         Комментарий
                     </div>
                     <div class="cart-conf__info-value">
                         Звоните с 11:00 до 17:00
                     </div>
                 </div>*}
             </div>

             <div class="cart-conf__comment">
                 <div class="cart-conf__comment-title">Комментарий к заказу</div>
                 <div class="cart-conf__item-comment">
                     <div class="cart-conf__item-comment-edit-textarea">
                         <textarea name="comment-edit-textarea" class="comment-edit-textarea-input">{$order->getOrderParam('comment')}</textarea>
                     </div>
                     <div class="cart-conf__item-comment-edit-buttons">
                         <a class="js_mk_order cart-conf__item-comment-edit-button-ok">
                             Отправить
                         </a>
                         <a href="/basket/?step=2" class="cart-conf__item-comment-edit-button-cancel">
                             Предыдущий этап
                         </a>
                     </div>
                 </div>
             </div>

         </div>


 </section>

{else}
    <h3>Корзина пуста</h3>
 {/if}



