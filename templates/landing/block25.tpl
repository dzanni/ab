<section class="stages ver_01">
    <div class="container-fluid">
        {if $block.0.title !=""}
            <h1 class="page__title">{$block.0.title}</h1>
        {/if}
        <div class="stages__list">
            {foreach from=$block.0.inner key=key item=data}
                <div class="stages__item">
                    <div class="stages__num">{$key+1}</div>
                    <div class="stages__arrow"></div>
                    <div class="stages__title">{$data.title}</div>
                    <div class="stages__desc">{$data.text}</div>
                </div>
            {/foreach}
        </div>
    </div>
</section>