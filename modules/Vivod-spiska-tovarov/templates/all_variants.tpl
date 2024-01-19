{if $role > 0}
        <div class ="content content_popup">
            <div class ="content__table">
	<table class="innerTovarTable">
		<tr>
			<th style="width:60px;">ID</th>
			<th style="width:150px;">Наименование</th>
			<th style="width:60px;">К-во</th>
			<th style="width:100px;">Стоимость</th>
			<th style="width:100px;">Закупка</th>
			<th style="width:100px;">Прибыль с 1 шт.</th>
			{*<th style="width:100px;">МРЦ</th>*}
			<th style="width:100px;">OEM</th>
			<th style="width:100px;">Статус</th>
			{*<th style="width:100px;">Предоплата</th>*}
			<th style="width:100px;"></th>
		</tr>
		{foreach from=$tovar item=data}
			<tr {if $tovarId == $data.tovarId}class="thisCode"{/if}>
				<td>{$data.tovarId}</td>
				<td>{$data.casheTitle} {$data.casheIndex} {$data.casheRFXL}<br /> {$data.sTitle}</td>
				<td>{$data.col}</td>
				<td>{$data.price} руб.</td>
				<td>{$data.b2b} руб.</td>
				<td>{$data.delta} руб.</td>
				{*<td>{$data.RRC} руб.</td>*}
				<td>{$data.OEM}</td>
				{*<td>{$data.tovar_RRC} руб.</td>*}
				<td>
					{if $data.podZakaz}
						Срок поставки<br />до {$data.days} дней
					{else}
						В наличии
					{/if}
				</td>
				<td>
					{if $data.showUser == 0} Не показывается на сайте [0]{else} Видимо [{$data.showUser}]{/if}
				</td>
			</tr>
		{/foreach}
		
	</table>
    </div>
</div>
{/if}
