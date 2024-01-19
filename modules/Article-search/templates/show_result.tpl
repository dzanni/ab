{if count($result.this_code)}
    <h2>Запрашиваемый артикул</h2>
    <table>
        <tr>
            <th>Номер</th>
            <th>Производитель</th>
            <th>Наименование</th>
            <th>Стоимость</th>
            <th>Количество</th>
            <th>Срок поставки</th>
            <th></th>
        </tr>
    {foreach from=$result.this_code item=res}
        {include file="{$path}show_result_table.tpl"}
    {/foreach}
    </table>
{/if}
{if count($result.analog)}
    <h2>Аналоги</h2>
    <table>
    <tr>
        <th>Номер</th>
        <th>Производитель</th>
        <th>Наименование</th>
        <th>Стоимость</th>
        <th>Количество</th>
        <th>Срок поставки</th>
    </tr>
    {foreach from=$result.analog item=res}
        {include file="{$path}show_result_table.tpl"}
    {/foreach}
    </table>
{/if}