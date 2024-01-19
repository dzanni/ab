<div class="container-fluid">
	<div class="lk_menu label_style">
		<div class="auth_form js_form">

			<h3>{$user.name} {$user.family_name}! <br> мы рады Вас видеть! </h3>
			{if $error}<div class="bad">{$error}</div>{/if}
			<div>
				<p><label><span class="label_title">Укажите удобный пароль:</span> <span class="account__item-coment">

								<span class="input__show">
											<input type="password" class="slyle_input js_pwd" placeholder="Пароль" name="pwd">
											<a href="#" class="input__show-password">
												<svg class="svg-sprite-icon icon__eye-show " wfd-invisible="true">
													<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-show"></use>
												</svg>
												<svg class="svg-sprite-icon icon__eye-hide ">
													<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-hide"></use>
												</svg>
											</a>
										</span>

								</span></label>
				</p>
				<input type="button" class="account__button button button--orange js_mk_set_au" value="Задать пароль" data-au="{$smarty.get.au}">
				<div class="js_result"></div>
				{if $error}<div class="errorMsg">{$user->auth_result}</div>{/if}

				<br>
				<p>При использовании сайта, Вы соглашаетесь с <a href="/policy/" target="_blank">политикой обработки персональных данных</a> </p>
			</div>
		</div>
	</div>
</div>