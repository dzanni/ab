<!---- тестовый код ---->
<div class="page-inner page-comp03">
	<aside>
		{include file='../../../templates/left.tpl'}
	</aside>
	<main>
		<div class="content__block comp__content">
			<div class="content__comp-img"><img src="{$viewer->get_icon_by_firm($firm.id)}" alt="{$firm.title}"></div>
			<div class="content__comp-info">
				<div class="comp__info">
					<div class="block__title">{$firm.title}
						{if $firm.moderate == 2}
						<div class="block__confirmed">
							<img src="/i/build/content/svg/icon_check_03.svg" alt="">
						</div>
						{/if}
					</div>
					{if $obj->get_col_rating()}
					<div class="comp__item-rating">
						<div class="comp__item-rating-count">{$firm.rating}</div>
						<div class="comp__item-rating-stars">
							<div class="comp__item-rating-stars active" style="width: width: {$firm.rating_persent}%">
								<img src="/i/build/content/svg/icon_star-full_03.svg" alt="">
								<img src="/i/build/content/svg/icon_star-full_03.svg" alt="">
								<img src="/i/build/content/svg/icon_star-full_03.svg" alt=""><img src="/i/build/content/svg/icon_star-full_03.svg" alt="">
								<img src="/i/build/content/svg/icon_star-full_03.svg" alt="">
							</div>
							<img src="/i/build/content/svg/icon_star_03.svg" alt="">
							<img src="/i/build/content/svg/icon_star_03.svg" alt="">
							<img src="/i/build/content/svg/icon_star_03.svg" alt="">
							<img src="/i/build/content/svg/icon_star_03.svg" alt="">
							<img src="/i/build/content/svg/icon_star_03.svg" alt="">
						</div>
						<div class="comp__item-rating-reviews">({$obj->get_col_rating()})</div>
					</div>
					{/if}

				</div>
				<div class="comp__button">
					<a class="comp-button__link js_open_test_alert">Я сотрудник</a>
					<a class="comp-button__link js_open_test_alert">Я клиент</a>
					<a class="comp-button__link js_open_share_alert">Поделиться</a>
				</div>
			</div>
		</div>

		<div class="content__block js_test_alert_anchor hidden">
			<div class="render_work-cross">
				<span class="cross_small_render js_open_test_alert"></span>
			</div>
			<span style="color:red">Я всплывающее окно, на мне нет функционала. Закрой меня.</span>
		</div>

		<div class="content__block js_share_alert_anchor hidden">
			<div class="render_work-cross">
				<span class="cross_small_render js_open_share_alert"></span>
			</div>
			{$viewer->gen_share('', true)}
		</div>

		<div class="comp__column">
			<div class="comp__block">
				{if $firm.description_txt}
				<div class="content__block">
					<div class="block__title">Что мы делаем</div>
					<div class="block__content">
						{$firm.description_txt}
					</div>
				</div>
				{/if}

				{if $tags}
				<div class="content__block">
					<div class="block__title">Теги</div>
					<div class="block__content">
						<div class="tags__list">
							{foreach from=$tags item=data}
								{if $data.title != ''} <a href="/firms/?tag={$data.id}" class="tags__link">{$data.title}</a>{/if}
							{/foreach}
						</div>
					</div>
				</div>
				{/if}
				<div class="content__block">
					<div class="block__title">Наши сотрудники</div>
					<div class="block__content">
						<div class="comp__users-list block__hidden">
							{foreach from=$firm.workers key=key item=data}
								<div class="comp__users-item {if $key > 2}to_hide hidden{/if}">
									<div class="comp__user-photo">
										<a href="/users/?user={$data.id}">
										<img class="comp__user-img" src="{$viewer->get_icon_by_user($data.id)}" alt="{$data.family_name} {$data.name}">
										</a>
									</div>
									<div class="comp__user-info">
										<div class="comp__user-title"><a href="/users/?user={$data.id}">{$data.family_name} {$data.name}</a></div>
										<div class="comp__user-spec">{$data.job_title}</div>
									</div>
								</div>
							{/foreach}
						</div>
						{if count($firm.workers) > 3}
							<a class="show__all js_show_all_workers" data-msg="Показать всех сотрудников">Показать всех сотрудников</a>
						{/if}
					</div>
				</div>

				{if $firm.clients}
				<div class="content__block">
					<div class="block__title">Клиенты</div>
					<div class="block__content">
						<div class="clients__list block__hidden">
							{foreach from=$firm.clients key=key item=data}
								<a class="clients__link {if $key > 2}to_hide hidden{/if}" href="/firms/?firm={$data.id}">
									<div class="clients__img">
										<img src="{$viewer->get_icon_by_firm($data.id)}" alt="">
									</div>
									<span class="client__title">{$data.title}</span>
								</a>
							{/foreach}
						</div>
						{if count($firm.clients) > 3}
						<a class="show__all js_show_all_clients" data-msg="Показать всех клиентов">Показать всех клиентов</a>
						{/if}
					</div>
				</div>
				{/if}

				{if $firm.docs}
				<div class="content__block">
					<div class="block__title">Документы</div>
					<div class="block__content">
						<div class="comp__users-list block__hidden">
							{foreach from=$firm.docs key=key item=data}
								<div class="comp__users-item {if $key > 2}to_hide hidden{/if}">
									<div class="comp__user-info">
										<div class="comp__user-title"><a href="/files/docs/{$data.filename}" target="_blank">{if $data.title}{$data.title}{else}Без названия{/if}</a></div>
										{if $data.description}
											<div class="comp__user-spec">{$data.description}</div>
										{/if}
										{if $data.date}
											<div class="comp__user-spec">{$data.date}</div>
										{/if}
									</div>
								</div>
							{/foreach}
							{if count($firm.docs) > 3}
								<a class="show__all js_show_all" data-msg="Показать все документы">Показать все документы</a>
							{/if}
						</div>
					</div>
				</div>
				{/if}
			</div>

			<div class="comp__contacts">
				<div class="content__block">
					<div class="block__title">Контакты</div>
					<div class="comp-contacts__list">
						{if $firm.email}
						<div class="comp-contacts__title">Почта</div>
						<div class="comp-contacts__value">
							{if !count($firm.email)}
								{$firm.email}
							{else}
								{foreach from=$firm.email item=data}
									{$data}
								{/foreach}
							{/if}
						</div>
						{/if}
						{if $firm.phone}
						<div class="comp-contacts__title">Телефон{if count($firm.phone) > 1}ы{/if}</div>
						<div class="comp-contacts__value">
							{if !count($firm.phone)}
								{$firm.phone}
							{else}
								{foreach from=$firm.phone item=data}
									{$data}&nbsp;
								{/foreach}
							{/if}
						</div>
						{/if}
						{if $firm.address}
						<div class="comp-contacts__title">Адрес{if count($firm.address) > 1}а{/if}</div>
						<div class="comp-contacts__value">
							{if !count($firm.address)}
								{$firm.address}
							{else}
								{foreach from=$firm.address item=data}
									{$data}&nbsp;
								{/foreach}
							{/if}
						</div>
						{/if}
						{if $firm.site.0}
							<div class="comp-contacts__title">Сайт{if count($firm.site.0) > 1}ы{/if}</div>
							<div class="comp-contacts__value">
							{foreach from=$firm.site.0 item=data}
								<a href="{$data.URL}" target="_blank">{if $data.title}{$data.title}{else}{$data.URL}{/if}</a>
							{/foreach}
							</div>
						{/if}
						{if $firm.site.1}
							<div class="comp-contacts__title">Сoцсети</div>
							<div class="comp-contacts__value">
								{foreach from=$firm.site.0 item=data}
									<a href="{$data.URL}" target="_blank">{if $data.title}{$data.title}{else}{$data.URL}{/if}</a>
								{/foreach}
							</div>
						{/if}

					</div>
				</div>
			</div>
		</div>
	</main>
</div>
<!--- конец тестового кода --->

<br>
--- ВЫШЕ БЫЛ ТЕСТОВЫЙ КОД, НИЖЕ ТЕКУЩИЙ КОД ---<br>
<br>

<div class="page-inner page-comp">
	<main>

		{if $menu}
		<div class="content__block">
			<div class="content__block_firm_menu">
				<a href="/firms/?firm={$firm.id}" class="button button--orange">Главная</a>
			{foreach from=$menu item=m}
				<a href="/firms/?firm={$firm.id}&firmpage={$m.id}" class="button button--orange">{$m.title}</a>
			{/foreach}
			</div>
		</div>
		{/if}

		<div class="content__block comp__content">
			<div class="content__comp-img">
				<img src="{$viewer->get_icon_by_firm($firm.id)}" alt="{$firm.title}">
			</div>
			<div class="content__comp-info">
				<div class="content__comp-info-inner">
					<div class="block__title">{$firm.title}</div>

					{if $firm.moderate == 2}
						<div class="block__confirmed">
							<svg class="svg-sprite-icon icon-icon__confir">
								<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__confir"></use>
							</svg>Профиль подтвержден
						</div>
					{/if}

					{$viewer->gen_share()}

					<div class="comp__item-rating-t">Рейтинг ({$obj->get_col_rating()} оценок)</div>
					<div class="comp__item-rating">
						<div class="comp__item-rating-count">{$firm.rating}</div>
						<div class="comp__item-rating-stars">
							<div class="comp__item-rating-stars active" style="width: {$firm.rating_persent}%">
								<svg class="svg-sprite-icon icon-icon__start">
									<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
								</svg>
								<svg class="svg-sprite-icon icon-icon__start">
									<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
								</svg>
								<svg class="svg-sprite-icon icon-icon__start">
									<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
								</svg>
								<svg class="svg-sprite-icon icon-icon__start">
									<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
								</svg>
								<svg class="svg-sprite-icon icon-icon__start">
									<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
								</svg>
							</div>
							<svg class="svg-sprite-icon icon-icon__start">
								<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
							</svg>
							<svg class="svg-sprite-icon icon-icon__start">
								<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
							</svg>
							<svg class="svg-sprite-icon icon-icon__start">
								<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
							</svg>
							<svg class="svg-sprite-icon icon-icon__start">
								<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
							</svg>
							<svg class="svg-sprite-icon icon-icon__start">
								<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
							</svg>
						</div>
					</div>
					{if $firm.email || $firm.phone || $firm.address || $firm.site}
						<div class="block__list-spec">
							{*{if $firm.url}*}
							{*<div class="block__list-item">*}
										{*<svg class="svg-sprite-icon icon-icon__www">*}
											{*<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__www"></use>*}
										{*</svg>*}
								{*<p>{$firm.url}</p>*}
							{*</div>*}
							{*{/if}*}

							{if $firm.site.0}
							<div class="block__list-item">
								<svg class="svg-sprite-icon icon-icon__www">
									<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__www"></use>
								</svg>
								<p>
								{foreach from=$firm.site.0 item=data}
									<a href="{$data.URL}" target="_blank">{if $data.title}{$data.title}{else}{$data.URL}{/if}</a>&nbsp;
								{/foreach}
								</p>
							</div>
							{/if}

							{if $firm.site.1}
								<div class="block__list-item">
									<svg class="svg-sprite-icon icon-icon__www">
										<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__www"></use>
									</svg>
									<p>
										{foreach from=$firm.site.1 item=data}
											<a href="{$data.URL}" target="_blank">{if $data.title}{$data.title}{else}{$data.URL}{/if}</a>&nbsp;
										{/foreach}
									</p>
								</div>
							{/if}


							{if $firm.phone}
								<div class="block__list-item">
									<svg class="svg-sprite-icon icon-icon__phone">
										<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__phone"></use>
									</svg>
									<p>
									{if !count($firm.phone)}
										{$firm.phone}
									{else}
										{foreach from=$firm.phone item=data}
										{$data}&nbsp;
										{/foreach}
									{/if}
									</p>
								</div>
							{/if}
							{if $firm.email}
								<div class="block__list-item">
									<svg class="svg-sprite-icon icon-icon__mail">
										<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__mail"></use>
									</svg>
									<p>
										{if !count($firm.email)}
											{$firm.email}
										{else}
											{foreach from=$firm.email item=data}
												{$data}&nbsp;
											{/foreach}
										{/if}
									</p>
								</div>
							{/if}
							{if $firm.country}
								<div class="block__list-item">
									<svg class="svg-sprite-icon icon-icon__point">
										<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__point"></use>
									</svg>
									<p>{if $firm.country_show}{$firm.country}{/if}{if $firm.country_show && $firm.region_show}, {/if}{if $firm.region_show}{$firm.region}{/if}</p>
								</div>
							{/if}
							{if $firm.address}
								<div class="block__list-item">
									<svg class="svg-sprite-icon icon-icon__point">
										<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__point"></use>
									</svg>
									{if !count($firm.address)}
										{$firm.address}
									{else}
										{foreach from=$firm.address item=data}
											{$data}&nbsp;
										{/foreach}
									{/if}
								</div>
							{/if}
						</div>
					{/if}
					{if $tags}
						<div class="block__tags">
							{foreach from=$tags item=data}
								{if $data.title != ''} <a href="/firms/?tag={$data.id}" class="block__tags-link">#{$data.title}</a>{/if}
							{/foreach}
						</div>
					{/if}
		
				</div>
				<div class="content__comp-info-button">

					{if $current_user->auth && $current_user->status == 1}
						{assign var="personal" value=$obj->checkPersonalRight($firm.id)}
						{assign var="rating" value=$personal.rating}
						<div class="render_work_parent">
							<a class="button button--orange js_render_work_button">Оставить отзыв</a>
							<!--a class="account__button_render js_render_work_button">Оставить оценку и отзыв</a-->
							<div class="render_work firm hidden" data-firm="{$firm.id}" data-remark_in_page="{$firm.remark_in_page}">
								<div class="render_popup-inner">
									<div class="render_work-cross"><span class="cross_small_render js_render_work_button"></span></div>
									<div class="render_popup-title">Ваш отзыв о компании</div>
									<div class="render_work-info">От кого оценка и отзыв:</div>
									{assign var="checkRatingAndRemarkRight" value=$obj->checkRatingAndRemarkRight($firm.id)}
									{if !$checkRatingAndRemarkRight}
										<input type="hidden" class="js_firm_title_select" name="firm_title_select" value="0">
									{else}
										<select class="select js_firm_title_select" name="firm_title_select">
											<option value=0>От себя</option>
											{foreach from=$checkRatingAndRemarkRight item=data}
												<option value="{$data.id}">{$data.title}</option>
											{/foreach}
											{*<option value=-1>ПОКАЗАТЬ ВСЕ</option>*}
										</select>
									{/if}
									<div class="rating-area-wrap">
										<div class="rating-area" data-client=0>
											<div class="render_work_title">От себя</div>
											<input class="js_change_rating" type="radio" id="star-5" name="rating" value="5"
													{if $rating > 4 && $rating <= 5}checked{/if}>
											<label for="star-5" title="Оценка «5»"></label>
											<input class="js_change_rating" type="radio" id="star-4" name="rating" value="4"
													{if $rating > 3 && $rating <= 4}checked{/if}>
											<label for="star-4" title="Оценка «4»"></label>
											<input class="js_change_rating" type="radio" id="star-3" name="rating" value="3"
													{if $rating > 2 && $rating <= 3}checked{/if}>
											<label for="star-3" title="Оценка «3»"></label>
											<input class="js_change_rating" type="radio" id="star-2" name="rating" value="2"
													{if $rating > 1 && $rating <= 2}checked{/if}>
											<label for="star-2" title="Оценка «2»"></label>
											<input class="js_change_rating" type="radio" id="star-1" name="rating" value="1"
													{if $rating > 0 && $rating <= 1}checked{/if}>
											<label for="star-1" title="Оценка «1»"></label>
										</div>
									</div>

									{foreach from=$obj->checkRatingAndRemarkRight($firm.id) key=key item=data}
										<div class="rating-area-wrap"><div class="rating-area hidden" data-client="{$data.id}">
												<div class="render_work_title">{$data.title}</div>
												<input class="js_change_rating" type="radio" id="star-5_{$key}" name="rating_{$key}" value="5"
														{if $data.rating > 4 && $data.rating <= 5}checked{/if}>
												<label for="star-5_{$key}" title="Оценка «5»"></label>
												<input class="js_change_rating"  type="radio" id="star-4_{$key}" name="rating_{$key}" value="4"
														{if $data.rating > 3 && $data.rating <= 4}checked{/if}>
												<label for="star-4_{$key}" title="Оценка «4»"></label>
												<input class="js_change_rating"  type="radio" id="star-3_{$key}" name="rating_{$key}" value="3"
														{if $data.rating > 2 && $data.rating <= 3}checked{/if}>
												<label for="star-3_{$key}" title="Оценка «3»"></label>
												<input class="js_change_rating"  type="radio" id="star-2_{$key}" name="rating_{$key}" value="2"
														{if $data.rating > 1 && $data.rating <= 2}checked{/if}>
												<label for="star-2_{$key}" title="Оценка «2»"></label>
												<input class="js_change_rating"  type="radio" id="star-1_{$key}" name="rating_{$key}" value="1"
														{if $data.rating > 0 && $data.rating <= 1}checked{/if}>
												<label for="star-1_{$key}" title="Оценка «1»"></label>
											</div></div>
									{/foreach}

									<br><br>
									<div class="remark-area" data-client=0>
										<div class="render_work_title">От себя</div>
										<div class="render_work-info">Отзыв</div>
										<textarea class="remark">{$personal.remark}</textarea>
									</div>

									{foreach from=$obj->checkRatingAndRemarkRight($firm.id) key=key item=data}
										<div class="remark-area hidden" data-client="{$data.id}">
											<div class="render_work_title">{$data.title}</div>
											<div class="render_work-info">Отзыв</div>
											<textarea class="remark">{$data.remark}</textarea>
										</div>
									{/foreach}

									<a class="js_change_remark account__button_render button button--orange">Сохранить отзыв</a>
								</div>
								<div class="alert"></div>
							</div>

						</div>

						{if $obj->checkClientForMyFirms($firm.id)}
							<br>
							<div class="render_work_parent">

								<a class="button button--orange js_render_work_button">Добавить в клиенты</a>

								<div class="render_work firm hidden">

									<div class="render_popup-inner">		<div class="render_work-cross"><span
													class="cross_small_render js_render_work_button"></span></div>
										<div class="render_popup-title">Добавить</div>


										<div class="render_work-info">Клиент {$firm.title} отразится в списках клиентов выбранных компаний,
											если подтвердит запрос
										</div>

										{foreach from=$obj->checkClientForMyFirms($firm.id) item=data}
											<div>
												<label class="d-f a-c j-s">
													<input type="checkbox" name="is_my_client" {if isset($data.agree)}checked{/if}
															data-firm="{$data.id}" data-client="{$firm.id}"><span
															class="render_checkbox_title">{$data.title}</span>

													<span class="render_checkbox_alert">{if isset($data.agree)}{if $data.agree}- запрос подтвержден пользователем{else}- запрос отправлен{/if}{/if}</span>
												</label>
											</div>
										{/foreach}

										<a class="js_add_all_clients_to_firm account__button_render button button--orange">Сохранить</a>
									</div>
									<div class="alert"></div>
								</div>
							</div>
						{/if}

						{if $firm.can_edit}
							<br>
							<div class="render_work_button">
								<a class="button button--orange js_render_work_button" href="/account/brands/?lk_brands_edit_profile={$firm.id}">Редактировать</a>
							</div>
						{/if}

						{if $firm.can_be_a_worker == 1}
							<br>
							<div class="render_work_parent">
								<a class="button button--orange js_send_request_for_sotrudnik" data-id="{$firm.id}">Я сотрудник компании</a>
								<div class="js_send_request_for_sotrudnik_result txt-center"></div>
							</div>
						{elseif $firm.can_be_a_worker == -1}
							<br>
							<p class="txt-center">
								Ваш запрос в сотрудники пока не одобрен компанией, ожидайте.
							</p>
						{elseif $firm.can_be_a_worker == -2}
							<br>
							<div class="render_work_parent">
								<a class="button button--orange js_send_request_for_sotrudnik" data-id="{$firm.id}">Подтвердить, что я сотрудник компании</a>
								<div class="js_send_request_for_sotrudnik_result txt-center"></div>
							</div>
						{/if}
						{if count($firm.workers) == 0}

							<br>
							<div class="render_work_parent">
								<a class="button button--orange js_send_request_for_brand" data-id="{$firm.id}">Запросить управление компанией</a>
								<div class="js_send_request_for_brand_result"></div>
							</div>
						{/if}
					{/if}
				</div>

			</div>
		</div>

		{if $firm.description_txt}
			<div class="content__block">
				<div class="block__title">Что мы делаем</div>
				<div class="block__content">
					{$firm.description_txt}
				</div>
			</div>
		{/if}

		{if $firm.workers}
			<div class="content__block">
				<div class="block__title">Наши сотрудники ({count($firm.workers)})</div>
				<div class="block__content">
					<div class="comp__users-list ">
						{foreach from=$firm.workers item=data}
							<div class="comp__users-item">
								<div class="comp__user-photo">
									<a href="/users/?user={$data.id}">
										<img class="comp__user-img" src="{$viewer->get_icon_by_user($data.id)}" alt="{$data.family_name} {$data.name}">
									</a>
								</div>
								<div class="comp__user-info">
									<div class="comp__user-title"><a href="/users/?user={$data.id}">{$data.family_name} {$data.name}</a></div>
									<div class="comp__user-spec">{$data.job_title}</div>
								</div>
							</div>
						{/foreach}
					</div>
				</div>
			</div>
		{/if}

		{if $firm.clients}
			<div class="content__block">
				<div class="block__title">Наши клиенты</div>
				<div class="block__content">
					<div class="comp__users-list ">
						{foreach from=$firm.clients item=data}
							<div class="comp__users-item">
								<div class="comp__user-photo">
									<a href="/users/?user={$data.id}">
										<img class="comp__user-img" src="{$viewer->get_icon_by_firm($data.id)}" alt="{$data.title}">
									</a>
								</div>
								<div class="comp__user-info">
									<div class="comp__user-title"><a href="/firms/?firm={$data.id}">{$data.title}</a></div>
									<div class="comp__user-spec"></div>
								</div>
							</div>
						{/foreach}
					</div>
				</div>
			</div>
		{/if}

		{if $firm.docs}
			<div class="content__block">
				<div class="block__title">Документы ({count($firm.docs)})</div>
				<div class="block__content">
					<div class="block__list-docs">
						{foreach from=$firm.docs key=key item=data}
							<div class="block__item">
								{*<div class="block__item-img">*}
									{*<a href="/files/docs/{$data.filename}" style="text-decoration: underline" data-fancybox>*}
										{*<img src="/img.php?filename=/files/docs/{$data.filename}&width=64" alt="">*}
									{*</a>*}
								{*</div>*}
								<div class="block__item-info">
									{if $data.title}
										<div class="block__item-title">{$data.title}</div>{else}
										<div class="block__item-title">Без названия</div>
									{/if}
									{if $data.description}
										<div class="block__item-desc">{$data.description}</div>{/if}
									{if $data.date}
										<div class="block__item-date">{$data.date}</div>
									{/if}
									<a class="button" href="/files/docs/{$data.filename}" data-fancybox>Показать</a>
								</div>
							</div>
							<br>
						{/foreach}
					</div>
				</div>
			</div>
		{/if}

		<div class="js_remark_anchor">
			{$remarks}
		</div>
	</main>
</div>


<!--


<section class="firm_card">
    <div class="container-fluid">




        {if $obj->checkClientForMyFirms($firm.id)}
            <div class="render_work_parent">
                <div class="render_work_button">
                    <a class="account__button_render js_render_work_button">Добавить в клиенты</a>
                </div>
                <div class="render_work hidden">

                    <div class="render_work-cross"><span
                                class="cross_small_render js_render_work_button"></span></div>

                    <div class="render_work-info">Клиент {$firm.title} отразится в списках клиентов выбранных компаний,
                        если подтвердит запрос
                    </div>

                    {foreach from=$obj->checkClientForMyFirms($firm.id) item=data}
                        <div>
                            <label>
                                <input type="checkbox" name="is_my_client" {if isset($data.agree)}checked{/if}
                                       data-firm="{$data.id}" data-client="{$firm.id}"><span
                                        class="render_checkbox_title">{$data.title}</span>

                                <span class="render_checkbox_alert">{if isset($data.agree)}{if $data.agree}- запрос подтвержден{else}- запрос отправлен{/if}{/if}</span>
                            </label>
                        </div>
                    {/foreach}
                    <br>
                    <a class="js_add_all_clients_to_firm account__button_render">Сохранить</a>
                </div>
                <div class="alert"></div>
            </div>
        {/if}

        <br>

        {if $current_user->auth}
            {assign var="personal" value=$obj->checkPersonalRight($firm.id)}
            {assign var="rating" value=$personal.rating}
            <div class="render_work_parent">
                <div class="render_work_button">
                    <a class="account__button_render js_render_work_button">Оставить оценку и отзыв</a>
                </div>
                <div class="render_work hidden" data-firm="{$firm.id}" data-remark_in_page="{$firm.remark_in_page}">
                    <div class="render_work-cross"><span
                                class="cross_small_render js_render_work_button"></span></div>

                    <div class="render_work-info">От кого оценка и отзыв:</div>
                    {assign var="checkRatingAndRemarkRight" value=$obj->checkRatingAndRemarkRight($firm.id)}
                    {if !$checkRatingAndRemarkRight}
                        <input type="hidden" class="js_firm_title_select" name="firm_title_select" value="0">
                    {else}
                        <select class="js_firm_title_select" name="firm_title_select">
                            <option value=0>От себя</option>
                            {foreach from=$checkRatingAndRemarkRight item=data}
                                <option value="{$data.id}">{$data.title}</option>
                            {/foreach}
                            {*<option value=-1>ПОКАЗАТЬ ВСЕ</option>*}
                        </select>
                    {/if}

                    <div class="rating-area" data-client=0>
                        <div class="render_work_title">От себя</div>
                        <input type="radio" id="star-5" name="rating" value="5"
                               {if $rating > 4 && $rating <= 5}checked{/if}>
                        <label for="star-5" title="Оценка «5»"></label>
                        <input type="radio" id="star-4" name="rating" value="4"
                               {if $rating > 3 && $rating <= 4}checked{/if}>
                        <label for="star-4" title="Оценка «4»"></label>
                        <input type="radio" id="star-3" name="rating" value="3"
                               {if $rating > 2 && $rating <= 3}checked{/if}>
                        <label for="star-3" title="Оценка «3»"></label>
                        <input type="radio" id="star-2" name="rating" value="2"
                               {if $rating > 1 && $rating <= 2}checked{/if}>
                        <label for="star-2" title="Оценка «2»"></label>
                        <input type="radio" id="star-1" name="rating" value="1"
                               {if $rating > 0 && $rating <= 1}checked{/if}>
                        <label for="star-1" title="Оценка «1»"></label>
                    </div>


                    {foreach from=$obj->checkRatingAndRemarkRight($firm.id) key=key item=data}
                        <div class="rating-area hidden" data-client="{$data.id}">
                            <div class="render_work_title">{$data.title}</div>
                            <input type="radio" id="star-5_{$key}" name="rating_{$key}" value="5"
                                   {if $data.rating > 4 && $data.rating <= 5}checked{/if}>
                            <label for="star-5_{$key}" title="Оценка «5»"></label>
                            <input type="radio" id="star-4_{$key}" name="rating_{$key}" value="4"
                                   {if $data.rating > 3 && $data.rating <= 4}checked{/if}>
                            <label for="star-4_{$key}" title="Оценка «4»"></label>
                            <input type="radio" id="star-3_{$key}" name="rating_{$key}" value="3"
                                   {if $data.rating > 2 && $data.rating <= 3}checked{/if}>
                            <label for="star-3_{$key}" title="Оценка «3»"></label>
                            <input type="radio" id="star-2_{$key}" name="rating_{$key}" value="2"
                                   {if $data.rating > 1 && $data.rating <= 2}checked{/if}>
                            <label for="star-2_{$key}" title="Оценка «2»"></label>
                            <input type="radio" id="star-1_{$key}" name="rating_{$key}" value="1"
                                   {if $data.rating > 0 && $data.rating <= 1}checked{/if}>
                            <label for="star-1_{$key}" title="Оценка «1»"></label>
                        </div>
                    {/foreach}
                    <br>
                    <a class="js_change_rating account__button_render">Сохранить оценку</a>
                    <br><br>
                    <div class="remark-area" data-client=0>
                        <div class="render_work_title">От себя</div>
                        <textarea class="remark">{$personal.remark}
											</textarea>
                    </div>

                    {foreach from=$obj->checkRatingAndRemarkRight($firm.id) key=key item=data}
                        <div class="remark-area hidden" data-client="{$data.id}">
                            <div class="render_work_title">{$data.title}</div>
                            <textarea class="remark">{$data.remark}
											</textarea>
                        </div>
                    {/foreach}
                    <br>
                    <a class="js_change_remark account__button_render">Сохранить отзыв</a>


                </div>
                <div class="alert"></div>
            </div>
        {/if}
        <br>
        <br>
        <hr>
        <br>
        <div class="firm_card_item_title">ОТЗЫВЫ</div>
        <div class="js_remark_anchor">

            {foreach from=$firm.remark key=key item=data}
                <div class="user_card_item">
                    <div class="firm_card_item_title">
                        {if $data.client_id}
                            <a href="/firms/?firm={$data.client_id}">{$data.client_title}</a>
                            <br>
                        {elseif $data.user_id}
                            <a href="/users/?user={$data.user_id}">{$data.user_title}</a>
                            <br>
                        {/if}
                    </div>
                    <div class="firm_card_item_date">
                        {$viewer->render_date($data.date)}
                        {if $data.rating > 0}Рейтинг отзыва: {$data.rating}{/if}
                    </div>
                    {if $data.user_id == $current_user->id || $obj->isMyFirm($data.client_id) || $current_user->role_GAK >=4}
                        <div class="js_change_remark_anchor">
                         <textarea class="remark_bottom">{$data.text}
											</textarea>
                            <a class="js_change_remark_bottom account__button_render" data-id="{$data.id}">Сохранить отзыв</a>

                            <a class="js_delete_remark_bottom black account__button_render" data-id="{$data.id}">Удалить отзыв</a>
                        </div>
                    {else}
                        <div class="firm_card_item_text">
                            {$data.text}
                        </div>
                    {/if}


                    <div class="firm_card_item_like">
                        <img src="/i/like1.svg" width="20" height="20"
                             {if $current_user->auth}class="js_like_counter like_img" data-id="{$data.id}"
                             data-obj="remark"{/if}> (<span class="js_like_counter_anchor">{$data.like}</span>)<br> {if $data.like_my} Я лайкнул {/if}
                    </div>
                    <br>

                    {if $current_user->id == $firm.users || $current_user->role_GAK >=4}
                        <div class="js_change_answer_anchor firm_card_answer">
                            <div class="firm_card_item_title">Ответ</div>
                            {if $data.date_answer !=0}
                                <div class="firm_card_item_date">{$viewer->render_date($data.date_answer)}</div>
                            {/if}
                            <textarea class="remark_answer">{$data.text_answer}
</textarea>
                            <a class="js_change_answer account__button_render" data-id="{$data.id}">Сохранить ответ</a>
                            <a class="js_delete_answer black account__button_render" data-id="{$data.id}">Удалить ответ</a>

                            <div class="firm_card_item_like">
                                <img src="/i/like1.svg" width="20" height="20"
                                     {if $current_user->auth}class="js_like_counter like_img"
                                     data-id="{$data.id}" data-obj="remark_answer"{/if}> (<span
                                        class="js_like_counter_anchor">{$data.answer_like}</span>)<br> {if $data.answer_like_my} Я лайкнул {/if}
                            </div>
                        </div>
                    {else}
                        {if $data.text_answer}
                            <div class="firm_card_answer">
                                <div class="firm_card_item_title">
                                    Ответ<br>
                                </div>
                                {if $data.date_answer !=0}
                                    <div class="firm_card_item_date">{$data.date_answer}</div>
                                {/if}
                                <div class="firm_card_item_text">
                                    {$data.text_answer}
                                </div>
                                <div class="firm_card_item_like">
                                    <img src="/i/like1.svg" width="20" height="20"
                                         {if $current_user->auth}class="js_like_counter like_img"
                                         data-id="{$data.id}" data-obj="remark_answer"{/if}> (<span
                                            class="js_like_counter_anchor">{$data.answer_like}</span>)<br>
                                </div>
                            </div>
                        {/if}
                    {/if}


                </div>
            {/foreach}


            {if count($pages_remark) > 1}
                <div class="catalog__pagination justify-center" data-firm="{$firm.id}">

                    {if $page_current_remark != 1}
                        <a class="js_change_remark_page catalog__pagination-prev"
                           data-page="{$page_current_remark-1}">
                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M15.8334 10H4.16669" stroke="#4C5475" stroke-width="1.66667"
                                      stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M10 15.8334L4.16669 10.0001L10 4.16675" stroke="#4C5475"
                                      stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </a>
                    {/if}

                    {foreach $pages_remark as $p}
                        {if $p.page == "..."}
                            <span class="catalog__pagination-link">{$p.page}</span>
                        {else}
                            <a class="js_change_remark_page catalog__pagination-link {if $page_current_remark == $p.page}active{/if}"
                               data-page="{$p.page}">{$p.page}</a>
                        {/if}
                    {/foreach}

                    {if $page_current_remark != count($pages_remark)}
                        <a class="js_change_remark_page catalog__pagination-next"
                           data-page="{$page_current_remark+1}">
                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M4.16671 10H15.8334" stroke="#4C5475" stroke-width="1.66667"
                                      stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M10 15.8334L15.8334 10.0001L10 4.16675" stroke="#4C5475"
                                      stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </a>
                    {/if}

                </div>
            {/if}


        </div>



    </div>
    <br>
</section> -->