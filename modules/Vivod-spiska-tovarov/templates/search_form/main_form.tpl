<div class="search__items-title-wrap">
    <div class="search__items-title">
        Подбор шин
    </div>
    {if $search_by_car}
        <div class="search__items-tab">
            <a href="#tab_params" class="search__items-link active">по параметрам</a>
            <a href="#tab_auto" class="search__items-link">по автомобилю</a>
        </div>
    {/if}
</div>
<div class="search__items-tabc">
    <form action="{$search_url}" class="search__form tab_params active">
        <div class="search__select-wrap">
            {$viewer->returnClassObj("search_form_generator")->renderParam("select", $params, "width")}
            {$viewer->returnClassObj("search_form_generator")->renderParam("select", $params, "height")}
            {$viewer->returnClassObj("search_form_generator")->renderParam("select", $params, "R")}
            {$viewer->returnClassObj("search_form_generator")->renderParam("select", $params, "firm")}
        </div>
        <div class="search__checkbox-wrap">
           {*

           Для данного проекта закардкодили порядок категорий

           {foreach from=$params.category.v item=s}
                <div class="search__form-checkbox">
                    <label class="search__label-checkbox">
                        <input type="checkbox" name="category[]" value="{$s.val}" {if $s.selected}checked="checked"{/if} class="search__checkbox">
                        <span class="search__checkbox-title">{$s.name}</span>
                    </label>
                </div>
            {/foreach}

             {if count($params.runflat.v)}
                <div class="search__form-checkbox">
                    <label class="search__label-checkbox">
                        <input type="checkbox" class="search__checkbox" name="rinflat" value="1" {if $params.runflat.v[0].selected}checked="checked"{/if}>
                        <span class="search__checkbox-title">Run on flat</span>
                    </label>
                </div>
            {/if}
            *}

            {foreach from=$params.category.v item=s}
                {if $s.name == "Летние шины"}
                <div class="search__form-checkbox">
                    <label class="search__label-checkbox">
                        <input type="checkbox" name="category[]" value="{$s.val}" {if $s.selected}checked="checked"{/if} class="search__checkbox">
                        <span class="search__checkbox-title">Летние</span>
                    </label>
                </div>
            {/if}
            {/foreach}

            {foreach from=$params.category.v item=s}
                {if $s.name == "Зимние шипованные"}
                    <div class="search__form-checkbox">
                        <label class="search__label-checkbox">
                            <input type="checkbox" name="category[]" value="{$s.val}" {if $s.selected}checked="checked"{/if} class="search__checkbox">
                            <span class="search__checkbox-title">Зимние шипованные</span>
                        </label>
                    </div>
                {/if}
            {/foreach}


            {if count($params.runflat.v)}
                <div class="search__form-checkbox">
                    <label class="search__label-checkbox">
                        <input type="checkbox" class="search__checkbox" name="rinflat" value="1" {if $params.runflat.v[0].selected}checked="checked"{/if}>
                        <span class="search__checkbox-title">RunFlat</span>
                    </label>
                </div>
            {/if}

            {foreach from=$params.category.v item=s}
                {if $s.name == "Зимние шины"}
                    <div class="search__form-checkbox">
                        <label class="search__label-checkbox">
                            <input type="checkbox" name="category[]" value="{$s.val}" {if $s.selected}checked="checked"{/if} class="search__checkbox">
                            <span class="search__checkbox-title">Зимние</span>
                        </label>
                    </div>
                {/if}
            {/foreach}

            {foreach from=$params.category.v item=s}
                {if $s.name == "Зимние нешипованные"}
                    <div class="search__form-checkbox">
                        <label class="search__label-checkbox">
                            <input type="checkbox" name="category[]" value="{$s.val}" {if $s.selected}checked="checked"{/if} class="search__checkbox">
                            <span class="search__checkbox-title">Зимние нешипованные</span>
                        </label>
                    </div>
                {/if}
            {/foreach}

            {foreach from=$params.category.v item=s}
                {if $s.name == "Всесезонные шины"}
                    <div class="search__form-checkbox">
                        <label class="search__label-checkbox">
                            <input type="checkbox" name="category[]" value="{$s.val}" {if $s.selected}checked="checked"{/if} class="search__checkbox">
                            <span class="search__checkbox-title">Всесезонные</span>
                        </label>
                    </div>
                {/if}
            {/foreach}


        </div>
       <button type="submit" class="button search__form-button">Показать результат</button>
    </form>
    {if $search_by_car}
        <form action="{$search_url}" class="search__form tab_auto">
{*{$search_by_car->setLeftFilter()}*}
            {$search_by_car->renderForm()}
         {*
         <button type="submit" class="js_scroll_result button search__form-button hidden">Показать результат</button>
         *}
            <a class="js_scroll_result button search__form-button hidden">Показать результат</a>
        </form>
    {/if}

</div>