<div id="pathDiv">
	<input type="hidden" value="{$parent}" name="parentCategory" id="parentCategory" />
	<a href="/core/editSystem/0/" class="path">Корневой каталог</a><span class="small">&nbsp;/&nbsp;</span>
	{foreach item=data from=$path}
		<a href="/core/editSystem/{$data.id}/" class="path">{$data.title}</a><span class="small">&nbsp;/&nbsp;</span>
	{/foreach}
	<br />
	</div>
	<div id="dialog">
		<span id="close"></span><div id="newWin">Добавление новой категории</div>
		<div id="dialogContent">
			
		</div>
	</div>
	
	<div id="main">
		<div id="menu">
			<div id="menuHolder">
			{foreach item=data from=$menu}
				<a href="/core/editSystem/{$data.id}/" class="menu">{$data.title}</a>&nbsp;&nbsp;<a href="#" onclick="editCat({$data.id})" title="Редактировать"><img src="/core/i/ok.jpg" width="20" height="20" align="absmiddle" /></a>&nbsp;&nbsp;<a href="#" onclick="delCat({$data.id})" title="Удалить"><img src="/core/i/del.jpg" width="20" height="20" align="absmiddle" /></a>
				<img src="/core/i/moveUp.jpg" width="20" height="20" alt="Up" class="moveCategoryUp" onclick="moveCategoryUp({$data.id})" title="{$data.id}" align="absmiddle" />
				<img src="/core/i/moveDown.jpg" width="20" height="20" alt="down" class="moveCategoryDown" onclick="moveCategoryDown({$data.id})" title="{$data.id}"  align="absmiddle" />
				<br />
			{/foreach}
			</div>
			{if $menuCol==0}<br />
				<span class="small">Нет подкатегорий</span>
			{/if}
			<br />
<br />
			<img src="/core/i/add.jpg" width="20" height="20" align="absmiddle" />
				<a href="#addNewCategory" id="addNewCategoryLink" title="{$requestUrl}">Добавить новый подраздел</a>
		</div>
		
		<div id="content">
			
		</div>
		<hr />
		<center><img src="/core/i/addNewTxtBlock.jpg" width="40" height="40" align="absmiddle" onclick="addNewTxtBlock()" /><a onclick="addNewTxtBlock()">Добавить новый текстовый блок</a><br />
			<iframe src="/core/html_editor/?addTxtBlock=true&parent={$parent}" id="addNewBlock"></iframe>

		</center>
	</div>