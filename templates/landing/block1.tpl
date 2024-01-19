<section class="main-screen ver_01">
    <img src="/{$block.0.IMG}" class="main-screen__bg" alt="">
    <div class="container-fluid">
        {if $block.0.title !=""}
            <div class="main-screen__title">
                {$block.0.title}
            </div>
                {/if}
        {if $block.0.text !=""}
            <div class="main-screen__desc">
                {$block.0.text}
            </div>
               {/if}

        {if $block.0.button_text !=""}
            {if $block.0.button_type == "Ссылка"}
                <a href="{$data.0.URL}" class="button main-screen__more">
                    {$block.0.button_text}
                </a>
            {elseif $block.0.button_type == "Форма"}
                <a href="#popup__order" class="button main-screen__more open__popup" data-title="{$block.0.popup_title}">
                    {$block.0.button_text}
                </a>
            {/if}
        {/if}

    </div>
</section>