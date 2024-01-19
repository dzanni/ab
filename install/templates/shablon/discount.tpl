<h2>Скидки:</h2>
{if $error}
	<div style="color:red">{$error}</div>
{/if}
<table cellpadding="4" cellspacing="0"><tr class="header">
<th width="300">Пороговая сумма (руб)</th><th width="150">Размер скидки (%)</th><th></th></tr>

{assign var=class value="white"}
{foreach item=data from=$discountAll}
<tr class="{$class}">
	<td>
		<input type="text" class="input" value="{$data.price}" title="{$data.id}" />
	</td>
	<td>
		<input type="text" class="input2" value="{$data.value}" title="{$data.id}" />
	</td>
	<td>
		<img src="/core/i/orderNot.gif" width="20" height="20" alt="Удалить" title="{$data.id}" class="delete" />
		<small class="input"  id="textInput{$data.id}">&mdash; Для редактирования измените значение в текстовом поле.</small>
	</td>
</tr>
{if $class=="grey"}
	{assign var=class value="white"}
{else}
	{assign var=class value="grey"}
{/if}
{/foreach}

</table>

<form action="{$requestUrl}" method="post">
	<h3>Добавление новой скидки</h3>
	<div><label for="price">Размер суммы-рубежа: </label><input type="text" name="price" id="price" class="i" /> руб.</div>
	<div><label for="value">Размер скидки: </label><input type="text" name="value" id="value" class="i" /> %</div>

	<input type="submit" class="submit" value="Добавить" name="addDiscount" />
</form>