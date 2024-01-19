<section class="main-screen ver_02">
    <img src="/{$block.0.IMG}" class="main-screen__bg" alt="">
    <div class="container-fluid">
        {if $block.0.suptitle !=""}
            <div class="main-screen__label">
                {$block.0.suptitle}
            </div>
        {/if}
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

        <div class="main-screen__buttons">

             {if $block.0.left_button_text !=""}
                {if $block.0.left_button_type == "Ссылка"}
                    <a href="{$block.0.left_button_url}" class="button main-screen__more" {if $block.0.right_button_text ==""}style="margin-right: 0"{/if}>
                        {$block.0.left_button_text}
                    </a>
                {elseif $block.0.left_button_type == "Форма"}
                    <a href="#popup__order" class="button main-screen__more open__popup" data-title="{$block.0.left_button_popup}" {if $block.0.right_button_text ==""}style="margin-right: 0"{/if}>
                        {$block.0.left_button_text}
                    </a>
                {/if}
            {/if}

            {if $block.0.right_button_text !=""}
                {if $block.0.right_button_type == "Ссылка"}
                    <a href="{$block.0.right_button_url}" class="button main-screen__more" {if $block.0.left_button_text ==""}style="margin-right: 0"{/if}>
                        {$block.0.right_button_text}
                    </a>
                {elseif $block.0.right_button_type == "Форма"}
                    <a href="#popup__order" class="button main-screen__order open__popup" data-title="{$block.0.right_button_popup}" {if $block.0.left_button_text ==""}style="margin-right: 0"{/if}>
                        {$block.0.right_button_text}
                    </a>
                {/if}
            {/if}
        </div>
    </div>
</section>



