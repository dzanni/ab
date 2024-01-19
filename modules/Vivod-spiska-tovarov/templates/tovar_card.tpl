<section class="card__product-item">
    <div class="container-fluid">
       {*
        <div class="row">
            <div class="col-12">
                <ul class="breadcrumbs">
                    <li class="breadcrumbs__item"><a href="#" class="breadcrumbs__link breadcrumbs__link-home">Главная</a></li>
                    <li class="breadcrumbs__item"><a href="#" class="breadcrumbs__link">Смартфоны</a></li>
                    <li class="breadcrumbs__item"><a href="#" class="breadcrumbs__link">Xiaomi</a></li>
                </ul>
            </div>
        </div>
        *}
        <div class="product__item product__item-inner row">
            <div class="col-12 col-lg-6">

                <div class="product__image">
                    <div class="product__image-slick">
                        <div class="product__image-slick-item-element-no-slick">
                            <a href="/img.php?filename={$tovar.IMG}" data-fancybox="gallery"><img src="/img.php?filename={$tovar.IMG}" alt=""></a>
                        </div>
                    </div>
                    <div class="product__image-slick-thumb">
                        {foreach from=$tovar.IMG_ALL key=key item=data}
                            {if $key > 0}
                                <div class="product__image-slick-item">
                                    <a href="/img.php?filename={$data.filename}" data-fancybox="gallery"><img src="/img.php?filename={$data.filename}" alt=""></a>
                                </div>
                            {/if}
                        {/foreach}

                    </div>
                </div>
            </div>
            <div class="col-12 col-lg-6">
                <div class="cards__product">
                    <h1 class="product__title">{$tovar.title}</h1>
                    {if $tovar.artikul}
                        <div class="product__articule">Артикул: {$tovar.artikul}</div>
                    {else}
                        <div class="product__articule">Код товара: {$tovar.id}</div>
                    {/if}
                    <div class="product__tech">
                        {if $tovar.fName}
                            <div class="product__tech-item">
                                <div class="product__tech-title">
                                    Производитель
                                    <span></span>
                                </div>
                                <div class="product__tech-value">
                                    {$tovar.fName}
                                </div>
                            </div>
                        {/if}
                        {foreach from=$tovar.PARAMS item=data}
                            <div class="product__tech-item">
                                <div class="product__tech-title">
                                    {$data.title}
                                    <span></span>
                                </div>
                                <div class="product__tech-value">
                                    {$data.value}
                                </div>
                            </div>
                        {/foreach}

                    </div>

                    {if $tiporazmerVariants}
                        {$tiporazmerVariants}
                    {else}
                        <div class="product__price">
                            {$tovar.priceFormated} ₽
                            {if $tovar.price < $tovar.oldPrice}<div class="product__price-old">{$tovar.priceOldFormated} ₽</div>{/if}
                        </div>

                        {$tovar.add_basket}
                        {if $CURRENT_USER->role == 1 || $CURRENT_USER->role == 2}
                            <div class="forCar"><a href="#popup__table" class="open__popup-table show_also_variants" data-id="{$tovar.id}">Еще варианты</a>
                               {if $CURRENT_USER->role == 2}Зак.: {$tovar.b2b}{/if}</div>
                            <div>Поставщик: {$viewer->getSellersName($tovar.sellers)}</div>
                            <div>Артикул поставщика: {$viewer->getXmlCode($tovar.id)}</div>
                            <div>OEM: {$tovar.OEM}</div>
                            <div>Доступное количество: {$tovar.col}</div>
                        {/if}
                        <div>&nbsp;</div>
                        <div class="product__articule">
                            Код товара: {$tovar.id}
                            <span {if $tovar.col < 4}class="show_forced"{/if}>(доступно {$tovar.col} шт.)</span>
                            {if $tovar.year < 0}<span class="show_forced">Уценка: шины старше 3х лет</span>{/if}
                            {if $tovar.year > 0}<span class="show_forced">Уценка: шины {$tovar.year} года.</span>{/if}
                            {if $tovar.deliver_days}Поставка {$tovar.deliver_days} дн.{else}В наличии{/if}
                        </div>

                        {if $tovarInnerAlso}

                            {foreach from=$tovarInnerAlso item=$tInner}
                                <div class="product__price">
                                    {$tInner.priceFormated} ₽
                                    {if $tInner.price < $tInner.oldPrice}<div class="product__price-old">{$tInner.priceOldFormated} ₽</div>{/if}
                                </div>

                                {$tInner.add_basket}
                                {if $CURRENT_USER->role == 1 || $CURRENT_USER->role == 2}
                                    <div class="forCar"><a href="#popup__table" class="open__popup-table show_also_variants" data-id="{$tInner.id}">Еще варианты</a>
                                        {if $CURRENT_USER->role == 2}Зак.: {$tInner.b2b}{/if}</div>
                                    <div>Поставщик: {$viewer->getSellersName($tInner.sellers)}</div>
                                    <div>Артикул поставщика: {$viewer->getXmlCode($tInner.id)}</div>
                                    <div>OEM: {$tInner.OEM}</div>
                                    <div>Доступное количество: {$tInner.col}</div>
                                {/if}
                                <div>&nbsp;</div>
                                <div class="product__articule">
                                    Код товара: {$tInner.id}
                                    <span {if $tInner.col < 4}class="show_forced"{/if}>(доступно {$tInner.col} шт.)</span>
                                    {if $tInner.year < 0}<span class="show_forced">Уценка: шины старше 3х лет</span>{/if}
                                    {if $tInner.year > 0}<span class="show_forced">Уценка: шины {$tInner.year} года.</span>{/if}
                                    {if $tInner.deliver_days}Поставка {$tInner.deliver_days} дн.{else}В наличии{/if}
                                </div>
                            {/foreach}
                        {/if}
                    {/if}


                </div>
            </div>
        </div>
    </div>

    {if $tovar.about}
        <div class="product__desc">
            <div class="container-fluid">
                <div class="product__desc-title">
                    Описание<br>товара
                </div>
                <div class="product__desc-text">
                    {$tovar.about}
                </div>
            </div>
        </div>
    {/if}
    {if $similar_models != ''}
       <div class="product__more">
           <div class="product__more-title">
               Похожие товары
           </div>

{*            <div class="container-fluid">
                <div class="product__more-title">
                    Другие<br>товары
                </div>*}
                <div class="cards__product product__more-slider-">
                    <div class="product__more-slick- row">
                        {$similar_models}
                    </div>
                </div>

            </div>
        </div>
    {/if}
</section>