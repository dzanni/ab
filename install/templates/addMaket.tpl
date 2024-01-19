{if $maketEdit}
<div id="addMaket">
	{if $type==add}
		<h3>Добавление макетов</h3>
	{else}
		<h3>Редактирование макета</h3>
	{/if}
</div>
<form action="/install/maket/" id="maketCreate" method="post">
<div id="innerNavigation">
	<a class="selected" title="html">HTML</a>
	<a title="css">CSS</a>
	<a title="js">JavaScript</a>
</div>
<div id="allEdit">
	<label for="title">
	{$title}Название макета:</label>
	{if $type==add}
		<input type="text" class="text" name="title" id="title" value="Название макета" onFocus="if(this.value=='Название макета')this.value=''" >
	{else}
		<input type="text" class="text" name="title" id="title" value="{$maketData.title}" >
	{/if}
	
	<span id="titleErr" class="error"></span>
</div>
<div id="inerForText">

<div id="htmlEdit">
<textarea id="myCpWindow" class="codepress html linenumbers-on textEditor">
{if $type==add}
<!--  Вписывайте сюда html код макета. -->
{else}
{$maketData.html}
{/if}
</textarea> 
<input type="hidden" name="html"  id="htmlText" value="" />
</div>
<div id="cssEdit">
<textarea id="myCpWindowCSS" class="codepress css linenumbers-on textEditor">
{if $type==add}
/* CSS для макета */
{else}
{$maketData.css}
{/if}
</textarea> 
<input type="hidden" name="css" id="cssText" value="" />
</div>
<div id="jsEdit">
<textarea  id="myCpWindowJS" class="codepress javascript linenumbers-on textEditor">
{if $type==add}
// javascript для макета
// Библиотека jQuery подключена по умалчанию

{literal}jQuery(document).ready(function(){
	
});
{/literal}
{else}
	{$maketData.js}
{/if}
</textarea> 
<input type="hidden" name="js" id="jsText" value="" />
</div>
</div>

{if $type==add}
		<input type="hidden" name="addMaket" />
		<input type="button" value="Добавить макет" id="addMkt" class="submit" />
	{else}
		<input type="hidden" name="editMaket" />
		<input type="hidden" name="maketId" value="{$maketId}" />
		<input type="button" value="Редактировать макет" id="addMkt" class="submit" />
	{/if}

</form>

{else}

<div id="addShablon">
	{if $type==add}
		<h3>Добавление шаблонов</h3>
	{else}
		<h3>Редактирование шаблона</h3>
	{/if}
</div>
<form action="/install/shablon/" id="shablonCreate" method="post">
<div id="innerNavigation">
	<a class="selected" title="html">HTML</a>
	<a title="css">CSS</a>
	<a title="js">JavaScript</a>
</div>
<div id="allEdit">
	<label for="title">
	{$title}Название шаблона:</label>
	{if $type==add}
		<input type="text" class="text" name="title" id="title" value="Название шаблона" onFocus="if(this.value=='Название шаблона')this.value=''" >
	{else}
		<input type="text" class="text" name="title" id="title" value="{$shablonData.title}" >
	{/if}
	
	<span id="titleErr" class="error"></span>
</div>
<div id="inerForText">

<div id="htmlEdit">
<textarea id="myCpWindow" class="codepress html linenumbers-on textEditor">
{if $type==add}
<!--  Вписывайте сюда html код шаблона. -->
{else}
{$shablonData.html}
{/if}
</textarea> 
<input type="hidden" name="html"  id="htmlText" value="" />
</div>
<div id="cssEdit">
<textarea id="myCpWindowCSS" class="codepress css linenumbers-on textEditor">
{if $type==add}
/* CSS для шаблона */
{else}
{$shablonData.css}
{/if}
</textarea> 
<input type="hidden" name="css" id="cssText" value="" />
</div>
<div id="jsEdit">
<textarea  id="myCpWindowJS" class="codepress javascript linenumbers-on textEditor">
{if $type==add}
// javascript для шаблона
// Библиотека jQuery подключена по умалчанию

{literal}jQuery(document).ready(function(){
	
});
{/literal}
{else}
	{$shablonData.js}
{/if}
</textarea> 
<input type="hidden" name="js" id="jsText" value="" />
</div>
</div>

{if $type==add}
		<input type="hidden" name="addShablon" />
		<input type="button" value="Добавить шаблон" id="addShbln" class="submit" />
	{else}
		<input type="hidden" name="editShablon" />
		<input type="hidden" name="shablonId" value="{$shablonId}" />
		<input type="button" value="Редактировать шаблон" id="addShbln" class="submit" />
	{/if}

</form>
{/if}
