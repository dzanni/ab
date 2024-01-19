{*<div class="page-inner page-comp03">*}
    {*<aside>*}
    {*</aside>*}
    {*<main>*}
        {*{if $right_block}*}
        {*<div class="comp__column">*}
            {*<div class="comp__block">*}
                {*{/if}*}

                <div class="content__block">
                    <div class="block__title gallery__title">{$block.0.title}
                        <div class="gallery__nav">
                            <div class="gallery-nav__prev">‹</div>
                            <div class="gallery-nav__nums">
                                <div class="gallery-nav__current">1</div>/
                                <div class="gallery-nav__all"> </div>
                            </div>
                            <div class="gallery-nav__next">›</div>
                        </div>
                    </div>
                    <div class="block__content">

                        <div class="gallery__ver03">
                            {foreach from=$block.0.inner item=data}
                            <div class="gallery-ver03__item">
                                <img src="/{$data.IMG}" alt="">
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

