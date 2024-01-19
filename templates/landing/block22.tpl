<section class="partners ver_01">
    <div class="container-fluid">
        {if $block.0.title !=""}
            <h1 class="page__title">{$block.0.title}</h1>
        {/if}
        <div class="partners__slider">
            {foreach from=$block.0.inner item=data}
            <div class="partners__item">
                <div class="partners__inner">
                    <img src="/{$data.IMG}" alt="">
                </div>
            </div>
            {/foreach}
        </div>
    </div>
</section>