<section class="content ver_03">
    <div class="container-fluid">
        {if $block.0.title != ""}
            <h1 class="content__title"> {$block.0.title}</h1>
        {/if}
        <div class="content__desc">

            {if $block.0.inner_align == "Слева"}

                <div class="content__num">
                    {foreach from=$block.0.inner item=data}
                        <div class="content__num-item">
                            <div class="content__num-info">
                                {if $data.title != ""}
                                    <div class="content__num-count">
                                        {$data.title}
                                    </div>
                                {/if}
                                {if $data.text != ""}
                                    <div class="content__num-desc">
                                        {$data.text}
                                    </div>
                                {/if}
                            </div>
                        </div>
                    {/foreach}
                </div>

                <div class="content__text" style="padding-right: 0; padding-left: 150px">
                    <p> {$block.0.text}</p>
                    {if $block.0.button_text !=""}
                        {if $block.0.button_type == "Ссылка"}
                            <a href="{$block.0.button_url}" class="button main-screen__more">
                                {$block.0.button_text}
                            </a>
                        {elseif $block.0.button_type == "Форма"}
                            <a href="#popup__order" class="button main-screen__more open__popup"
                               data-title="{$block.0.button_popup}">
                                {$block.0.button_text}
                            </a>
                        {/if}
                    {/if}
                </div>

            {else}

                <div class="content__text">
                    <p> {$block.0.text}</p>
                    {if $block.0.button_text !=""}
                        {if $block.0.button_type == "Ссылка"}
                            <a href="{$block.0.button_url}" class="button main-screen__more">
                                {$block.0.button_text}
                            </a>
                        {elseif $block.0.button_type == "Форма"}
                            <a href="#popup__order" class="button main-screen__more open__popup"
                               data-title="{$block.0.button_popup}">
                                {$block.0.button_text}
                            </a>
                        {/if}
                    {/if}
                </div>

                <div class="content__num">
                    {foreach from=$block.0.inner item=data}
                        <div class="content__num-item">
                            <div class="content__num-info">
                                {if $data.title != ""}
                                    <div class="content__num-count">
                                        {$data.title}
                                    </div>
                                {/if}
                                {if $data.text != ""}
                                    <div class="content__num-desc">
                                        {$data.text}
                                    </div>
                                {/if}
                            </div>
                        </div>
                    {/foreach}
                </div>

            {/if}
        </div>
    </div>
</section>