<form action="{$requestUrl}" method="post" enctype="multipart/form-data">

	<div class="infoHolder">
		<label>Изображение</label><input type="file" name="filename" >
	</div>
	<div class="infoHolder">
		<label>Наименование</label><input type="text" name="title" value="" >
	</div>
	
	
	
	<div class="infoHolder">
		<label>Цена</label><input type="text" name="price" id="price" value="" class="small" >
		<select class="price" name="valuta" title="{$data.id}"  >
			{foreach item=c from=$curs}
				<option value="{$c.title}">{$c.title}</option>
			{/foreach}
		</select>
		<input type="checkbox" name="also" id="also" class="checkbox"> <label for="also" id="also">отображать цену на сайте</label>
	</div>
	<div class="infoHolder">
		<label>Выбор категории для товара</label>
		<div id="catSelect"></div>
	</div>
	<div class="infoHolder">
		Производитель:
		<select class="firm" name="firm" title="{$data.id}"  >
			{foreach item=f from=$firm}
				<option value="{$f.id}">{$f.title}</option>
			{/foreach}
		</select>
	</div>
	<div class="infoHolder">
		Описание товара:<br>
		<textarea name="about" style="width:600px; height:300px;"></textarea>
	</div>
	{foreach item=data from=$dataTitles}
		<div class="infoHolder">
			<label>{$data.title}</label><input type="hidden" name="dataTitle[]" value="{$data.title}" ><input type="text" name="data[]" value="" >
		</div>
	{/foreach}
	<div class="infoHolder">
		<input type="submit" name="go" value="Добавить товар в каталог" >
	</div>
</form>