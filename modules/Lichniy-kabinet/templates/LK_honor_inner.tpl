{foreach from=$result item=$res}
    <tr {if $rule_edit}class="js_chg_row"{/if}>
        {foreach from=$fields item=f}
            {if !$f.notShow}
                <td class="td_f_{$f.field}">
                    {assign var="field" value=$f.field}
                    {if $f.v}
                        {assign var="value" value=''}
                            {capture name="select_chg"}
                            <select class="js_chg select hidden" data-field="f_{$f.field}" data-id="{$res.id}" >
                                {foreach from=$f.v item=val}
                                    {if $val.id == $res.$field}
                                        {assign var="value" value=$val.title}
                                    {/if}
                                    <option value="{$val.id}" {if $val.id == $res.$field}selected="selected"{/if}>{$val.title}</option>
                                {/foreach}
                            </select>
                            {/capture}
                            {if $f.chg && $rule_edit}{$smarty.capture.select_chg}{/if}

                            <span {if $f.chg}class="js_val"{/if}>{$value}</span>
                    {else}
                        <span {if $f.chg}class="js_val"{/if}>{$res.$field}</span>
                        {if $f.chg && $rule_edit}
                            <input type="text" class="js_chg hidden slyle_input input_s_{$f.field}"  data-field="f_{$f.field}" value="{$res.$field}" data-id="{$res.id}" />
                        {/if}
                    {/if}
                </td>
            {/if}
        {/foreach}
        <td>

            {if $rule_edit}<a class="js_set_edit lk_icon" alt="Редактировать">
            <svg class="svg-sprite-icon icon-icon__q-edit">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-edit"></use>
                              </svg>
            {/if}
        </td>
        <td>

            {if $rule_remove}
                <a class="js_set_remove lk_icon" alt="Удалить" data-id="{$res.id}">
                    <svg class="svg-sprite-icon icon-icon__q-del">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-del"></use>
                              </svg>
                </a>
            {/if}
        </td>
    </tr>
{/foreach}