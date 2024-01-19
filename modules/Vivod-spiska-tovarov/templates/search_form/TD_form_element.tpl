{if $params}
    {if $param_type_view == "select" || $param_type_view == "select_inner_form"}
        <select class="{if $param_type_view == "select"}search__form-select{else}filter__select{/if}" name="{$params.key}" data-placeholder="{$params.name}">
            <option></option>
            {foreach from=$params.v item=v}
                <option value="{$v.val}" {if $v.selected}selected="selected"{/if}>{$v.name}</option>
            {/foreach}
        </select>
    {elseif $param_type_view == "checkbox_list"}

        {if $param=="category"}<!--Хардкодим порядок отображения для СЕЗОНА шин GP TYRES-->
            <div class="filter__value" data-view="0">

                {assign var="par" value=array($params.v.4, $params.v.2, $params.v.3, $params.v.1, $params.v.0)}

                {foreach from=$par key=k item=v}
                        <label class="filter__check">
                            <input type="checkbox" value="{$v.val}" name="{$params.key}[]" class="filter__check-input" {if $v.selected}checked=checked{/if}>
                            <span class="filter__check-title">
                                {if $v.name == "Летние шины"}Летние
                                {elseif $v.name == "Зимние шины"}Зимние
                                {elseif $v.name == "Всесезонные шины"}Всесезонные
                                {else}
                                {$v.name}
                                {/if}
                            </span>
                        </label>
                {/foreach}

            </div>

        {else}
        <div {if count($params.v) > 5}class="filter__value filter__scroll"{else}class="filter__value" data-view="2"{/if}>
            {foreach from=$params.v item=v}
                <label class="filter__check">
                    <input type="checkbox" value="{$v.val}" name="{$params.key}[]" class="filter__check-input" {if $v.selected}checked=checked{/if}>
                    <span class="filter__check-title">{$v.name}</span>
                </label>
            {/foreach}
        </div>
        {/if}

    {/if}
{/if}
