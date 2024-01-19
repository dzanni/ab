<h2>Список производителей:</h2>
<ol>
{foreach item=data from=$firmAll}
	<li class="inptHolder" id="li{$data.id}">
		<input type="text" class="input" value="{$data.title}" title="{$data.id}" />
		{if $data.delete==true}
			<img src="/core/i/orderNot.gif" width="20" height="20" alt="Удалить" title="{$data.id}" class="delete" />
		{else}
			<img src="/core/i/orderNot2.gif" width="20" height="20" alt="Удалить" title="{$data.id}" class="deleteNot" />
			<small class="delete" id="text{$data.id}">&mdash; Удаление невозможно, на производителя ссылаются товары. Сначала необходимо удалить их.</small>
		{/if}
		<small class="input"  id="textInput{$data.id}">&mdash; Для редактирования измените значение в текстовом поле.</small>
	</li>
{/foreach}
</ol>

<form action="{$requestUrl}" method="post">
	<h3>Добавление нового производителя</h3>
	<label for="title">Наименование: </label><input type="text" name="title" id="title" class="i" />
	<input type="submit" class="submit" value="Добавить" name="addFirm" />
</form>