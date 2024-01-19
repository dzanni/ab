<section class="content ver_02">
    <div class="container-fluid">
        {if $block.0.title != ""}
            <h1 class="content__title">{$block.0.title}</h1>
        {/if}

        {foreach from=$block.0.inner item=data}
            <div class="row">
                {if $data.img_align == "Справа"}

                    <div class="col-12 col-lg-6">
                        <img src="/{$data.IMG}" class="img-fluid" alt="">
                    </div>

                    <div class="col-12 col-lg-6 justify-center">
                        {if $data.title != ""}
                            <h2 class="content__title-two">
                                {$data.title}
                            </h2>
                        {/if}

                        <p>{$data.text}</p>
                    </div>
                {else}
                    <div class="col-12 col-lg-6 justify-center">

                        {if $data.title != ""}
                            <h2 class="content__title-two">
                                {$data.title}
                            </h2>
                        {/if}
                        <p>{$data.text}</p>
                    </div>
                    <div class="col-12 col-lg-6">
                        <img src="/{$data.IMG}" class="img-fluid" alt="">
                    </div>
                {/if}

            </div>
        {/foreach}


    </div>
</section>