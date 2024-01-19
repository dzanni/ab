{foreach from=$tiporazmerVariants key=key item=tiporazmer}
    <div class="product__articule">R{$key}</div>

    {foreach from=$tiporazmer item=tInner}
        <div><a href="{$tInner.URL}" class="product__title_inner">{$tInner.title}</a></div>
        <br>
        <div class="product__price">
            {$tInner.priceFormated} ₽
            {if $tInner.price < $tInner.oldPrice}<div class="product__price-old">{$tInner.priceOldFormated} ₽</div>{/if}
        </div>

        {$tInner.add_basket}
        <div>&nbsp;</div>
        <div class="product__articule">Код товара: {$tInner.id} (доступно {$tInner.col} шт.)</div>
    {/foreach}
{/foreach}