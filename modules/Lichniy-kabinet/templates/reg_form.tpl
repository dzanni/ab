

<div class="registration_form">
	<h2>Регистрация через</h2>
	<div class="yes_account">Есть аккаунт?  <a href="/account/">Войдите</a></div>
	<!--div class="registration_checkbox">
        <input type="radio" id="contactChoice1"
               name="tel-mail" value="tel" class="js_choose_reg_type" checked>
        <label for="contactChoice1">Телефон</label>

        <input type="radio" id="contactChoice2"
               name="tel-mail" value="login" class="js_choose_reg_type">
        <label for="contactChoice2">E-mail</label>
    </div-->

	<div class="auth_form-type registration_checkbox">
		<label>
			<input type="radio" id="contactChoice1"
				   name="tel-mail" value="tel" class="js_choose_reg_type" checked>
			<span>Телефон</span>
		</label>
		<label>
			<input type="radio" id="contactChoice2"
				   name="tel-mail" value="login" class="js_choose_reg_type">
			<span>E-mail</span>
		</label>
	</div>



	<form action="/account/" method="post" class="js_register_form">

		{foreach from=$user_vars key=key item=uv}
			{if $uv.type == "select"}
				<p><label><span class="label_title">{$uv.title}{if $uv.ness || $key=="tel" || $key=="login"}*{/if}:</span>
						<select data-title="{$uv.title}" name="{$key}" class="{$uv.class}">
							<option value="0">Выберите значение</option>
							{foreach from=$uv.v item=v}
								<option value="{$v.id}">{$v.title}</option>
							{/foreach}
						</select>
					</label>
				</p>
			{else}
				<p class="{$key} {if $key=='login'}hidden{/if}"><label><span class="label_title">{$uv.title}{if $uv.ness}*{/if}:</span> <span
								class="account__item-coment">
																				
																		{if $key=='pwd'}		<span class="input__show"> {/if}
									 
										
																				
																				<input {if $key=='pwd'}type="password"
																					   {else}type="text"{/if}
                                                                            class="slyle_input {$uv.class} {$key} js_check_user-data"
																					   placeholder="{$uv.title}" name="{$key}"
																					   data-title="{$uv.title}">
																																						
																																						{if $key=='pwd'}	<a href="#" class="input__show-password" >
												<svg class="svg-sprite-icon icon__eye-show " >
													<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-show"></use>
												</svg>
												<svg class="svg-sprite-icon icon__eye-hide ">
													<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-hide"></use>
												</svg>
											</a>
										</span> {/if}
																																						</span>
					</label><span class="{$key} js_alert_user-data"></span></p>
			{/if}
		{/foreach}
		<input type="hidden" class="js_token_captcha" name="g-recaptcha-response"/>
		<input type="hidden" name="send_register_request" value="true"/>
		<div class="auth__action">
			<label>
				<input type="checkbox" checked name="auth__remember">
				<span>Запомнить меня</span>
			</label>
		</div>
		<p><input type="button" value="Зарегистрироваться"
				  class="js_send_register_request account__button js_check_user-data-button button button--orange hidden"
				  data-recaptcha="{$RE_CAPTHCA}"/></p>

		<div class="js_result"></div>
	</form>


	<p>При использовании сайта, Вы соглашаетесь с <a href="/policy/" target="_blank">политикой обработки персональных данных</a> </p>
</div>

