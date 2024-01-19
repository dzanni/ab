<main class="messages"><div class="content__block">
    <!--h3>{$smarty_params.h1}</h3-->
		<div class="messages__nav">
			<div class="messages__search">
				<form class="messages__form" method="get" action="/account/messages/">
					<input class="messages__form-input" type="text" name="q" {if $smarty_params.q}value="{$smarty_params.q}"{/if}>
					<button class="messages__form-button" type="submit">
						<svg class="svg-sprite-icon icon-icon__search">
							<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__search"></use>
						</svg>
					</button>
				</form>
			</div>
		</div>

    <div class="js_msg_container">

        {if $rule_get}
            <div class="js_msg_main_div messages__list">{$html_inner}</div>
        {/if}

    </div>

    <div class="js_pages">{$html_pages}</div>

    <div class="alerts"></div>
		</div>
</main>