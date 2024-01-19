<div class="auth_form">
	<div class="auth_form-login">
		<h2>Вход</h2>
		<div class="no_account">Нет аккаунта? <a href="/account/?lk_reg">Зарегистрируйтесь</a></div>
		<div class="auth_form-type">
			<label>
				<input type="radio" checked name="select_type" value="phone">
				<span>Номер телефона</span>
			</label>
			<label>
				<input type="radio" name="select_type" value="mail">
				<span>Email</span>
			</label>
		</div>

		<form action="/account/" method="post" class="js_auth_form auth_form-phone">
			<p><label><span class="label_title">Вход по телефону:</span> <span class="account__item-coment"><input type="text" class="slyle_input tel" placeholder="Телефон" name="login"  autocomplete="off"></span> </label></p>
			<p><label><span class="label_title">Пароль:</span> <span class="account__item-coment">
								
								<span class="input__show">
											<input type="password" class="slyle_input" placeholder="Пароль" name="pwd" autocomplete="off">
											<a href="#" class="input__show-password" >
												<svg class="svg-sprite-icon icon__eye-show " >
													<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-show"></use>
												</svg>
												<svg class="svg-sprite-icon icon__eye-hide ">
													<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-hide"></use>
												</svg>
											</a>
										</span>

								</span></label>
			<div class="auth__action">
				<label>
					<input type="checkbox" checked name="auth__remember">
					<span>Запомнить меня</span>
				</label>
				<a href="#" class="auth__action-forgot forgot-phone">Забыли пароль?</a>
			</div>
			<input type="hidden" class="js_token_captcha" name="g-recaptcha-response" />
			<input type="hidden" name="mk_auth_init" value="1" />
			<input type="button" value="Войти" class="js_mk_auth_init account__button button button--orange" data-recaptcha="{$RE_CAPTHCA}"></p>
			<div class="js_result"></div>
			{if $user->auth_result}<div class="errorMsg">{$user->auth_result}</div>{/if}
		</form>
		<form action="/account/" method="post" class="js_auth_form auth_form-mail">
			<p><label><span class="label_title">Вход по E-Mail:</span> <span class="account__item-coment"><input type="text" class="slyle_input" placeholder="E-Mail" name="login"></span> </label></p>
			<p><label><span class="label_title">Пароль:</span>
					<span class="account__item-coment">
										<span class="input__show">
											<input type="password" class="slyle_input" placeholder="Пароль" name="pwd">
											<a href="#" class="input__show-password" >
												<svg class="svg-sprite-icon icon__eye-show " >
													<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-show"></use>
												</svg>
												<svg class="svg-sprite-icon icon__eye-hide ">
													<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__eye-hide"></use>
												</svg>
											</a>
										</span>
									</span>
				</label>
			<div class="auth__action">
				<label>
					<input type="checkbox" checked name="auth__remember">
					<span>Запомнить меня</span>
				</label>
				<a href="#" class="auth__action-forgot forgot-mail">Забыли пароль?</a>
			</div>

			<input type="hidden" class="js_token_captcha" name="g-recaptcha-response" />
			<input type="hidden" name="mk_auth_init" value="1" />
			<input type="button" value="Войти" class="js_mk_auth_init account__button button button--orange" data-recaptcha="{$RE_CAPTHCA}"></p>
			<div class="js_result"></div>
			{if $user->auth_result}<div class="errorMsg">{$user->auth_result}</div>{/if}
		</form>

		<p>При использовании сайта, Вы соглашаетесь с <a href="/policy/" target="_blank">политикой обработки персональных данных</a> </p>
	</div>
	<div class="auth_form-forgot">
		<h2>Восстановление пароля</h2>
		<div class="auth_form-type">
			<label>
				<input type="radio" checked name="select_type-f" value="phone">
				<span>Номер телефона</span>
			</label>
			<label>
				<input type="radio" name="select_type-f" value="mail">
				<span>Email</span>
			</label>
		</div>
		<form class="js_mk_forget_pwd_obj auth_form-mail">
			<p><label><span class="label_title">E-Mail:</span> <span class="account__item-coment"><input type="text" class="slyle_input js_login" name="login" placeholder="E-Mail"></span> </label>
				<input type="button" value="Восстановить пароль" class="js_mk_forget_pwd account__button button button--orange" data-recaptcha="{$RE_CAPTHCA}" data-device="mail">
				<input type="hidden" class="js_token_captcha" name="g-recaptcha-response" />
				<input type="hidden" name="mk_auth_init" value="1" /></p>
			<div class="js_result"></div>
		</form>

		<form class="js_mk_forget_pwd_obj auth_form-phone">
			<p><label><span class="label_title">Телефон:</span> <span class="account__item-coment"><input type="text" class="slyle_input js_login tel" name="tel" placeholder="Телефон"></span> </label>
				<input type="button" value="Восстановить пароль" class="js_mk_forget_pwd account__button button button--orange" data-recaptcha="{$RE_CAPTHCA}" data-device="tel">
				<input type="hidden" class="js_token_captcha" name="g-recaptcha-response" />
				<input type="hidden" name="mk_auth_init" value="1" /></p>
			<div class="js_result"></div>
		</form>
	</div>
</div>
{*  <br>
  <div class="registration_form">
      <h2>Регистрация</h2>
      <form action="/account/" method="post" class="js_register_form">

          {foreach from=$user_vars key=key item=uv}
              {if $uv.type == "select"}
                  <p><label><span class="label_title">{$uv.title}{if $uv.ness}*{/if}:</span>
                          <select data-title="{$uv.title}" name="{$key}" class="{$uv.class}" >
                              <option value="0">Выберите значение</option>
                              {foreach from=$uv.v item=v}
                                  <option value="{$v.id}">{$v.title}</option>
                              {/foreach}
                          </select>
                      </label>
                  </p>
              {else}
                  <p><label><span class="label_title">{$uv.title}{if $uv.ness}*{/if}:</span> <span class="account__item-coment"><input {if $key=='pwd'}type="password"{else}type="text"{/if} class="slyle_input {$uv.class} {$key} js_check_user-data" placeholder="{$uv.title}" name="{$key}" data-title="{$uv.title}"></span> </label><span class="{$key} js_alert_user-data"></span></p>
              {/if}
          {/foreach}
          <input type="hidden" class="js_token_captcha" name="g-recaptcha-response" />
          <input type="hidden" name="send_register_request" value="true" />

          <p><input type="button" value="Зарегистрироваться" class="js_send_register_request account__button js_check_user-data-button hidden " data-recaptcha="{$RE_CAPTHCA}"/> </p>

          <div class="js_result"></div>
      </form>
  </div> *}
