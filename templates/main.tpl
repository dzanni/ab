<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>{$APP->seo->title}</title>
    <meta name="keywords" content="{$APP->seo->keywords}"/>
    <meta name="description" content="{$APP->seo->description}"/>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    {*<link rel="icon" type="image/png" href="/logo.ico">*}

    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv-printshiv.min.js"></script>
    <![endif]-->

    <link rel="stylesheet" href="/style/libs.min.css"> <!-- Подключаем CSS -->

    {include file='settings.tpl'}

    <link rel="stylesheet" href="/style/main.css">
    <link rel="stylesheet" href="/style/media.css">
    <link rel="stylesheet" href="/script/slick/slick.css">
	<link rel="stylesheet" href="/script/slick/slick-theme.css">

	{*<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css">*}
	{*<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css">*}

    <link rel="stylesheet" type="text/css" href="/script/fancybox/fancybox.css">
    <link rel="stylesheet" href="/script/select2/select2.min.css">
    <link rel="stylesheet" href="/script/ui-slider/jquery-ui.css" media="all" />
    <link rel="stylesheet" type="text/css" href="/script/fancybox/jquery.fancybox.min.css">
    <link rel="stylesheet" href="/script/ui-slider/jquery-ui.css" type="text/css" media="all" />

    <!--Стили только для проекта A-BOSS -->

	<link rel="stylesheet" type="text/css" href="/style/v2/styles.min.css">
	<link rel="stylesheet" type="text/css" href="/style/build/styles.min.css">
	{*<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.css">*}
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css">

	<link rel="stylesheet" type="text/css" href="/style/aboss.css">
	<link rel="stylesheet" type="text/css" href="/style/aboss2.css?v4">

	{foreach from=$APP->css item=css}
        <link rel="stylesheet" href="{$css}">
    {/foreach}

</head>

<body class="{if $APP->route->firmPage}ver03{/if}">
<!-- Begin Online-Chat {literal} -->
<script>
	(function(){(function c(d,w,m,i) {
		window.supportAPIMethod = m;
		var s = d.createElement('script');
		s.id = 'supportScript';
		var id = '493abb6d84610dd9a91ebfecb8c98493';
		s.src = (!i ? 'https://zcdn.ru/support/support.js' : 'https://static.site-chat.me/support/support.int.js') + '?h=' + id;
		s.onerror = i ? undefined : function(){c(d,w,m,true)};
		w[m] = w[m] || function(){(w[m].q = w[m].q || []).push(arguments);};
		(d.head || d.body).appendChild(s);
	})(document,window,'OnlineChat')})();
</script>
<!-- Yandex.Metrika counter --> <script type="text/javascript" > (function(m,e,t,r,i,k,a){m[i]=m[i]||function(){(m[i].a=m[i].a||[]).push(arguments)}; var z = null;m[i].l=1*new Date(); for (var j = 0; j < document.scripts.length; j++) {if (document.scripts[j].src === r) { return; }} k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a)}) (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym"); ym(90239550, "init", { clickmap:true, trackLinks:true, accurateTrackBounce:true, webvisor:true }); </script> <noscript><div><img src="https://mc.yandex.ru/watch/90239550" style="position:absolute; left:-9999px;" alt="" /></div></noscript> <!-- /Yandex.Metrika counter -->

<!-- {/literal} End Online-Chat -->

	<div class="wrapper">
	{if $mainParams.FIELDS_LEFT_RIGHT}
 
	{/if}
				{include file="headers/header_render.tpl"}
				<div class="content">
					<div class="container">
					{if $firm_pages}
						{include file="../modules/Firms/templates/firm_card_page.tpl"}
					{elseif $main_firm_page}
						{include file="../modules/Firms/templates/firm_card.tpl"}
					{/if}

						<!--div class="container-fluid breadcrumbs_block">
								{* Вывод заголовков и хлебных крошек, кроме главной страницы (mainPage == 1)*}
								{if !$APP->route->mainPage ==1}
										{$APP->route->render_path()}
										{if !$APP->route->tovar && !$brand_page && $APP->route->values[0] != 'basket'}<h1 class="page_h1">{$APP->seo->H1}</h1>{/if}
								{/if}

								{* Выводим подкатегории, если есть *}
								{if count($APP->route->getSubCats()) >0 && !$bibl_page && !$tovar }
										<div class="subcats">
												{foreach from = $APP->route->getSubCats() item=d}
														<div class="subcats__item">
																<a href="{$d.URL}" class="">{$d.title}</a>
														</div>
												{/foreach}
										</div>
								{/if}
							</div-->

						{if !$firm_pages && !$main_firm_page}
						{foreach from=$APP->content->html item=d}
								{$d}
						{/foreach}
						{/if}

					</div>
				</div>
				{if !$APP->user->auth && !$lk_page}
					<div class="unauth">
						<div class="container">
							<div class="unauth__content">
								<div class="unauth__info">
									Находите друзей и интересные компании из автобизнеса <br>
									Зарегистрируйтесь или войдите в свой аккаунт, чтобы стать частью сообщества
								</div>
								<div class="unauth__buttons"><a class="button button__reg" href="/account/?lk_reg">Зарегистрироваться</a><a class="button button__auth" href="/account/">Войти</a></div>
							</div>
						</div>
					</div>
				{/if}


		<!---FOOTERS----->
				{include file="footers/footer_render.tpl"}
				<!---end FOOTERS----->

	{if $mainParams.FIELDS_LEFT_RIGHT}

	{/if}

	<div class="overlay"></div>
	<div class="popup__wrap {*popup__dark*} form_block" id="popup__order"> <!-- Класс popup__dark делает форму темной, чтоб была белой просто удалить класс -->
			<a href="#" class="popup__close">
					<img src="/i/icon__close.svg" class="svg" alt="">
			</a>
			<div class="popup__title form_title">Оставьте заявку и получите бесплатную консультацию</div>
			<form method="post" class="form__content  result">
					<label class="form__label">
							<input type="text" name="name" class="form__input data-provider not-empty" data-title="Имя" placeholder="Имя *">
					</label>
					<label class="form__label">
							<input type="text" name="phone" class="form__input data-provider not-empty" data-title="Телефон" placeholder="Телефон *" >
					</label>

					<label class="form__label">
							<input type="text" name="email" class="form__input data-provider" data-title="E-mail" placeholder="E-mail">
					</label>
					<div class="result_not"></div>

					<input type="hidden" class="js_token_captcha" name="g-recaptcha-response">
					<div class="button form__button js_send_form" data-recaptcha="{$mainParams.RE_CAPCHA_FRONT}">Отправить</div>
					<div class="form__check">
							<label class="form__label-checkbox">
									<input type="checkbox" name="form__checkbox" class="agree form__checkbox" checked>
								<br>
								<span class="form__checkbox-title">
							Я согласен(на) с <a href="#">политикой конфиденциальности</a>
							и даю согласие на <a href="#">обработку персональных данных</a>
						</span>
							</label>
					</div>
			</form>
	</div>

	<!-- Popup для таблиц с вариантами товара - добавлен класс also_variants_popup-->
	<div class="popup__wrap form_block also_variants_popup" id="popup__table">
			<a href="#" class="popup__close">
					<img src="/i/icon__close.svg" class="svg" alt="">
			</a>
			<div class="popup__table_body">Здесь должна быть таблица</div>
	</div>


	<!-- Popup для предложения новых тегов-->
	<div class="popup__wrap form_block" id="popup__tag">
			<a href="#" class="popup__close">
					<img src="/i/icon__close.svg" class="svg" alt="">
			</a>
			<div class="popup__title form_title"></div>
			<div class="form__content result">

					<label class="form__label">
							<input type="text" name="tag" class="form__input" placeholder="Введите тег">
					</label>
					<div class="button form__button js_tag_from_user">Отправить</div>
					<div class="alert"></div>
			</div>
	</div>

	<!-- Popup для предложения новых вариантов свойств-->
	<div class="popup__wrap form_block" id="popup__param">
			<a href="#" class="popup__close">
					<img src="/i/icon__close.svg" class="svg" alt="">
			</a>
			<div class="popup__title form_title"></div>
			<div class="form__content result">

					<label class="form__label">
							<input type="text" name="tag" class="form__input" placeholder="Введите свой вариант">
					</label>
					<div class="button form__button js_tag_from_user">Отправить</div>
					<div class="alert"></div>
			</div>
	</div>

	<!-- Popup для SMS-->
	<div class="popup__wrap form_block" id="popup__sms">
			<a href="#" class="popup__close">
					<svg class="svg-sprite-icon icon-icon__close">
                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__close"></use>
              </svg>
			</a>
			<div class="form__title">Регистрация</div>
			<div class="form__subtitle">Подтвердите номер телефона</div>
			<div class="form__content result">

					<label class="form__label">
							<input type="text" name="tag" class="form__input" placeholder="Введите код из sms">
					</label>
					<div class="button form__button js_tag_from_user">Отправить</div>
					<div class="alert"></div>
			</div>
	</div>

		<div class="popup__wrap form_block" id="popup__new">
			<a href="#" class="popup__close">
				<img src="/i/icon__close.svg" class="svg" alt="">
			</a>
			<svg class="svg-sprite-icon icon-icon__sendmessage">
				<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__sendmessage"></use>
			</svg>
			<div class="popup__title form_title">Зарегистрируйтесь, чтобы написать сообщение</div>
			<div class="popup__subtitle">Отправляйте мгновенные сообщения друзьям и знакомым</div>

			<div class="popup__buttons">
				<a class="button  button__auth button--orange" href="/account/">Войти</a>
				<a class="button  button__reg" href="/account/?lk_reg">Зарегистрироваться</a>
			</div>
		</div>

		<!-- Popup лендинга обратной связи фирм -->
		<div class="popup__wrap {*popup__dark*} form_block" id="popup__firm"> <!-- Класс popup__dark делает форму темной, чтоб была белой просто удалить класс -->
			<a href="#" class="popup__close">
				<img src="/i/icon__close.svg" class="svg" alt="">
			</a>
			<div class="popup__title form_title">Оставьте заявку на обратную связь</div>
			<form method="post" class="form__content  result">
				<label class="form__label">
					<input type="text" name="name" class="form__input data-provider not-empty" data-title="Имя" placeholder="Имя *">
				</label>
				<label class="form__label">
					<input type="text" name="phone" class="form__input data-provider not-empty" data-title="Телефон" placeholder="Телефон *" >
				</label>

				<label class="form__label">
					<input type="text" name="email" class="form__input data-provider" data-title="E-mail" placeholder="E-mail">
				</label>
				<div class="result_not"></div>

				<input type="hidden" class="js_token_captcha" name="g-recaptcha-response">
				<div class="button form__button js_send_form" data-recaptcha="{$mainParams.RE_CAPCHA_FRONT}">Отправить</div>
				<div class="form__check">
					<label class="form__label-checkbox">
						<input type="checkbox" name="form__checkbox" class="agree form__checkbox" checked>
						<br>
						<span class="form__checkbox-title">
							Я согласен(на) с <a href="#">политикой конфиденциальности</a>
							и даю согласие на <a href="#">обработку персональных данных</a>
						</span>
					</label>
				</div>
			</form>
		</div>
</div>

{if $APP->user->auth}
	<script>
		ym(90239550,'reachGoal','go_registered_user');
	</script>
{/if}

<script src="/script/jquery/jquery.js"></script>

<script src="/script/slick/slick.min.js"></script>
{*<script src="/script/plugin/maskedinput.min.js"></script>*}
<script src="/script/fancybox/fancybox.umd.js"></script>
{*<script src="/script/fancybox/jquery.fancybox.min.js"></script>*}
<script src="/script/select2/select2.min.js"></script>
<script src="/script/select2/i18n/ru.js"></script>
<script src="/script/ui-slider/jquery-ui.min.js"></script>
<script src="/script/slick/slick.min.js"></script>
<script src="/script/jquery.inputmask.js"></script>

<script src="/script/v2/libs.min.js"></script>
{*<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.css">*}
{*<script src="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.js"></script>*}
<script src="/script/v2/main.js"></script>

{*<script src="/script/build/jquery-3.3.1.min.js"></script> {* Этот скрипт из build мешает работе*}
<script src="/script/build/libs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script src="/script/build/main.js"></script>

{foreach from=$APP->js item=js}
    <script src="{$js}"></script>
{/foreach}

<script src="/script/main.js"></script>
<script src="/script/extra.js"></script>
<script src="https://www.google.com/recaptcha/api.js?render={$mainParams.RE_CAPCHA_FRONT}"></script>

</body>

</html>


