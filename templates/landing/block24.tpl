<section class="partners ver_02">
    <div class="container-fluid">
        <div class="row">
            {if $block.0.title !="" && $block.0.align == "Справа"}
                <div class="col-12 col-md-6">
                    <h1 class="page__title">{$block.0.title}</h1>
                </div>
            {/if}

            <div class="{if $block.0.title !=""}col-12 col-md-6 {/if}">
                <div class="partners__list">
                    {foreach from=$block.0.inner item=data}
                        <div class="partners__item">
                            <div class="partners__inner">
                                <img src="/{$data.IMG}" alt="">
                            </div>
                        </div>
                    {/foreach}
                </div>
            </div>


            {if $block.0.title !="" && $block.0.align == "Слева"}
                <div class="col-12 col-md-6">
                    <h1 class="page__title">{$block.0.title}</h1>
                </div>
            {/if}


        </div>
    </div>
</section>