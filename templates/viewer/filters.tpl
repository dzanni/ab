{if count($filters) > 0}
<form class="filter">
    <div class="filter__title">
        Фильтр
        <a class="js_filter_clear filter_clear">Очистить</a>
    </div>
    <div class="filter__wrap">
        {if $brand}
            <input type="hidden" name="brand" value="{$brand}">
        {/if}
        {foreach from=$filters key=i item=data}

            <div class="filter__block {if $data.type == 4}filter__price-wrap{/if}">{* Для range ставим дополнительный класс*}
                <div class="filter__subtitle">{$data.optionTitle}
                   {if $data.type != 4}{* Для range не ставим стрелку закрыть-открыть фильтр, так как прокрутка все равно не закроется*}
                    <span class="filter__arrow">
						<img src="/i/icon__arrow.svg" alt="" class="svg">
				    </span>
                    {/if}
                </div>

                {if $data.type == 1}{*"input"*}
                <div class="filter__value">
                    <label class="filter__input-inputs">
                        <input type="text" class="filter__input-input" id="page-catalog__product_{$data.options}" name="{$data.field}" value="{$data.selected}">
                        <span class="filter__input-icon">
					    <img src="/i/icon__search.svg" class="svg" alt="">
					</span>
                    </label>
                </div>

                {elseif $data.type == 2}{*"checkbox"*}
                    <div class="filter__value {if count($data.variants) > 5}filter__scroll{/if}" {if count($data.variants) > 2 && count($data.variants) < 6}data-view="2"{/if}>
                        {foreach from=$data.variants key=key item=d}
                            <label for="checkbox_item{$i}_{$key}" class="filter__check">
                                <input type="checkbox" class="filter__check-input" id="checkbox_item{$i}_{$key}" name="{$data.field}[]" value="{$d.value}" {if $d.selected}checked{/if}>
                                <span class="filter__check-title">{$d.title}</span>
                            </label>
                        {/foreach}
                    </div>

                {elseif $data.type == 0}{*"select"*}
                <div class="filter__value">
                    {if count($data.variants) < 6}{* До пяти позиций - радио-кнопки, иначе выпадающйи список*}
                        {foreach from=$data.variants key=key item=d}
                            <label class="filter__radio" for="radio_item{$i}_{$key}">
                                <input type="radio" class="filter__radio-input" id="radio_item{$i}_{$key}" value="{$d.value}" name="{$data.field}" data-avto="{$d.title}" {if isset($data.selected) && $data.selected == $d.value}checked{/if}>
                                <span class="filter__radio-title">{$d.title}</span>
                            </label>
                        {/foreach}
                            <label class="filter__radio" for="radio_item{$i}">
                                <input type="radio" class="filter__radio-input" id="radio_item{$i}" value="" name="{$data.field}" data-avto="" {if !isset($data.selected) || $data.selected != $d.value}checked{/if}>
                                <span class="filter__radio-title">Любые</span>
                            </label>
                    {else}
                        <select name="{$data.field}" class="filter__select">
                            <option></option>
                            {foreach from=$data.variants key=key item=d}
                                <option value="{$d.value}" {if isset($data.selected) && $data.selected == $d.value}selected{/if}>{$d.title}</option>
                            {/foreach}
                        </select>
                    {/if}
                </div>

                {elseif $data.type == 4}{*"range"*}
                    <div class="filter__price-inputs">
                        <input type="text" class="filter__price-input filter__price-min" min="{$data.variants.min}" value="{if $data.selected.min}{$data.selected.min}{else}{$data.variants.min}{/if}" name="{$data.field}[min]">
                        -
                        <input type="text" class="filter__price-input filter__price-max" max="{$data.variants.max}" value="{if $data.selected.max}{$data.selected.max}{else}{$data.variants.max}{/if}" name="{$data.field}[max]">
                    </div>
                    <div class="filter__price"></div>
                {/if}

            </div>
        {/foreach}

        <button type="submit" class="button filter__button" id="send_partners" name="setFilter">Найти товары</button>
    </div>
</form>
{else}
    <form class="filter">
        <div class="filter__title">
            Фильтр
         </div>
        <div class="filter__wrap">
        Фильтр для этой категории не активирован
        </div>
    </form>

{/if}