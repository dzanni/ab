{* $item.basket_type == "tovarCard" дает возможность задать стиль для большой карточки товара, если вдруг стиль должен отличаться от малой карточки *}
{if $item.col == 0}
    <div class="product__add js_add_in_basket_div">
       Нет в наличии
    </div>
{else}
        <div class="product__add js_add_in_basket_div">
            <div class="product__count js_plus_minus_chg">
                <span class="js_chg_col {*product__count-minus*}" data-type="minus">-</span>
                <input type="text" class="js_add_in_basket_data js_col_item js_add_in_basket_col product__count-input" name="col" value="1" data-max="{$item.col}" data-inpack="{$item.inpack}">
                <span class="js_chg_col {*product__count-plus*}" data-type="plus">+</span>

                <input class="js_add_in_basket_data" type="hidden" name="add_in_basket" value="{$item.add_in_basket}">
            </div>
            <div class="js_add_in_basket button product__addcart">В корзину</div>
        </div>
{/if}


