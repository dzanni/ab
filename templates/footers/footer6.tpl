
	<div class="container">
		<div class="footer__logo"><a class="footer__logo-link" href="/">
				<svg class="svg-sprite-icon icon-footer__logo">
					<use xlink:href="/i/v2/svg/symbol/sprite.svg#footer__logo"></use>
				</svg><span class="footer__logo-desc">Международная профессиональная сеть экспертов автобизнеса</span></a></div>
		<div class="footer__contacts">
			<div class="footer__contacts-item">
				<svg class="svg-sprite-icon icon-icon__point">
					<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__point"></use>
				</svg>
				<p>{$mainParams.ADDR}</p>
			</div>
			<div class="footer__contacts-item">
				<svg class="svg-sprite-icon icon-icon__phone">
					<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__phone"></use>
				</svg>
				<p>{$mainParams.TEL}</p>
			</div>
			<div class="footer__contacts-item">
				<svg class="svg-sprite-icon icon-icon__mail">
					<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__mail"></use>
				</svg>
				<p>{$mainParams.EMAIL}</p>
			</div>
		</div>
		<div class="footer__soc">
			<div class="footer__soc-title">Социальные сети</div>
			<a class="footer__soc-link" href="{$mainParams.SOCIAL_VK}">
				<svg class="svg-sprite-icon icon-soc__vk">
					<use xlink:href="/i/v2/svg/symbol/sprite.svg#soc__vk"></use>
				</svg>
			</a>
		</div>
	</div>
	<div class="container">
		<div class="footer__copy">{$mainParams.down_text}<br>
		<p>При использовании сайта, Вы соглашаетесь с <a style="color: #fff;" href="/policy/">политикой обработки персональных данных</a> </p>
		</div>
		<div class="footer__www"><a class="footer__www-link" href="https://expert.a-boss.ru/firms/?firm=33">Разработано в веб-студии Александра Дроздова</a></div>
	</div>

<!--
		<div class="footer__bottom">
    <div class="container-fluid justify-space">
        <div class="footer__col">
            <a href="/" class="footer__logo">
                <img src="/i/autoboss-white-i.svg" class="footer__logo-img" alt="">
            </a>

            <!--В проекте GP TYRES этот блок идет самым нижним->
            {* <div class="footer__copy">
                © 2021-2022. Все права защищены.
            </div>
            <a href="/Politika-obrabotki-personalnih-dannih/" class="footer__privacy-link">
                Приведённые цены и характеристики товаров
                носят исключительно ознакомительный характер
                и не являются публичной офертой.
                Для получения подробной информации
                о характеристиках товаров, их наличии и стоимости
                связывайтесь с менеджерами компании.
            </a>
            *}
        </div>
        <div class="footer__col">
            {if $mainParams.ADDR !=""}
              {*  <div class="footer__subtitle">
                    Адрес
                </div>*}
                <div class="footer__adress">
                    {$mainParams.ADDR}<br>
                    {$mainParams.WORKOURS}<br>
                </div>

            {/if}

            {if $mainParams.SOCIAL_TLG !='' ||
            $mainParams.SOCIAL_VK !='' ||
            $mainParams.SOCIAL_INST !='' ||
            $mainParams.SOCIAL_WA !='' ||
            $mainParams.SOCIAL_VB !='' ||
            $mainParams.SOCIAL_FB !=''
            }
                <div class="footer__subtitle">Социальные сети
                </div>
            {/if}
            <div class="footer__contacts-soc">
                {if $mainParams.SOCIAL_TLG !=''}
                    <a href="{$mainParams.SOCIAL_TLG}" class="contacts-soc__link">
                        <img src="/i/soc__tg.svg" alt="" class="svg">
                    </a>
                {/if}
                {if $mainParams.SOCIAL_VK !=''}
                    <a href="{$mainParams.SOCIAL_VK}" class="contacts-soc__link">
                        <img src="/i/soc__vk.svg" alt="" class="svg">
                    </a>
                {/if}
                {if $mainParams.SOCIAL_INST !=''}
                    <a href="{$mainParams.SOCIAL_INST}" class="contacts-soc__link">
                        <img src="/i/soc__in.svg" alt="" class="svg">
                    </a>
                {/if}
                {if $mainParams.SOCIAL_WA !=''}
                    <a href="{$mainParams.SOCIAL_WA}" class="contacts-soc__link">
                        <img src="/i/soc__wa.svg" alt="" class="svg">
                    </a>
                {/if}
                {if $mainParams.SOCIAL_VB !=''}
                    <a href="{$mainParams.SOCIAL_VB}" class="contacts-soc__link">
                        <img src="/i/soc__vi.svg" alt="" class="svg">
                    </a>
                {/if}
                {if $mainParams.SOCIAL_FB !=''}
                    <a href="{$mainParams.SOCIAL_FB}" class="contacts-soc__link">
                        <img src="/i/soc__fb.svg" alt="" class="svg">
                    </a>
                {/if}
               {* {if $mainParams.SOCIAL_YT !=''}
                    <a href="{$mainParams.SOCIAL_YT}" class="contacts-soc__link">
                        <img alt="" class="svg">
                    </a>
                {/if}*}


            </div>
        </div>
       <div class="footer__col">

              {if $mainParams.TEL !="" || $mainParams.EMAIL !=""}
                  {*  <div class="footer__subtitle">
                       Свяжитесь с нами
                   </div>*}
              {/if}

              {if $mainParams.TEL !=""}
                  <a href="tel:{$mainParams.TEL}" class="footer__contacts-phone">
                      {$mainParams.TEL}
                  </a>
              {/if}

              {if $mainParams.EMAIL !=""}
                  <a href="mailto:{$mainParams.EMAIL}" class="footer__contacts-mail">
                      {$mainParams.EMAIL}
                  </a>
              {/if}

          </div>
    </div>

    <!--Для проекта GP TYRES этот блок перенесен сюда, добавлен стиль bottom_copyright->

    <div class="container-fluid justify-space bottom_copyright">
    <div class="footer__copy">
        {$mainParams.down_text}

    </div>
    </div>


</div>
-->