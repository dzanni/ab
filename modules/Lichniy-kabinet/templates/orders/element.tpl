{if $type == "input"}
    {if !$edit}<span class="element_value">{$val}</span>{/if}
    <input class="chg_element_value {if !$edit}chg_element_hide{/if} js_chg_order  slyle_input {if $field == "tel"}tel{/if}" type="text"  value="{$val}" data-field="{$field}">
{elseif $type == "textarea"}
    {if !$edit}<span class="element_value">{$val}</span>{/if}
    <textarea class="chg_element_value {if !$edit}chg_element_hide{/if} js_chg_order" type="text" data-field="{$field}">{$val}</textarea>
{elseif $type == "select"}
    {if !$edit}{$obj->render_value($field, $val)}{/if}
    {$obj->render_select($field, $val, $edit)}
{/if}