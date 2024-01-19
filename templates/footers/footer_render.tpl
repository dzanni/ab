{foreach from=$APP->getFooterVariants() item=footer}
    {if $footer.chg}
        <div class="techno">↓ footer ВАРИАНТ {$footer.id} -
            <a class="js_chg_footer_and_footer {if $footer.selected}choosen{/if}" data-choice="{$footer.id}" data-type="footer">
                {if !$footer.selected}Выбрать{else}ВЫБРАН{/if}
            </a>
        </div>
    {/if}
    <footer class="footer ver_0{$footer.ver}">
        {include file="footers/footer{$footer.id}.tpl"}
    </footer>
{/foreach}

<noindex>
    <div id="nav__mobile-bg"></div>
    <section id="nav__mobile">
        <a href="#" class="nav__mobile-close">
            <img src="/i/icon__close.svg" alt="">
        </a>
        <nav class="mobile__nav">
            <ul class="mobile__list">
                {foreach item=data from=$APP->menu.topMenu}
                    <li class="mobile__item ">
                        <a href="{$data.URL}" class="mobile__link">{$data.title}</a>
                    </li>
                {/foreach}
            </ul>
        </nav>
        <div class="mobile__info">
            {if $mainParams.TEL !=""}
                <a href="tel:{$mainParams.TEL}" class="bar-info__phone">{$mainParams.TEL}</a>
            {/if}
            <a href="#popup__order" class="bar-info__call open__popup" data-title="Заказать звонок">
                Заказать звонок
            </a>
        </div>

    </section>
</noindex>