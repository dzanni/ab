<div id="addModules">
	<h3>Редактирование модулей</h3>
</div>
<form action="" method="post">
<table id="itemList1" class="tablesorter" cellpadding="0" cellspacing="1">
	<thead> 
	<tr>
		<td class="ch" ><input type="checkbox" id="mainCH" /></td>
		<th class="id">id</th>
		<th class="name">Название модуля</th>
		<th class="date">Дата изменения</th>
		<th class="filename">Имя файла</th>
		<th class="url">URL</th>
		<th class="select">Макет для модуля</th>
		<th class="select">Шаблон для модуля</th>
		<th class="onOff">Вкл / Выкл</th>
	</tr>
	</thead>
	<tbody>
	{foreach from=$modulesArray item=data}
						{if $index==0}
							{assign var=class value='white'}
							{assign var=index value='1'}
						{else}
							{assign var=index value='0'}
							{assign var=class value='grey'}
						{/if}
		<tr class="{$class}">
			<td class="ch"><input type="checkbox" value="{$data.id}" class="ModulesCH" name="Modules[]" /></td>
			<td class="id">{$data.id}</td>
			<td><a href="/install/modules/{$data.id}/">{$data.title}</a></td>
			<td class="date">{$data.dateFI}</td>
			<td class="filename">{$data.titleEN}_{$data.date_}.php</td>
			<td><input type="text" name="enURL" id="enURL{$data.id}" class="enURL" title="{$data.id}" value="{$data.enURL}"  {if $data.category > 0} disabled="disabled" {/if}  /></td>
			
			<td>
				<select id="maket{$data.id}" class="maket" title="{$data.id}" {if $data.enURL==''} disabled="disabled" {/if} {if $data.category > 0} disabled="disabled" {/if} >
					{if $data.category > 0}
						<option value="0"  selected="selected">От категории</option>
					{else}
					
					{if $data.maket == 0}
							<option value="0"  selected="selected">Макет не установлен</option>
						{else}
							<option value="0">Макет не установлен</option>
						{/if}
					{foreach from=$allMaket item=data2}
						
						{if $data.maket == $data2.id}
							<option value="{$data2.id}"  selected="selected">{$data2.title}</option>
						{else}
							<option value="{$data2.id}">{$data2.title}</option>
						{/if}
					{/foreach}
					
					{/if}
				</select>
			</td>
			<td><select id="shablon{$data.id}" class="shablon" title="{$data.id}" {if $data.category > 0} disabled="disabled" {/if} {if $data.enURL==''} disabled="disabled" {/if}>
					{if $data.category > 0}
						<option value="0"  selected="selected">От категории</option>
					{else}
					
					{if $data.shablon == 0}
							<option value="0"  selected="selected">Шаблон не установлен</option>
						{else}
							<option value="0">Шаблон не установлен</option>
						{/if}
					{foreach from=$allShablon item=data2}
						
						{if $data.shablon == $data2.id}
							<option value="{$data2.id}"  selected="selected">{$data2.title}</option>
						{else}
							<option value="{$data2.id}">{$data2.title}</option>
						{/if}
					{/foreach}
				
					{/if}
				</select></td>
			<td>
				<a class="status status{$data.status}" title="{$data.id}"></a>
			</td>
		</tr>
	{/foreach}
	</tbody>
</table>
	<input type="submit" value="Удалить отмеченные" class="submit" name="deleteSignedModules" />
</form>
<a href="/install/addModule/">Добавить модуль</a>