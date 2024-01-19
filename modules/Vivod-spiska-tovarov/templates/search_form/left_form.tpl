<div  class="filter">

    <div class="filter__wrap">
        {if $search_by_car}
            <div class="search__items-tab">
                <a class="search__items-link {if !$search_by_car->getVar('modification')}active{/if} js_first_form_on">по параметрам</a>
                <a class="search__items-link {if $search_by_car->getVar('modification')}active{/if} js_second_form_on">по автомобилю</a>
            </div>
        {/if}


        {if $search_by_car}
            <form action="{$search_url}" class="js_second_search_form search__form tab_auto" data-type="{$search_by_car->get_is_search()}">
                {$search_by_car->renderForm()}
                {* <a class="js_scroll_result button filter__button hidden">Показать результат</a>*}

                <br><br>
                <div class="shina_disk_search_result">{$search_by_car->renderVariants()}</div>
                <br><br>
            </form>
        {/if}


        <form action="{$search_url}" class="js_first_search_form">
            <div class="filter__title">
                Фильтр
                <a href="{$search_url}" class="filter_clear">Очистить</a>
            </div>

            <div class="filter__block">
                <div class="filter__subtitle">Ширина
                    <span class="filter__arrow">
                    <img src="/i/icon__arrow.svg" alt="" class="svg">
                </span>
                </div>
                <div class="filter__value">
                    {$viewer->returnClassObj("search_form_generator")->renderParam("select_inner_form", $params, "width")}
                </div>
            </div>
            <div class="filter__block">
                <div class="filter__subtitle">Высота
                    <span class="filter__arrow">
                    <img src="/i/icon__arrow.svg" alt="" class="svg">
                </span>
                </div>
                <div class="filter__value">
                    {$viewer->returnClassObj("search_form_generator")->renderParam("select_inner_form", $params, "height")}
                </div>
            </div>
            <div class="filter__block">
                <div class="filter__subtitle">Диаметр
                    <span class="filter__arrow">
                    <img src="/i/icon__arrow.svg" alt="" class="svg">
                </span>
                </div>
                <div class="filter__value">
                    {$viewer->returnClassObj("search_form_generator")->renderParam("select_inner_form", $params, "R")}
                </div>
            </div>

            <div class="filter__block">
                <div class="filter__subtitle">Производитель
                    <span class="filter__arrow">
                    <img src="/i/icon__arrow.svg" alt="" class="svg">
                </span>
                </div>
                {$viewer->returnClassObj("search_form_generator")->renderParam("checkbox_list", $params, "firm")}
            </div>

            <div class="filter__block">
                <div class="filter__subtitle">Сезон
                    <span class="filter__arrow">
                    <img src="/i/icon__arrow.svg" alt="" class="svg">
                </span>
                </div>
                {$viewer->returnClassObj("search_form_generator")->renderParam("checkbox_list", $params, "category")}
            </div>

            {if count($params.runflat.v)}
                <div class="filter__block">
                    <div class="filter__subtitle">Run on flat
                        <span class="filter__arrow">
								<img src="/i/icon__arrow.svg" alt="" class="svg">
							</span>
                    </div>
                    <div class="filter__value" data-view="0">
                        <label class="filter__check">
                            <input type="checkbox" value="1" name="runflat" class="filter__check-input"
                                   {if $params.runflat.v[0].selected}checked="checked"{/if}>
                            <span class="filter__check-title">Run on flat</span>
                        </label>
                    </div>
                </div>
            {/if}

            {if $params.price}
                <div class="filter__block filter__price-wrap">
                    <div class="filter__subtitle">Цена, ₽</div>

                    <div class="filter__price-inputs">
                        <input type="text" class="filter__price-input filter__price-min" min="{$params.price.v.min_price}"
                               value="{if $params.price.v.min_curr}{$params.price.v.min_curr}{else}{$params.price.v.min_price}{/if}"
                               name="price[min]">
                        -
                        <input type="text" class="filter__price-input filter__price-max" max="{$params.price.v.max_price}"
                               value="{if $params.price.v.max_curr}{$params.price.v.max_curr}{else}{$params.price.v.max_price}{/if}"
                               name="price[max]">
                    </div>
                    <div class="filter__price"></div>
                </div>
            {/if}
            <button type="submit" class="button filter__button">Найти товары</button>
        </form>

        {$viewer->getAdminFilters()}

    </div>



</div>