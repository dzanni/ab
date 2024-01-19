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
                        <div class="service__list">
                            {foreach from=$block.0.inner item=data}
                            <div class="service__item">
                                <div class="service__img"><img src="/{$data.img}" alt=""></div>
                                <div class="service__desc">
                                    <div class="service__title">{$data.title}</div>
                                    <div class="service__text">{$data.text}</div>
                                    <a class="service__button" href="{$data.URL}" target="_blank">Узнать подробнее</a>
                                </div>
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

