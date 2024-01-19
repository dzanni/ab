<h2>Скидки:</h2>
{if $error}
	<div style="color:red">{$error}</div>
{/if}
<table cellpadding="4" cellspacing="0"><tr class="header">
<th width="300">Название</th><th width="60">

{assign var=class value="white"}
{foreach item=data from=$optionsAll}
<tr class="{$class}" id="tr{$data.id}">
	<td>
		<input type="text" class="input" value="{$data.title}" title="{$data.id}" />
	</td>
	<td>
		{if $data.main}
        	<a class="main" alt="Важное свойство" title="{$data.id}"></a>
        {else}
        	<a class="mainOff" alt="Важное свойство" title="{$data.id}"></a>
        {/if}
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

<form action="{$requestUrl}" method="post">
	<h3>Добавление новой характеристики</h3>
	<div><label for="title">Название: </label><input type="text" name="title" id="title" class="i" /> руб.
		<select name="main">
        	<option value="0">Обычное свойство</option>
            <option value="1">Основное свойство</option>
        </select>
    </div>

	<input type="submit" class="submit" value="Добавить" name="addOption" />
</form>