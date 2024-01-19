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
                        <div class="plus__list">
                            {foreach from=$block.0.inner item=data}
                                <div class="plus__item">
                                    <div class="plus__img"><img src="/{$data.img}" alt=""></div>
                                    <div class="plus__text">{$data.text}</div>
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

