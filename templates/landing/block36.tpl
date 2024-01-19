{*<div class="page-inner page-comp03">*}
    {*<aside>*}
    {*</aside>*}
    {*<main>*}
        {*{if $right_block}*}
        {*<div class="comp__column">*}
            {*<div class="comp__block">*}
                {*{/if}*}

                <div class="content__block">
                    <div class="block__content">
                        <div class="block__open-popup">
                            <div class="open-popup__text">{$block.0.text}</div>
                            {if !$current_user->auth}
                            <a class="open-popup__button open__popup-firm" href="#popup__firm" data-title='{if $block.0.title}{$block.0.title}{else}Заявка{/if}' data-firm_page="1">{if $block.0.button_text}{$block.0.button_text}{else}Отправить{/if}</a>
                            {else}
                                <div class="js_form_quick_anchor">
                                <a class="open-popup__button js_send_form_quick" data-title='{if $block.0.title}{$block.0.title}{else}Заявка{/if}'>{if $block.0.button_text}{$block.0.button_text}{else}Отправить{/if}</a>
                                </div>
                            {/if}
                        </div>
                    </div>
                </div>

                {*{if $right_block}*}
            {*</div>*}
        {*</div>*}
        {*{/if}*}
    {*</main>*}
{*</div>*}

