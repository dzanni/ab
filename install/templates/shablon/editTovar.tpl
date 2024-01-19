		{if $tovarDeleted==true}
			<h2>Товар был успешно удален</h2>
			<div><a href="/core/catalog/{$tovarLastData.cId}/">{$tovarLastData.cTitle}</a></div>
		{else}
			<div><a href="/core/catalog/{$tovarLastData.cId}/">{$tovarLastData.cTitle}</a></div>
            
            <div>
            	<a id="addSpec">Добавить спецпредложение на товар</a>
                <form action="/core/spec/" method="post" id="specForm">
                	<input type="hidden" name="tovarId" value="{$tovarData.id}" />
                	<div>
                    	<label for="specPrice">Новая стоимость (Руб.):</label>
                    	<input type="text" name="specPrice" id="specPrice" value="" />
                    </div>
                    <div>
                    	<label for="specDate1">Дата начала акции:</label>
                    	<input type="text" class="date_input" name="specDate1" id="specDate1" maxlength="10" value="{$currentDate}" />
                        по умолчанию начинается с сегодняшнего числа
                    </div>
                    <div>
                    	<label for="specDate2">Дата окончания:</label>
                    	<input type="text" class="date_input" name="specDate2" id="specDate2" maxlength="10" value="" />
                    </div>
                    <div>
                    	<label>&nbsp;</label>
                    	<input type="submit" name="sendRequestSpec" id="sendRequestSpec" value="Добавить" />
                    </div>
                    
                </form>
            </div>
            
			<div class="div">
				
				<label for="title" class="big">Наименование:</label><input title="{$tovarData.id}"  class="big" id="title" type="text" value="{$tovarData.title}" name="title" />
			</div>
			<div class="div">
				<br />Стоимость:<input type="text" class="price" title="{$tovarData.id}" value="{$tovarData.price}" />
				<select class="price" title="{$tovarData.id}">
					{foreach item=c from=$curs}
						{if $c.title==$tovarData.valuta}
							<option selected="selected">{$c.title}</option>
						{else}
							<option>{$c.title}</option>
						{/if}
					{/foreach}
				</select>
			</div>
			<div class="div">
				<div class="mainPict">
					<img src="/images/photo/{$tovarData.id}.jpg" />
					<form action="{$requestUrl}" method="post" enctype="multipart/form-data">
						Обновить/загрузить фото: <input type="file" name="filename" /><input name="addPhoto" value="Обновить" type="submit" class="submit" /> &mdash; поддерживаемый формат Jpeg
					</form>
				</div>
			</div>
			<div class="div">
					Производитель:
					<select id="firm" name="firm" title="{$tovarData.id}"  >
						{foreach item=f from=$firm}
							{if $f.title==$tovarData.fTitle}
								<option selected="selected" value="{$f.id}">{$f.title}</option>
							{else}
								<option value="{$f.id}">{$f.title}</option>
							{/if}
						{/foreach}
					</select>
			</div>
			<div>
				<div id="options">
					<table border="0" cellspacing="0" cellpadding="0" width="100%">
						<tr class="header"><td colspan="3">Технические характеристики:</td></tr>
							{foreach item=data from=$tovarData.options}
								{if $index==0}
								{assign var=class value='white'}
								{assign var=index value='1'}
							{else}
								{assign var=index value='0'}
								{assign var=class value='grey'}
							{/if}
							<form action="{$requestUrl}" method="post" >
							<tr class="{$class}"><td  class="title">{$data.title} </td><td class="value">
								
									<input value="{$data.text}" class="inTable" title="{$data.id}" />
								</td><td width="20">
									<input type="hidden" value="{$data.id}" name="attrId" />
									<input type="image" src="/core/i/orderNot.gif" width="20" height="20" name="deleteAttribute" />
								
								</td></tr>
							</form>
						{/foreach}
					</table>
					<br />
					<img src="/core/i/add.jpg" class="addNewAttr" width="20" height="20" alt="" align="absmiddle" /> <a href="#addNewTovarNotShow" class="addNewAttr"> Добавить новый атрибут</a>
					<div id="newAttribute">
						<form action="{$requestUrl}" method="post" id="formAttr" >
						<table border="0" cellspacing="0" cellpadding="0" width="100%">
							<tr class="header"><td colspan="3">Добавить атрибуты:</td></tr>
								{foreach item=data from=$attributeForAdd}
									{if $index==0}
										{assign var=class value='white'}
										{assign var=index value='1'}
									{else}
										{assign var=index value='0'}
										{assign var=class value='grey'}
									{/if}
								<tr class="{$class}"><td  class="title"><input type="hidden" name="optionId[]" value="{$data.id}" />{$data.title} </td><td class="value"><input title="{$tovarData.id}" value="" class="inTable2" name="text[]" /></td>
								<td width="20"><img src="/core/i/orderOk.gif" class="addAttrIbuteBtn" width="20" height="20" alt="" /></td>
								</tr>
							{/foreach}
								{if $index==0}
									{assign var=class value='white'}
									{assign var=index value='1'}
								{else}
									{assign var=index value='0'}
									{assign var=class value='grey'}
								{/if}
								<tr class="{$class}"><td colspan="3" class="addSNew">Добавление нового атрибута:</td></tr>
								<tr class="{$class}"><td  class="title"><input type="text" name="newTitle" value="" /> </td><td class="value"><input title="{$tovarData.id}" value="" class="inTable2" name="newText" /></td>
								<td width="20"><img src="/core/i/orderOk.gif" class="addAttrIbuteBtn" width="20" height="20" alt="" /></td>
								</tr>
						</table>
							<input type="hidden" name="addAttribute" value="" />
							<input type="submit" name="go" class="submit" value="Добавить заполеннные атрибуты" />
						</form>	
					</div>
				</div>
			</div><br />

			<div>
				<div id="about">
					<iframe src="/core/html_editor/?textEditorForTovar=true&tovarId={$tovarData.id}" id="txtEditor"></iframe>
				</div>
			</div>
			<div>
				<h2>Удаление товара из каталога</h2>
				<form action="{$requestUrl}" method="post">
					<input type="button" name="proveDelete" id="proveDelete" class="submit" value="Удалить товар" />
					<div id="deleteTovarDiv">
						<input type="hidden" name="tovarId" class="submit" value="{$tovarData.id}" />
						<input type="submit" name="permanentDeleteTovar" class="submit" value="Подтверждение удаления" />
						<br /><small>&mdash; удаленние происходит без возможности восстановления!</small>
					</div>
				</form>
			</div>
		{/if}