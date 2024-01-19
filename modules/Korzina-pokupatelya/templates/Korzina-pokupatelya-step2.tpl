{if count($order->orderData())}
 <section>
         <div class="cart-dp__section">
             <div class="section__title">Оформление</div>
             <div class="cart-dp__form">

                 <div class="cart-dp__fields">
                     <div class="cart-dp__field">

                         <select class="js_chg_values_order cart-dp__field-type" data-field="payType">
                             {foreach from=$PayType item=data}
                                 <option value="{$data.id}" {if $order->getOrderParam('payType') == $data.id}selected="selected"{/if}>{$data.title}</option>
                             {/foreach}
                         </select>
                     </div>
                     <div class="cart-dp__field">
                         <select class="js_chg_values_order cart-dp__field-delivery" data-field="address_id">
                             {foreach from=$userAddress item=data}
                                 <option value="{$data.id}" {if $order->getOrderParam('address_id') == $data.id}selected="selected"{/if}>{$data.address}</option>
                             {/foreach}
                             <option value="more" {if $order->getOrderParam('address_id') == 0 and $order->getOrderParam('address') != ''}selected="selected"{/if}>Другой адрес</option>
                         </select>
                         <div class="cart-dp__field-delivery-more {if count($userAddress) > 0 and ( ($order->getOrderParam('address_id') !=0) or ($order->getOrderParam('address_id') == 0 and $order->getOrderParam('address') == ''))}hide{/if}">
                             <input type="text" class="js_chg_values_order cart-dp__field-delivery-input" value="{$order->getOrderParam('address')}" data-field="address">
                             <label>
                                 <input type="checkbox" class="js_chg_values_order" data-field="save_address">
                                 <span>Сохранить в «Мои адреса»</span>
                             </label>
                         </div>
                     </div>
                     <div class="cart-dp__field">
                         <select class="js_chg_values_order cart-dp__field-contacts" data-field="contact_id">
                             {foreach from=$userContacts item=data}
                                 <option value="{$data.id}" {if $order->getOrderParam('contact_id') == $data.id}selected="selected"{/if}>{$data.contact}</option>
                             {/foreach}
                             <option value="more" {if $order->getOrderParam('contact_id') == 0 and $order->getOrderParam('contact') != ''}selected="selected"{/if}>Другой контакт</option>
                         </select>
                         <div class="cart-dp__field-contacts-more {if count($userContacts) > 0 and (($order->getOrderParam('contact_id')!=0) or ($order->getOrderParam('contact_id') == 0 and $order->getOrderParam('contact') == ''))}hide{/if}">
                             <input type="text" class="js_chg_values_order cart-dp__field-contacts-input" value="{$order->getOrderParam('contact')}" data-field="contact">
                             <label>
                                 <input type="checkbox" class="js_chg_values_order" data-field="save_contact">
                                 <span>Сохранить в «Мои контакты»</span>
                             </label>
                         </div>
                     </div>

                 </div>

                 <div class="cart-dp__comment">
                     <div class="cart-dp__comment-title">Комментарий к заказу</div>
                     <div class="cart-dp__item-comment">
                         <div class="cart-dp__item-comment-edit-textarea">

             <input type="text" name="comment-edit-textarea" class="js_chg_values_order" value="{$order->getOrderParam('comment')}" data-field="comment">

                         </div>
                          <div class="cart-dp__item-comment-edit-buttons">
                             <a href="/basket/?step=3" class="js_add_new_contacts_order cart-dp__item-comment-edit-button-ok" >
                               Подтвердить данные
                             </a>
                             <a href="/basket/?step=1" class="cart-dp__item-comment-edit-button-cancel">
                                 Предыдущий этап
                             </a>
                         </div>
                     </div>
                 </div>

             </div>
         </div>
</section>

{else}
    <h3>Корзина пуста</h3>
 {/if}

