<h1>Спецпредложения:</h1>
{if $error}
	<div style="color:red">{$error}</div>
{/if}
<table cellpadding="4" cellspacing="0" width="100%"><tr class="header">
	<th width="30%">Наименование товара</th>
    <th width="15%">Цена на сайте</th>
    <th width="15%">Спец. цена (руб.)</th>
	<th width="15%">Дата начала</th>
    <th width="15%">Дата окончания</th>
    <th width="10%"></th>
</tr>

{assign var=class value="white"}
{foreach item=data from=$spec}
<tr class="{$class}">
	<td class="text">
		<a href="/core/editTovar/{$data.id}/">{$data.title}</a>
	</td>
	<td>
    	{if $data.also}
			{$data.priceFormated}&nbsp;{$data.valuta}
        {else}
        	Стоимость неизвестна
        {/if}
	</td>
    <td>
		<input type="text" class="price small" value="{$data.specPrice}" title="{$data.id}" />
	</td>
    <td>
		<input type="text" class="date_input date1 small" value="{$data.date1Formated}" title="{$data.id}" />
	</td>
    <td>
		<input type="text" class="date_input date2 small" value="{$data.date2Formated}" title="{$data.id}" />
	</td>
	<td>
		<img src="/core/i/orderNot.gif" width="20" height="20" alt="Удалить" title="{$data.id}" class="delete" />
	</td>
</tr>
{if $class=="grey"}
	{assign var=class value="white"}
{else}
	{assign var=class value="grey"}
{/if}
{/foreach}

</table>
