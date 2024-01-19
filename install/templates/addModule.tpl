<div id="addmodules">
	{if $type==add}
		<h3>Добавление модулей</h3>
	{else}
		<h3>Редактирование модулей</h3>
	{/if}
</div>
<form action="/install/modules/" id="modulesCreate" method="post">
<input type="hidden" name="moduleId" id="moduleId" value="{$modulesId}" />
<div id="innerNavigation">
	<a class="selected" title="html">Код модуля</a>
	<a title="other">Редактирование параметров модуля</a>
</div>
<div id="allEdit">
	<label for="title">
	{$title}Название модуля:</label>
	{if $type==add}
		<input type="text" class="text" name="title" id="title" value="Название модуля" onFocus="if(this.value=='Название модуля')this.value=''" >
	{else}
		<input type="text" class="text" name="title" id="title" value="{$modulesData.title}" >
	{/if}
	
	<span id="titleErr" class="error"></span>
</div>
<div id="inerForText">
<div id="otherEdit">
	<table id="variables" class="tablesorter" cellpadding="0" cellspacing="1">
	<thead> 
	<tr>
		<th class="varName">Имя переменной</th>
		<th class="varValue">Значение переменной</th>
		<th class="action">Действие</th>
	</tr>
	</thead>
	<tbody>
	
	{foreach item=data from=$modulesData.data}
		<tr class="item" id="item{$data.id}">
			<td><label for="var{$data.id}">{$data.var}</label></td>
			<td><input type="text" class="varValue" title="{$data.id}" value="{$data.value}" id="var{$data.id}" name="varValues[]" /></td>
			<td><a class="delete" title="{$data.id}"></a></td></tr>
	{/foreach}
	</tbody>
	</table>
	<p id="aditionalVars"></p>
	<p class="item"><h5>Добавить новые параметры для модуля</h5>
		<p><label for="varName">Имя переменной:</label> <input type="text" id="varName" name="" /></p>
		<p><label for="varValue">Значение переменной: </label><input type="text" id="varValue" value="{$data.value}" /></p>
		<p><input type="button" class="submit" id="addNewItems" value="Добавить" /></p>
	</p>
	
<input type="hidden" value="{$modulesData.categoryId}" id="MuduleCategoryId" />
<input type="hidden" value="{$modulesData.categoryTitle}" id="MuduleCategoryTitle" />
<div id="catSelect">
			
</div>

</div>

<div id="htmlEdit">
<textarea id="myCpWindowCSS" class="codepress php linenumbers-on textEditor">
{if $type==add}
<?php
/* php code for a module */

?>
{else}
{$modulesData.php}
{/if}
</textarea> 
<input type="hidden" name="php" id="phpText" value="" />
</div>


</div>

{if $type==add}
		<input type="hidden" name="addModules" />
		<input type="button" value="Добавить модуль" id="addMdl" class="submit" />
	{else}
		<input type="hidden" name="editModules" />
		<input type="hidden" name="modulesId" value="{$modulesId}" />
		<input type="button" value="Редактировать модуль" id="addMdl" class="submit" />
	{/if}

</form>

