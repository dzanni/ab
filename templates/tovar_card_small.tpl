    <div class="product__item">
        <div class="artikul">Артикул: {$data.id}</div>
        {*{if $data.showUser != 1 && $data.inner}
            <div class="product__item__labels">
                {if $data.year != 0}
                    <div class="product__item__label">
                        {if $data.year > 0}
                            Уценка: шины {$data.year}г.
                        {else}
                            Уценка: старше 3х лет
                        {/if}
                    </div>
                {/if}
                {if $data.col < 4}
                    <div class="product__item__label">
                        Осталось только {$data.col} шт.
                    </div>
                {/if}
            </div>
        {/if}*}
        <div class="product__image">
            <a href="{$data.URL}">
                <img src="/img.php?filename={$data.IMG}" alt="{$data.title}">
            </a>
        </div>
        <div class="icons"><img src="/i/icon/{$data['tovar_category']}.png"> </div>
        <div class="product__articule">{$data.artikul}</div>
        <a href="{$data.URL}" class="product__title">{$data.title}</a>

        <div class="product__tech">
            <div class="product__tech-item">
                <div class="product__tech-title">
                    Наличие
                    <span></span>
                </div>
                <div class="product__tech-value {if $data.col < 4}attention{else}green{/if}">
                    {$data.col}&nbsp;шт.
                </div>
            </div>
            <div class="product__tech-item">
                <div class="product__tech-title">
                    Доставка
                    <span></span>
                </div>
                <div class="product__tech-value">
                    {if $data.deliver_days}{$data.deliver_days}&nbsp;дн.{else}в&nbsp;наличии{/if}
                </div>
            </div>
        </div>

        <div class="product__price">
            {$data.priceFormated} ₽
            {if $data.price < $data.oldPrice}<div class="product__price-old">{$data.priceOldFormated} ₽</div>{/if}
        </div>

        {if $data.year != 0}
            <div class="attention">
                {if $data.year > 0}
                    Уценка: шины {$data.year}г.
                {else}
                    Уценка: старше 3х лет
                {/if}
            </div>
        {else}
            <div class="attention">&nbsp;</div>
        {/if}


        {$data.add_basket}

        {if $CURRENT_USER->role == 1 || $CURRENT_USER->role == 2}
            <div>Поставщик: {$viewer->getSellersName($data.sellers)}<br><a href="#popup__table" class="open__popup-table show_also_variants" data-id="{$data.id}">Еще варианты</a>
                {if $CURRENT_USER->role == 2}Зак.: {$viewer->render_price($data.b2b)}&nbsp;₽{/if}</div>
        {/if}

    </div>
