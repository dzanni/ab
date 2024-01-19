 <a href="/basket/" class="item__mycount">
        {if $item.col_in_basket}
            В вашей корзине: <div class="catalog__mycount-item">{$item.col_in_basket} шт.</div>
        {else}
            <div class="catalog__mycount-item">В корзине</div>
        {/if}
</a>
