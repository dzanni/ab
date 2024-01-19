{if $search_by_car->get_is_search() || $variant.result_output == 1}
    <div class="js_scroll_result_anchor">

        {if isset($shina) && count($shina.1)+count($shina.2)+count($shina.3) > 0}
            <div class="filter__block">
                <div class="filter__subtitle result">Варианты шин на автомобиль</div>
                {foreach from=$shina key=key item=data}
                    {if count($data) > 0}
                        <div class="filter__subtitle_inner">
                            {if $key ==1}Заводские размеры:
                            {elseif $key ==2}Варианты замены:
                            {elseif $key==3}Тюнинг:{/if}
                        </div>
                        <div class="filter__result">
                            {foreach from=$data item=data1}
                                <a href="{$search_by_car->getVar('searchURL')}?width={$data1.width}&height={$data1.height}&R={$data1.radius}&car={$search_by_car->getVar('car')}&model={$variant.model}&year={$variant.year}&modification={$variant.modification}&idShini={$data1.id}">
                                    {$data1.width}/{$data1.height}&nbsp;R{$data1.radius}</a>
                            {/foreach}
                        </div>
                    {/if}
                {/foreach}
            </div>
        {/if}

        {if isset($disk) && count($disk.1)+count($disk.2)+count($disk.3) > 0}
            <div class="filter__block">
                <div class="filter__subtitle result">Варианты дисков на автомобиль</div>
                <div class="filter__subtitle_inner">Параметры автомобиля:</div>
                <div class="filter__result">PCD: {$variant.pcd_col}x{$variant.pcd_val}
                    DIA: {$variant.dia}</div>
                <div class="filter__subtitle_inner">{if $variant.is_bolt == 1}Болт:{else}Гайка:{/if}</div>
                <div class="filter__result">{$variant.bolt}</div>
                {foreach from=$disk key=key item=data}
                    {if count($data) > 0}
                        <div class="filter__subtitle_inner">
                            {if $key ==1}Заводские размеры:
                            {elseif $key ==2}Варианты замены:
                            {elseif $key==3}Тюнинг:{/if}
                        </div>
                        <div class="filter__result">
                            {foreach from=$data item=data1}
                                <a href="{$search_by_car->getVar('searchURL')}?width={$data1.w}&R={$data1.radius}&pcd_val={$variant.pcd_val}&pcd_col={$variant.pcd_col}&ET={$data1.ET}&DIA={$variant.dia}&model={$variant.model}&year={$variant.year}&modification={$variant.modification}&car={$search_by_car->getVar('car')}&idShini={$data1.id}">{$data1.w}
                                    x{$data1.radius}&nbsp;ET{$data1.ET}</a>
                            {/foreach}
                        </div>
                    {/if}
                {/foreach}
            </div>
        {/if}

    </div>
{else}
    <br>
    <section class="search ver_01">
        <section class="search__result js_scroll_result_anchor">
            <div class="container-fluid">
                <div class="search__result-wrap">

                    {if isset($shina)}
                        <div class="search__result-item">
                            <div class="search__result-title">Варианты шин на автомобиль</div>
                            {foreach from=$shina key=key item=data}
                                {if count($data) > 0}
                                    <div class="search__result-subtitle">
                                        {if $key ==1}Заводские размеры:
                                        {elseif $key ==2}Варианты замены:
                                        {elseif $key==3}Тюнинг:{/if}
                                    </div>
                                    <div class="search__result-info">
                                        {foreach from=$data item=data1}
                                            <a href="{$search_by_car->getVar('searchURL')}?width={$data1.width}&height={$data1.height}&R={$data1.radius}&car={$search_by_car->getVar('car')}&model={$variant.model}&year={$variant.year}&modification={$variant.modification}&idShini={$data1.id}">
                                                {$data1.width}/{$data1.height}&nbsp;R{$data1.radius}</a>
                                        {/foreach}
                                    </div>
                                {/if}
                            {/foreach}
                        </div>
                    {/if}

                    {if isset($disk)}
                        <div class="search__result-item">
                            <div class="search__result-title">Варианты дисков на автомобиль</div>
                            <div class="search__result-subtitle">Параметры автомобиля:</div>
                            <div class="search__result-info">PCD: {$variant.pcd_col}x{$variant.pcd_val}
                                DIA: {$variant.dia}</div>
                            <div class="search__result-subtitle">{if $variant.is_bolt == 1}Болт:{else}Гайка:{/if}</div>
                            <div class="search__result-info">{$variant.bolt}</div>
                            {foreach from=$disk key=key item=data}
                                {if count($data) > 0}
                                    <div class="search__result-subtitle">
                                        {if $key ==1}Заводские размеры:
                                        {elseif $key ==2}Варианты замены:
                                        {elseif $key==3}Тюнинг:{/if}
                                    </div>
                                    <div class="search__result-info">
                                        {foreach from=$data item=data1}
                                            <a href="{$search_by_car->getVar('searchURL')}?width={$data1.w}&R={$data1.radius}&pcd_val={$variant.pcd_val}&pcd_col={$variant.pcd_col}&ET={$data1.ET}&DIA={$variant.dia}&model={$variant.model}&year={$variant.year}&modification={$variant.modification}&car={$search_by_car->getVar('car')}&idShini={$data1.id}">{$data1.w}
                                                x{$data1.radius}&nbsp;ET{$data1.ET}</a>
                                        {/foreach}
                                    </div>
                                {/if}
                            {/foreach}
                        </div>
                    {/if}

                </div>
            </div>
        </section>
    </section>
{/if}