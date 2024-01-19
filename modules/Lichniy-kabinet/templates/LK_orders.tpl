<div class="orders__list">
    <h3>{$smarty_params.h1}</h3>
    {$msg_load_price}

    {if $rule_get}
    <table class="table_lk">
        <thead>
            <tr class="js_sort_block">
                {foreach from=$fields item=f}
                    {if !$f.notShow}
                    <th>
                        {$f.title}
                        {if $f.sort}
                            <a class="sort {if $f.field == $sort}selected{/if}" data-field="{$f.field}">&dArr;</a>
                            <a class="sort {if "`$f.field`_DESC" == $sort}selected{/if}" data-field="{$f.field}_DESC">&uArr;</a>
                        {/if}
                    </th>
                    {/if}
                {/foreach}
            </tr>
            <tr class="js_search_block">
                {foreach from=$fields item=f}
                    <th>
                        {if $f.search}
                            {if $f.v}
                                    <select class="js_search lk_select" data-field="s_{$f.field}">
                                        <option value="">Выберите значение</option>
                                        {foreach from=$f.v item=val}
                                            <option value="{$val.id}">{$val.title}</option>
                                        {/foreach}
                                    </select>
                            {else}
                                <span class="account__item-coment"><input type="text" class="js_search slyle_input order" data-field="s_{$f.field}"></span>
                            {/if}

                        {/if}

                    </th>
                {/foreach}
            </tr>
        </thead>
    </table>


        <div class="js_inner_result_data">
            {$html_inner}
        </div>




        <div class="js_pages">{$html_pages}</div>
    {/if}

    <div class="alerts"></div>
</div>