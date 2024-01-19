<h2>Редактирование курса валют:</h2>
{foreach item=data from=$curs}
	<div class="inptHolder">
		{$data.title} = <input type="text" class="input" value="{$data.value}" title="{$data.title}" /> <strong>RUR</strong>
		
	</div>
{/foreach}
<small>&mdash; Для редактирования измените значение в текстовом поле.</small>