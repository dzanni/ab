<div class="page-inner page-comps">
	<p class="mobile_only text-align-center">Найдите нужную компанию, используя фильтры:</p>
	<aside>
		<div class="lk_tag_box">
			{foreach from=$tags item=data}
				{if $data.id != 135}
					<div class="js_chg_element">
						<h4 class="tag_title_toggle js_tag_title_toggle">{$data.title}</h4>

						<div class="tag_cloud">

							{foreach from=$data.inner key=key item=data1}
								{if $obj->checkTag($data1.id)}
									<div class="tag_cloud_item checked">
										{$data1.title}
										<span class="js_delete_tag_render cross_small" data-id="{$data1.id}"></span>
									</div>
								{/if}
							{/foreach}

						</div>

						<div class="filter_js_anchor tag_title_anchor">
							<input type="text" placeholder="Найти"
								   class="js_fast_filter_mark filter_checkbox_search_lk" value="">
							<div class="tag_cloud">
								{foreach from=$data.inner key=key item=data1}
									<div class="tag_cloud_item label js_add_tag_render {if $obj->checkTag($data1.id)}checked{/if}" data-id="{$data1.id}">
										<span class="filter-form__label-title">{$data1.title}</span>
									</div>
								{/foreach}
							</div>

						</div>
					</div>
					{if $data.id ==1} {* К стране берем регионы*}
						<div class="js_chg_element">
							<h4 class="tag_title_toggle js_tag_title_toggle">Регион</h4>

							<div class="tag_cloud">
								{foreach from=$regions item=reg}
									{if $obj->checkTag($reg.id)}
										<div class="tag_cloud_item checked">
											{$reg.title}
											<span class="js_delete_tag_render cross_small" data-id="{$reg.id}"></span>
										</div>
									{/if}
								{/foreach}
							</div>

							<div class="filter_js_anchor tag_title_anchor">
								<input type="text" placeholder="Найти"
									   class="js_fast_filter_mark filter_checkbox_search_lk" value="">
								<div class="tag_cloud">
									{foreach from=$regions item=reg}
										<div class="tag_cloud_item label js_add_tag_render {if $obj->checkTag($reg.id)}checked{/if}" data-id="{$reg.id}">
											<span class="filter-form__label-title">{$reg.title}</span>
										</div>
									{/foreach}
								</div>
							</div>
						</div>
					{/if}

				{/if}
			{/foreach}
			{*<div class="js_chg_element">
				<h4 class="tag_title_toggle js_tag_title_toggle">Уровень должности</h4>


				<div class="filter_js_anchor tag_title_anchor">

					<select class="js_chg lk_select select">
						<option value="">Выбрать</option>
						<option>10-15</option>
						<option>10-15</option>
						<option>10-15</option>
					</select>


				</div>
			</div>*}
			<a class="account__button_render js_render_firm_filter button button--orange">Применить фильтр</a>

			<p class="refresh_filter"><a href="/firms/">Сбросить фильтр</a></p>
		</div>

	</aside>
	<main>
		<div class="comps__wrap">
			<p class="desctop_only">Найдите нужную компанию, используя фильтры слева </p>
			<div class="comps__bar">
				<h1>Компании</h1>
				<div class="comps__count">{$col_elements}</div>
				

				{if $user->auth}
					
					<div class="render_work_parent comps__create">
					<a class="account__button_render js_render_work_button button button--orange">Создать новую компанию</a>
						<div class="render_work firm hidden"><div class="render_popup-inner">

							<div class="render_work-cross"><span
										class="cross_small_render js_render_work_button"></span></div>
<div class="render_popup-title">Добавить компанию</div>
							<div class="render_work-info">Создать новую компанию (будет видна после модерации)</div>
							<input type="text" name="new_firm" class="slyle_input_render" placeholder="Введите название">
							<label class="d-f a-c">
								<input type="checkbox" name="i_work_here">
								<span
													class="render_checkbox_title">Я сотрудник компании</span>
							</label>
							<a class="js_create_new_firm account__button_render button button--orange">Создать</a>
						</div>
						<div class="alert"></div>
					</div></div>
				{/if}
				<!--a class="button button--orange comps__create js_popup" href="#sms">Создать новую компанию</a-->
			</div>
			<div class="comps__nav">
				<div class="comps__search">
					<div class="comps__form">
						<input class="comps__form-input js_txt_search" type="text" value="{$search_txt}">
						<button class="comps__form-button js_start_search" type="button">
							<svg class="svg-sprite-icon icon-icon__search">
								<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__search"></use>
							</svg>
						</button>
					</div>
				</div>
				<div class="comps__sort">
					<select class="select js_sort_change">
						<option value="{$base_url_alphabet}" {if $sort == 'alphabet'}selected="selected"{/if}>По алфавиту</option>
						<option value="{$base_url_popular}" {if $sort == 'popular'}selected="selected"{/if}>По рейтингу</option>
					</select>
					<div class="comps__view">
						<a class="comps__view-item {if $outputType=="plate"}active{/if}" href="{$base_url_plate}">
							<svg class="svg-sprite-icon icon-icon__view-table">
								<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__view-table"></use>
							</svg></a>
						<a class="comps__view-item {if $outputType=="list"}active{/if}"  href="{$base_url_list}">
							<svg class="svg-sprite-icon icon-icon__view-list">
								<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__view-list"></use>
							</svg></a></div>
				</div>
			</div>
			{if $all_firm}
				<div class="comps__list {if $outputType=="list"}list{/if}">
					{foreach from=$all_firm item=data}
						<div class="comps__item">
							<div class="comps__item-inner">
								<a href="/firms/?firm={$data.id}" class="comps__item-link">
									<div class="comps__item-photo"><img class="comps__item-img lazyloaded" src="{$viewer->get_icon_by_firm($data.id)}" alt="{$data.title}"></div>
									<div class="comps__item-info">
										<div class="comps__item-title">{$data.title}</div>
										{if $data.rating > 0}
											<div class="comps__item-rating">
												<div class="comps__item-rating-count">{$data.rating}</div>
												<div class="comps__item-rating-stars">
													<div class="comps__item-rating-stars active" style="width: {$data.rating_persent}%">
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
										{/if}
									</div>

								</a>
							</div>
						</div>
					{/foreach}
				</div>
			{else}
				По заданным параметрам ничего не найдено
				<br>
				<br>
			{/if}

			{if count($pages) > 1}
				<div class="pagination">

					{if $page_current != 1}
						<a href="{$left_url}" class="pagination-link">
							<svg class="svg-sprite-icon icon-icon__arrow-l">
								<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__arrow-l"></use>
							</svg>
						</a>
					{/if}

					{foreach $pages as $p}
						{if $p.page == "..."}
							<span class="pagination-link">{$p.page}</span>
						{else}
							<a href="{$p.url}" class="pagination-link {if $p.active}active{/if}">{$p.page}</a>
						{/if}
					{/foreach}

					{if $page_current != count($pages)}
						<a href="{$right_url}" class="pagination-link">
							<svg class="svg-sprite-icon icon-icon__arrow-r">
								<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__arrow-r"></use>
							</svg>
						</a>
					{/if}

				</div>
			{/if}

		</div>
	</main>

</div>


