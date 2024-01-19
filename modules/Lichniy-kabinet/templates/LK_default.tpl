<main>
    <div class="lk_menu">
    <h3>{$smarty_params.h1}</h3>
        {$msg_load_price}
 <div class="content__block">
    <table class="table_lk table__add">
        {if $rule_add}

            <h4 class="block__title">Добавление</h4>
            <tr>
            {foreach from=$fields item=f}
                {if $f.chg && !$f.notShow}
                    <th>{$f.title}</th>
                {/if}
            {/foreach}
            <th></th>
        </tr>
        <tr class="js_add_new_element">
            {foreach from=$fields item=f}
                {if $f.chg && !$f.notShow}
                    {if !$f.v}
                    <td>{if $f.search}<input type="text" class="js_add slyle_input" data-field="f_{$f.field}"  {if $f.notNull}data-notnull="{$f.field}"{/if}/> {/if}</td>
                    {else}
            <td>
                <select class="select js_add" data-field="f_{$f.field}" {if $f.notNull}data-notnull="{$f.field}"{/if}>
                    <option value="">Выберите значение</option>
                    {foreach from=$f.v item=val}
                        <option value="{$val.id}">{$val.title}</option>
                    {/foreach}
                </select>

            </td>
                        {/if}
                {/if}
            {/foreach}
            <td>
                <input type="hidden" class="js_add" data-field="add_new_element" value="1" />
                 <a class="js_add_new_obj account__button button">Добавить</a>
<div class="result"></div>
                <div class="js_showAll hidden">Применен фильтр по добавленной позиции <a class="js_remove_id_add_filer account__button">Вернуть исходный фильтр</a></div>
            </td>
        </tr>
        {/if}
    </table>

   {if $rule_get}<br>
   <h4  class="block__title">Редактирование</h4>

    <table class="table_lk table__edit">
        <thead>
            <tr class="js_sort_block">
                {foreach from=$fields item=f}
                    {if !$f.notShow}
                    <th>
                        {$f.title}
                        {if $f.sort}<a class="sort {if $f.field == $sort}selected{/if}" data-field="{$f.field}"><svg width="13" height="7" viewBox="0 0 13 7" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M0.543963 0.355547C0.587506 0.311894 0.639233 0.27726 0.696181 0.253629C0.75313 0.229998 0.814181 0.217834 0.875838 0.217834C0.937495 0.217834 0.998546 0.229998 1.05549 0.253629C1.11244 0.27726 1.16417 0.311894 1.20771 0.355547L6.50084 5.64961L11.794 0.355547C11.8375 0.311965 11.8893 0.277393 11.9462 0.253806C12.0032 0.23022 12.0642 0.21808 12.1258 0.21808C12.1875 0.21808 12.2485 0.23022 12.3054 0.253806C12.3624 0.277393 12.4141 0.311965 12.4577 0.355547C12.5013 0.39913 12.5359 0.450869 12.5595 0.507813C12.583 0.564756 12.5952 0.625787 12.5952 0.687422C12.5952 0.749057 12.583 0.810089 12.5595 0.867032C12.5359 0.923975 12.5013 0.975715 12.4577 1.0193L6.83271 6.6443C6.78917 6.68795 6.73744 6.72258 6.68049 6.74622C6.62355 6.76985 6.56249 6.78201 6.50084 6.78201C6.43918 6.78201 6.37813 6.76985 6.32118 6.74622C6.26423 6.72258 6.21251 6.68795 6.16896 6.6443L0.543963 1.0193C0.50031 0.975754 0.465676 0.924027 0.442045 0.867079C0.418414 0.81013 0.40625 0.749079 0.40625 0.687422C0.40625 0.625765 0.418414 0.564714 0.442045 0.507766C0.465676 0.450817 0.50031 0.39909 0.543963 0.355547Z" fill="#8E8E8E"/>
</svg></a><a class="sort {if "`$f.field`_DESC" == $sort}selected{/if}" data-field="{$f.field}_DESC"><svg width="13" height="7" viewBox="0 0 13 7" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M0.543963 6.64445C0.587506 6.68811 0.639233 6.72274 0.696181 6.74637C0.75313 6.77 0.814181 6.78217 0.875838 6.78217C0.937495 6.78217 0.998546 6.77 1.05549 6.74637C1.11244 6.72274 1.16417 6.68811 1.20771 6.64445L6.50084 1.35039L11.794 6.64445C11.8375 6.68804 11.8893 6.72261 11.9462 6.74619C12.0032 6.76978 12.0642 6.78192 12.1258 6.78192C12.1875 6.78192 12.2485 6.76978 12.3054 6.74619C12.3624 6.72261 12.4141 6.68804 12.4577 6.64445C12.5013 6.60087 12.5359 6.54913 12.5595 6.49219C12.583 6.43524 12.5952 6.37421 12.5952 6.31258C12.5952 6.25094 12.583 6.18991 12.5595 6.13297C12.5359 6.07602 12.5013 6.02429 12.4577 5.9807L6.83271 0.355702C6.78917 0.312049 6.73744 0.277416 6.68049 0.253785C6.62355 0.230154 6.56249 0.217989 6.50084 0.217989C6.43918 0.217989 6.37813 0.230154 6.32118 0.253785C6.26423 0.277416 6.21251 0.312049 6.16896 0.355702L0.543963 5.9807C0.50031 6.02425 0.465676 6.07597 0.442045 6.13292C0.418414 6.18987 0.40625 6.25092 0.40625 6.31258C0.40625 6.37423 0.418414 6.43529 0.442045 6.49223C0.465676 6.54918 0.50031 6.60091 0.543963 6.64445Z" fill="#8E8E8E"/>
</svg></a>{/if}
                    </th>
                    {/if}
                {/foreach}
            </tr>
            <tr class="js_search_block">
                {foreach from=$fields item=f}
                    {if !$f.notShow}
                    <th>
                        {if $f.search}
                            {if $f.v}
                                    <select class=" select js_search" data-field="s_{$f.field}">
                                        <option value="">Выберите значение</option>
                                        {foreach from=$f.v item=val}
                                            <option value="{$val.id}">{$val.title}</option>
                                        {/foreach}
                                    </select>
                            {else}
                                <input type="text" class="js_search slyle_input input_s_{$f.field}" data-field="s_{$f.field}">
                            {/if}

                        {/if}

                    </th>
                    {/if}
                {/foreach}
            </tr>
        </thead>
        <tbody class="js_inner_result_data table_lk_inner">
           {$html_inner}
        </tbody>
    </table>
        <div class="js_pages">{$html_pages}</div>
    {/if}

    <div class="alerts"></div>
    </div></div>
</main>