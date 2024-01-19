<option value="0">Ничего не выбрано</option>
{foreach from=$cities item=data}
    <option value="{$data.id}">{$data.title}</option>
{/foreach}
