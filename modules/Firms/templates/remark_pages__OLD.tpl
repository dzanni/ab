<div class="content__block">
	<div class="block__title">Отзывы</div>
	<div class="block__content">
		<div class="comp__reviews-list">
		{foreach from=$remark key=key item=data}

			<div class="comp__reviews-item">
	<div class="comp__review-photo">
	<img class="comp__user-img" src="/i/v2/content/profile.png" alt=""></div>
	<div class="comp__review-info">
		<div class="comp__review-title">
			{if $data.client_id}
				<a href="/firms/?firm={$data.client_id}">{$data.client_title}</a>
			{elseif $data.user_id}
					<a href="/users/?user={$data.user_id}">{$data.user_title}</a>
			{/if}
			{if $data.rating > 0}
			<div class="comp__review-rating">
				<div class="comp__review-rating-stars">
					<div class="comp__review-rating-stars active" style="width: {$data.rating*20}%">
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
			{if $data.user_id == $current_user->id || $current_user->role_GAK >=4 || $data.client_id|in_array:$my_firms}
			<div class="comp__review-icon">
			
				<a class="quest__nav-edit" href="#">
						<svg class="svg-sprite-icon icon-icon__q-edit">
							<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-edit"></use>
						</svg></a>
					
					
					<a class="quest__nav-del" href="#">
					<svg class="svg-sprite-icon icon-icon__q-del">
						<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-del"></use>
					</svg></a>
					
					</div>
				{/if}
		</div>
		<div class="comp__review-text js_change_remark_anchor">
			<div class="comp__review-text-inner">{$data.text}</div>
			<form class="review__add-q" action="#">
				<textarea class="remark_bottom">{$data.text}</textarea>
				<a class="review__add-button button js_change_remark_bottom account__button_render" data-id="{$data.id}">Сохранить</a>
			</form></div>
		<div class="comp__review-date">{$data.date}<a class="comp__review-answer" href="#">Ответить</a>
			<div class="comp__review-like firm_card_item_like {if $data.like_my}checked{/if}">
				<div class="comp__review-link" >
					<svg class="svg-sprite-icon icon-icon__like {if $current_user->auth}js_like_counter like_img{/if}" {if $current_user->auth}data-id="{$data.id}" data-obj="remark"{/if}>
						<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__like"></use>
					</svg>
					<span class="js_like_counter_anchor">{$data.like}</span>
				</div>
			</div>
		</div>

		{if $data.text_answer}
									<div class="comp__reviews-item answer js_change_answer_anchor ">
										<div class="comp__review-photo"><img class="comp__user-img" src="/images/f/{if $firm.logo}{$firm.id}.jpg{else}incognito.svg{/if}" alt="{$firm.title}"></div>
										<div class="comp__review-info">
											<div class="comp__review-title">{$firm.title}
												{if $current_user->id == $firm.users || $current_user->role_GAK >=4}
												<div class="comp__review-icon"><a class="quest__nav-edit" href="#">
														<svg class="svg-sprite-icon icon-icon__q-edit">
															<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-edit"></use>
														</svg></a><a class="quest__nav-del js_delete_answer" href="#"  data-id="{$data.id}">
														<svg class="svg-sprite-icon icon-icon__q-del">
															<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-del"></use>
														</svg></a></div>{/if}
											</div>
											<div class="comp__review-text">
												<div class="comp__review-text-inner">{$data.text_answer}</div>
												<form class="review__add-q" action="#">
													<textarea class="remark_answer review__add-input">{$data.text_answer}</textarea>
													<a class="review__add-button button js_change_answer account__button_render" data-id="{$data.id}">Сохранить</a>
												</form>
											</div>
											<div class="comp__review-date">{if $data.date_answer !=0}{$data.date_answer}{/if}
												<div class="comp__review-like firm_card_item_like {if $data.like_my}checked{/if}">
													<div class="comp__review-link ">
														<svg class="svg-sprite-icon icon-icon__like {if $current_user->auth}js_like_counter like_img{/if}" {if $current_user->auth}data-id="{$data.id}" data-obj="remark"{/if}>
															<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__like"></use>
														</svg><span class="js_like_counter_anchor">{$data.like}</span>
													</div>
												</div>
											</div>
										</div>
									</div>
								{else}
									{if $current_user->id == $firm.users || $current_user->role_GAK >=4}
									<div class="comp__review-add js_change_answer_anchor">
										<div class="comp__review-photo"><img class="comp__review-img" src="/images/f/{if $firm.logo}{$firm.id}.jpg{else}incognito.svg{/if}" alt="{$firm.title}"></div>
										<div class="comp__review-text-inner-a"></div>
										<form class="review__add" action="#">
											<textarea class="remark_answer review__add-input">{$data.text_answer}</textarea>
											<a class="review__add-button button js_change_answer account__button_render" data-id="{$data.id}">Сохранить</a>
										</form>
									</div>
									{/if}
								{/if}
		
	 
	</div>
</div>

		{/foreach}
		</div>
	</div>
</div>
{if count($pages_remark) > 1}
	<div class="pagination catalog__pagination" data-firm="{$firm_id}">

			{if $page_remark_current != 1}
					<a  class="js_change_remark_page catalog__pagination-link pagination-link" data-page="{$page_current_remark-1}">
							<svg class="svg-sprite-icon icon-icon__arrow-l">
							<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__arrow-l"></use>
						</svg>
					</a>
			{/if}

			{foreach $pages_remark as $p}
					{if $p.page == "..."}
							<span class="pagination-link catalog__pagination-link">{$p.page}</span>
					{else}
							<a  data-page="{$p.page}" class="js_change_remark_page catalog__pagination-link pagination-link {if $page_current_remark == $p.page}active{/if}">{$p.page}</a>
					{/if}
			{/foreach}

			{if $page_current_remark != count($pages)}
					<a  data-page="{$page_current_remark+1}" class="js_change_remark_page catalog__pagination-link pagination-link">
							<svg class="svg-sprite-icon icon-icon__arrow-r">
							<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__arrow-r"></use>
						</svg>
					</a>
			{/if}

	</div>
{/if}

 