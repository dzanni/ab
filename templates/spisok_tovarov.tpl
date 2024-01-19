{* Для вывода в слайдере нужен класс "product__more-slick-item", для вывода в обычном режиме - "col-12 col-sm-6 col-xl-4"*}
{foreach from=$tovar item=data} {* col-xl-4 *}
       <div class="{if $catalog_type == "slider"}product__more-slick-item{else}col-12 col-sm-6 {if $filter}col-xl-4{else}col-xl-3{/if}{/if}">
            {include file="{$path}tovar_card_small.tpl"}
        </div>
{/foreach}