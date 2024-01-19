<section class="content ver_04">
    <div class="container-fluid">
        <div class="content__desc">
            {if $block.0.title !=""}
            <h1 class="content__title">{$block.0.title}</h1>
            {/if}
            <div class="content__text">
                <p>{$block.0.text}</p>

                {if $block.0.button_text !=""}
                    {if $block.0.button_type == "Ссылка"}
                        <a href="{$block.0.button_url}" class="button content__more">
                            {$block.0.button_text}
                        </a>
                    {elseif $block.0.button_type == "Форма"}
                        <a href="#popup__order" class="button content__more open__popup"
                           data-title="{$block.0.button_popup}">
                            {$block.0.button_text}
                        </a>
                    {/if}
                {/if}

            </div>
        </div>
        <img src="/{$block.0.IMG}" class="img-fluid" alt="">
    </div>
</section>