<section class="advantage ver_01 advantage_ver_01_02">
    <div class="container-fluid">
        {if $block.0.title !=""}
            <h1 class="page__title">{$block.0.title}</h1>
        {/if}
        <div class="row">
            {foreach from=$block.0.inner item=data}
                <div class="col-12 col-md-6 col-lg-3">
                    <div class="advantage__item row">
                        {if $data.IMG !=""}
                            <div class="advantage__icon col-sm-2">
                                <img src="/{$data.IMG}" alt="" class="svg">
                            </div>
                        {/if}
                        <div class="{if $data.IMG !=""}col-sm-10"{else}{/if}>
                            {if $data.title !=""}
                                <div class="advantage__title">{$data.title}</div>
                            {/if}
                            {if $data.text !=""}
                                <div class="advantage__desc">{$data.text}</div>
                            {/if}
                        </div>

                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</section>