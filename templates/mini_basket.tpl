{*
<a href="/basket/" class="header__basket">
    <div class="header-basket__icon">
        <img src="/i/icon__basket.svg" alt="">
        <span class="header-basket__count">{$order->col()}</span>
    </div>
    <div class="header-basket__info">
        <div class="header-basket__title">Стоимость</div>
        <div class="header-basket__price">
            <span class="price">{$order->sum()}</span> ₽
        </div>
    </div>
</a>
*}
{$order->col()} шт.