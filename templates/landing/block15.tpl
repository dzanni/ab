<section class="advantage ver_02">
    <div class="container-fluid">
        {if $block.0.title !=""}
            <h1 class="page__title">{$block.0.title}</h1>
        {/if}
        <div class="row">

            {if $block.0.IMG !="" && $block.0.img_align == "Слева"}
                <div class="col-12 col-md-6">
                    <img src="/{$block.0.IMG}" class="advantage__image" alt="">
                </div>
            {/if}

            <div class="col-12 col-md-6">
                {foreach from=$block.0.inner item=data}
                    <div class="advantage__item">

                        {if $data.IMG !=""}
                            <div class="advantage__icon">
                                <img src="/{$data.IMG}" alt="" class="svg">
                            </div>
                        {/if}
                        <div class="advantage__info">
                            {if $data.title !=""}
                                <div class="advantage__title">{$data.title}</div>
                            {/if}
                            {if $data.text !=""}
                                <div class="advantage__desc">{$data.text}</div>
                            {/if}
                        </div>
                    </div>
                {/foreach}
            </div>

            {if $block.0.IMG !="" && $block.0.img_align == "Справа"}
                <div class="col-12 col-md-6">
                    <img src="/{$block.0.IMG}" class="advantage__image" alt="">
                </div>
            {/if}


        </div>
    </div>
</section>