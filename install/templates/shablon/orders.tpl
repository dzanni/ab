
<h1>Заказы, произведенные в интернет-магазине</h1>
{if $ordercol>0}
	Количество заказов:{$ordercol}
	<div>
		{foreach  item=data from=$orders}
			<div class="ordersLook cl{$data.status}">
				<div class="orderHeader">
					Заказ №{$data.id}
				</div>
				<div class="orderData">
					<div class="status">
						Статус заказа:
						{if $data.status == 1}
							&laquo;Заказ пока не просмотрен нашими менеджерами&raquo;
						{elseif $data.status == 2}
							&laquo;Заказ обрабатывается, мы свяжемся с Вами в кратчайшее время&raquo;
						{elseif $data.status == 3}
							&laquo;Заказ выполнен&raquo;
						{elseif $data.status == 4}
							&laquo;Заказ аннулирован&raquo;
						{/if}
					</div>
					<a href="/core/lookorder/{$data.id}/">Просмотреть заказ</a>
					<div class="price">
						Сумма заказа: <span>
							{if $data.orderPriceInRUR=="-1"}
								Сумма заказа не может быть посчитана! Есть товары с неизвестной ценой
							{else}
								{$data.orderPriceInRUR}
							{/if}
							 руб.</span>
					</div>
						{if $data.status == 1}
							&laquo;Сумма заказа пока не перешла на накопительный баланс клиента&raquo;
						{elseif $data.status == 2}
							&laquo;Сумма заказа пока не перешла на накопительный баланс клиента&raquo;
						{elseif $data.status == 4}
							&laquo;Заказ аннулирован&raquo;
						{/if}

				</div>
			</div>
		{/foreach}
	</div>
{else}
	У Вас пока нет ни одного заказа.
{/if}