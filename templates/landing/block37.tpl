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
                        <div class="slider__ver03">
                            {foreach from=$block.0.inner item=data}
                            <{if $data.URL}a href="{$data.URL}" {if $data.target=="Да"}target="_blank"{/if}{else}div{/if} class="slider-ver03__item">
                                <img src="/{$data.img}" alt="">
                                <div class="slider-ver03__text">{$data.text}</div>
                                </{if $data.URL}a{else}div{/if}>
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

