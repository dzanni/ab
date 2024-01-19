<section class="stages ver_02">
    <div class="container-fluid">
        {if $block.0.title !=""}
            <h1 class="page__title">Этапы работ</h1>
        {/if}
        <div class="stages__slider">

            {foreach from=$block.0.inner item=data}
                <div class="stages__item">
                    <div class="row">

                        {if $data.IMG !="" &&  $data.img_align == "Слева"}
                            <div class="col-12 col-lg-6">
                                <img src="{$data.IMG}" class="stages__img" alt="">
                            </div>
                        {/if}

                        <div class="col-12 col-lg-6">
                            {if $data.title !=""}
                            <div class="stages__title">{$data.title}</div>
                            {/if}
                            {if $data.text !=""}
                            <div class="stages__desc">{$data.title}</div>
                            {/if}
                            {if $data.button_text !=""}
                                {if $data.button_type == "Ссылка"}
                                    <a href="{$data.button_url}" class="button">
                                        {$data.button_text}
                                    </a>
                                {elseif $data.button_type == "Форма"}
                                    <a href="#popup__order" class="button open__popup"
                                       data-title="{$data.button_popup}">
                                        {$data.button_text}
                                    </a>
                                {/if}
                            {/if}
                        </div>

                        {if $data.IMG !="" && $data.img_align == "Справа"}
                        <div class="col-12 col-lg-6">
                            <img src="{$data.IMG}" class="stages__img" alt="">
                        </div>
                        {/if}

                    </div>
                </div>
            {/foreach}

        </div>
    </div>
</section>