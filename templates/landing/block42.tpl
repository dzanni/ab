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
                        <div class="video__list">
                            {foreach from=$block.0.inner item=data}
                            <div class="video__item">
                                <div class="video__yt">
                                    <iframe width="560" height="315" src="{$data.URL}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
                                </div>
                                <div class="video__title">{$data.text}</div>
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

