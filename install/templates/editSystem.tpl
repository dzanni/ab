<div id="pathDiv1">
	<input type="hidden" value="{$parent}" name="parentCategory" id="parentCategory" />
	<br>
	<a href="/install/editSystem/-1/" class="path">Сайт</a><span class="small">&nbsp;/&nbsp;</span>
	<a href="/install/editSystem/0/" class="path">Корневой каталог</a><span class="small">&nbsp;/&nbsp;</span>
	
	{foreach item=data from=$path}
		<a href="/install/editSystem/{$data.id}/" class="path">{$data.title}</a><span class="small">&nbsp;/&nbsp;</span>
	{/foreach}

	</div>
	<table id="itemList" class="tablesorter" cellpadding="0" cellspacing="1">
	<thead> 
	<tr>
		<th width="34%">Название категории</th>
		<th width="33%">Макет</th>
		<th width="33%">Шаблон</th>
	</tr>
	</thead>
	<tbody>
	{foreach item=data from=$menu}
	
						{if $index==0}
							{assign var=class value='white'}
							{assign var=index value='1'}
						{else}
							{assign var=index value='0'}
							{assign var=class value='grey'}
						{/if}
		<tr class="{$class}">
			<td><a href="/install/editSystem/{$data.id}/" class="menu">{$data.title}</a></td>
			<td>
				<select id="maket{$data.id}" class="maket" title="{$data.id}">
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
				</select>
			</td>
			<td><select id="shablon{$data.id}" class="shablon" title="{$data.id}">
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
				</select></td>
		</tr>
	{/foreach}
	</tbody>
</table>