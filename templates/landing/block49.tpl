{*<div class="page-inner page-comp03">*}
    {*<aside>*}
    {*</aside>*}
    {*<main>*}
        {*{if $right_block}*}
        {*<div class="comp__column">*}
            {*<div class="comp__block">*}
                {*{/if}*}

                <div class="content__block">
                    <div class="block__title">{$block.0.title}</div>
                    <div class="block__content">
                        <div class="faq__list">
                            {foreach from=$block.0.inner item=data}
                            <div class="faq__item">
                                <div class="faq__title">{$data.title}<img class="svg" src="/i/build/content/svg/icon_faq_arrow_03.svg" alt=""></div>
                                <div class="faq__text">{$data.text}</div>
                            </div>
                            {/foreach}
                        </div>
                    </div>
                </div>

                {*{if $right_block}*}
            {*</div>*}
        {*</div>*}
        {*{/if}*}
    {*</main>*}
{*</div>*}

