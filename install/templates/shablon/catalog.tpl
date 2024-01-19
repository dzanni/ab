{foreach item=data from=$mainPath}
			{if $data.id<>$category}
				<a href="/core/{$page}/{$data.id}/" class="MainPath">{$data.title}</a> <span class="MainPath">/</span>
			{/if}
		{/foreach}
		
		<h1>{$h1title}</h1>
		
		{foreach item=data from=$daughterCategory}
			<a href="/core/{$page}/{$data.id}/" class="daughterCategory">{$data.title}{if $data.col<>""} <strong>({$data.col})</strong>{/if}</a>
		{/foreach}
		{if $colPages>1}
			<div class="pagesDivHolder">
				Страница: 
				{foreach item=data from=$pages}
					{if $data == $pageNumber}
						<span>{$data}</span> 
					{else}
						{if $desc==""}
							<a href="/core/{$page}/{$category}/page/{$data}/order/{$order}/">{$data}</a> 
						{else}
							<a href="/core/{$page}/{$category}/page/{$data}/order/{$order}/desc/">{$data}</a> 
						{/if}
					{/if}
				{/foreach}
				{if $desc==""}
					<a href="/core/{$page}/{$category}/page/all/order/{$order}/">Все страницы</a> 
				{else}
					<a href="/core/{$page}/{$category}/page/all/order/{$order}/desc/">Все страницы</a> 
				{/if}
			</div>
		{/if}
		
		<form action="{$requestUrl}" method="post">
		<div class="pagesDivHolder">
		<img src="/core/i/chgCat.gif" width="20" height="20" class="editPArentCategoryAdmin" alt="Изменить категорию" align="absmiddle" /> <a  class="editPArentCategoryAdmin">Переместить отмеченные в другую категорию </a>
		</div>
		<div id="catSelect">
			
		</div>
		
		<div class="pagesDivHolder">Сгруппировать указанные элементы
			<input type="text" id="grpTitle" name="grpTitle" value="Серия"  />
			<input type="submit" name="grpSelected" value="Сгруппировать" class="submit"  />
		</div>
		
		<table cellspacing="0" cellpadding="4" width="100%">
			<tr class="header"><th width="20"><input type="checkbox" class="checkBoxAll" /></th><th>Наименование</th><th width="140">Цена</th><th>Производитель</th><th>Категория</th><th>Группа</th><th>Заказ</th></tr>
		{foreach item=data from=$tovar}
			{if $index==0}
				{assign var=class value='white'}
				{assign var=index value='1'}
			{else}
				{assign var=index value='0'}
				{assign var=class value='grey'}
			{/if}

			<tr class="{$class}">
				<td><input type="checkbox" name="tovarId[]" value="{$data.id}" class="checkBox" /></td>
				<td><a href="/core/editTovar/{$data.id}/">{$data.title}</a></td>
				<td><input type="text" class="price" title="{$data.id}" value="{$data.price}" />
					<select class="price" title="{$data.id}">
					{foreach item=c from=$curs}
						{if $c.title==$data.valuta}
							<option selected="selected">{$c.title}</option>
						{else}
							<option>{$c.title}</option>
						{/if}
					{/foreach}
					</select>
					</td>
				<td>{$data.fTitle}</td>
				<td><a href="/core/catalog/{$data.cId}/">{$data.cTitle}</a></td>
				<td>{$data.grpTitle}</td>
				<td class="status">
					{if $data.also==0}
						<img src="/core/i/orderNot.gif" width="20" height="20" title="{$data.id}" alt="Недоступен для заказа" />
					{else}
						<img src="/core/i/orderOk.gif" width="20" height="20" title="{$data.id}" alt="Доступен для заказа" />
					{/if}
				</td>
			</tr>
		{/foreach}
		</table>
		</form>