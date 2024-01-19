<div><a href="/core/orders/">Все заказы</a>
</div>
	{if $showClient == false}

				<div id="tovar">
					<h1>Заказ № {$orderId}</h1>
					{if $fio != ""}
						<h3>ФИО заказчика: {$fio}</h3>
					{/if}

					{if $tel != ""}
						<h3>Телефон: {$tel}</h3>
					{/if}
					{if $contact != ""}
						<h3>Контактная информация: {$contact}</h3>
					{/if}
					<div>
					Статус заказа:
						<select name="main" id="chgStatus" title="{$orderId}">
							<option value="1" {if $status == 1}selected="selected"{/if}>&laquo;Заказ пока не просмотрен нашими менеджерами&raquo;</option>
							<option value="2" {if $status == 2}selected="selected"{/if}>&laquo;Заказ обрабатывается, мы свяжемся с Вами в кратчайшее время&raquo;</option>
							<option value="3" {if $status == 3}selected="selected"{/if}>&laquo;Заказ выполнен&raquo;</option>
							<option value="4" {if $status == 4}selected="selected"{/if}>&laquo;Заказ аннулирован&raquo;</option>
						</select>

					</div>
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr class="grey">
							<th colspan="4">
								Просмотр заказа:
							</th>
						</tr>
					{assign var=index value='0'}
					{foreach item=data from=$orderData}
						{if $index==0}
							{assign var=class value='white'}
							{assign var=index value='1'}
						{else}
							{assign var=index value='0'}
							{assign var=class value='grey'}
						{/if}

						<tr class="{$class}">
							<td width="20%">
								<h3 class="tovar"><a href="/buy/{$data.tId}/{$data.translit}.html">{$data.tTitle}</a></h3>

								<small>Производитель:</small><br />
								<h3 class="firm">{$data.fTitle}</h3>
							</td>
							<td class="imgHolder" width="20%">
								<a href="/buy/{$data.tId}/{$data.translit}.html"><img src="/image.php?id={$data.tId}" /></a>
								{if $data.also==1}
									<div>Стоимость единицы: <strong>{$data.priceFormated}&nbsp;{$data.znak}</strong></div>
								{else}
									<div>Стоимость единицы была неизвестна в день заказа</div>
								{/if}
							</td>
							<td width="40%">


									<div class="chgPrice">
										Если необходимо изменить стоимость единицы, впишите новое значение в указанное поле:
										<form action="" method="post">
											Стоимость единицы в рублях:
											<input type="text" value="" class="toCgh" name="value" />
											<input type="hidden" value="{$data.oId}" name="oId" />
											<input type="submit" name="sendRequest" value="Изменить стоимость" />

										</form>
									</div>

								Категория: <small><a href="/catalog/{$data.cId}/">{$data.cTitle}</a></small>
							</td>
							<td width="20%" class="col">
								<p class="colOrder">Количество:</p>
								<div class="colTovar" id="tovarCount{$data.oId}">{$data.col}</div>

								<div>
									{if $data.also==1}
									<p class="colOrder" >Сумма:</p>
									<p class="colOrder" id="sumCurrent{$data.oId}" >
										{$data.priceSumCurrent}&nbsp;{$data.znak}
									</p>
									{else}
										<p class="colOrder">Стоимость единицы была неизвестна в день заказа</p>
									{/if}

								</div>
							</td>
						</tr>

					{/foreach}
					</table>
					<div id="orderInfoHolder">

						{include file="../../templates/TableBusketSum.tpl"}

						<div>
						{if $status == 1}
							&laquo;Сумма заказа пока не перешла на Ваш накопительный баланс&raquo;
						{elseif $status == 2}
							&laquo;Сумма заказа пока не перешла на Ваш накопительный баланс&raquo;
						{elseif $status == 4}
							&laquo;Заказ аннулирован&raquo;
						{/if}
						</div>
					</div>
				</div>

		{/if}