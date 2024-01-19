<div id="addMaket">
	<h3>Редактирование шаблонов</h3>
</div>
<form action="" method="post">
<table id="itemList" class="tablesorter" cellpadding="0" cellspacing="1">
	<thead> 
	<tr>
		<td class="ch" ><input type="checkbox" id="mainCH" /></td>
		<th class="first">Название шаблона</th>
		<th class="second">Дата изменения</th>
		<th class="second">Дата создания</th>
		<th class="first">Имя файла</th>
	</tr>
	</thead>
	<tbody>
	{foreach from=$shablonArray item=data}
						{if $index==0}
							{assign var=class value='white'}
							{assign var=index value='1'}
						{else}
							{assign var=index value='0'}
							{assign var=class value='grey'}
						{/if}
		<tr class="{$class}">
			<td><input type="checkbox" value="{$data.id}" class="maketCH" name="shablon[]" /></td>
			<td><a href="/install/shablon/{$data.id}/">{$data.title}</a></td>
			<td>{$data.dateFI}</td>
			<td>{$data.dateFC}</td>
			<td>{$data.titleEN}_{$data.date_}.tpl</td>
		</tr>
	{/foreach}
	</tbody>
</table>
	<input type="submit" value="Удалить отмеченные" class="submit" name="deleteSignedShablon" />
</form>
<a href="/install/addShablon/">Добавить шаблон</a>