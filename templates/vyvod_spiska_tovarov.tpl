<section class="filter__page container-fluid">

    {$filter}
    {*{include file="templates/viewer/admin_filters.tpl"}*}
    {$admin_filter}

    <div class="cards__product">
        <div class="container-fluid">
            {if count($subcats) > 0}
                <div class="row">
                    <div class="col-12">
                        <div class="product__category">
                            {foreach from = $subcats item=d}
                                <a href="{$d.URL}" class="product__category-link">
                                    <div class="product__category-img">
                                        <img src="/i/category/{$d.id}.jpg" alt="">
                                    </div>
                                    {$d.title}
                                </a>
                            {/foreach}
                        </div>
                    </div>
                </div>
            {/if}
            {* Сортировка пока скрыта *}
            {* <div class="row">
                 <div class="col-12">
                     <div class="product__sort">
                         <div class="product__sort-title">Сортировать:</div>
                         <a href="{$base_url_price}" class="product__sort-link {if $sort==array("price")}active{/if}">по цене</a>
                         <a href="{$base_url_popular}" class="product__sort-link {if $sort==array("id")}active{/if}">по id</a>
                     </div>
                 </div>
             </div>*}
            <div class="row">
                {$catalog}
            </div>

            {if (count($tovar) !== 0)}
                {if count($pages) != 1 && !$no_show_extra_params}
                    <div class="pagination">
                        {if $page_current != 1}
                            <a href="{$left_url}" class="pagination__prev pagination__arrow">
                                <img src="/i/icon__slider-prev.svg" class="svg" alt="">
                            </a>
                        {/if}

                        {foreach $pages as $p}
                            {if $p.page == "..."}
                                <span class="pagination__link">{$p.page}</span>
                            {else}
                                <a href="{$p.url}" class="pagination__link {if $p.active}active{/if}">{$p.page}</a>
                            {/if}
                        {/foreach}

                        {if $page_current != $p.page}
                            <a href="{$right_url}" class="pagination__next pagination__arrow">
                                <img src="/i/icon__slider-next.svg" class="svg" alt="">
                            </a>
                        {/if}
                    </div>
                {/if}
            {/if}

        </div>
    </div>

</section>