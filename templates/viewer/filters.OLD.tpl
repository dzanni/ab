    <form id="filter-form" class="js_submit">
        <div class="filter__title">
            Фильтр
        </div>
        <div class="filter-form__wrap">
            {if $brand}
                <input type="hidden" name="brand" value="{$brand}">
             {/if}
            {foreach from=$filters key=i item=data}
            {* Заголовки прописываем один раз автоматически*}
                 <div class="filter-form__item">
                    <div class="filter-form__title">
                        {$data.optionTitle}
                    </div>
                     {if $data.type == 1}{*"input"*}
                        <div class="filter-form__search">
                             <input type="text" placeholder="Поиск" class="filter-form__search-input" id="page-catalog__product_{$data.options}" name="{$data.field}" value="{$data.selected}">
                            <button class="filter-form__search-btn" type="submit"></button>
                            <button class="filter-form__search-clear"></button>
                        </div>

                     {elseif $data.type == 2}{*"checkbox"*}
                         <div class="filter-form__values filter-form__hide" data-view="4" style="display: flex;">
                             {foreach from=$data.variants key=key item=d}
                             <label for="checkbox_item{$key}" class="filter-form__label label-check" style="display: flex;">
                                 <input type="checkbox" class="filter-form__check" id="checkbox_item{$key}" name="{$data.field}[]" value="{$d.value}" {if $d.selected}checked{/if}>
                                 <div class="filter-form__label-title">{$d.title}</div>
                             </label>
                             {/foreach}
                             <div class="filter-form__more">
                                 <div class="filter-form__arrow-more">
                                     <svg width="8" height="5" viewBox="0 0 8 5" fill="none" xmlns="http://www.w3.org/2000/svg">
                                         <path fill-rule="evenodd" clip-rule="evenodd" d="M7.63652 1.15718L6.82839 0.34906L3.99997 3.17749L1.17154 0.34906L0.363419 1.15718L3.99997 4.79373L7.63652 1.15718Z" fill="#4C5475"/>
                                     </svg>
                                 </div>
                             </div>
                         </div>

                     {elseif $data.type == 0}{*"select"*}

                     {* работает не корректно, проблема в JS *}
                     <div class="filter-form__values filter-form__hide">
                             <select name="{$data.field}" class="form__select">
                                 <option disabled>Выберите значение</option>
                                 {foreach from=$data.variants key=key item=d}
                                 <option value="{$d.value}">{$d.title}</option>
                                 {/foreach}
                             </select>
                         </div>

                       {* Альтернативный вариант - радио - работает корректно

                       {foreach from=$data.variants key=key item=d}
                       <div>
                       <input type="radio" id="radio_item{$key}" value="{$d.value}" name="{$data.field}" data-avto="{$d.title}" {if isset($data.selected) && $data.selected == $d.value}checked{/if}>
                            <label for="radio_item{$key}"><span>{$d.title}</span></label>
                       </div>
                        {/foreach}
                         <br>
                     <div>
                         <input type="radio" id=radio_item{$key} value="" name="{$data.field}" data-avto="" {if isset($data.selected) && $data.selected == $d.value}checked{/if}>
                         <label for="radio_item{$key}">Любые</label>
                     </div>*}


                   {elseif $data.type == 4}{*"range" - нет в верстке *}

                        <div class="filter-form__search">
                             От
                             <input type="text" class="filter-form__search-input" min="{$data.variants.min}" value="{if $data.selected.min}{$data.selected.min}{else}{$data.variants.min}{/if}" name="{$data.field}[min]">
                             до
                             <input type="text" class="filter-form__search-input" max="{$data.variants.max}" value="{if $data.selected.max}{$data.selected.max}{else}{$data.variants.max}{/if}"  name="{$data.field}[max]">
                         </div>

                     {/if}
                </div>
                {/foreach}

            <button class="btn__go" id="send_partners" type="submit" name="setFilter">Применить фильтр</button>
            <br>
         <button type="reset" class="btn__reset">Очистить фильтр</button>

        </div>
    </form>

