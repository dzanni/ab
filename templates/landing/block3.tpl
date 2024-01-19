<section class="main-screen ver_03">
    <div class="main-screen__slider owl-theme">

        {foreach from=$block item=data}
            <div class="main-screen__slider-item">
                <img src="/{$data.IMG}" class="main-screen__bg" alt="">
                <div class="container-fluid">
                    {if $data.title !=""}
                        <div class="main-screen__title">
                            {$data.title}
                        </div>
                    {/if}
                    {if $data.text !=""}
                        <div class="main-screen__desc">
                            {$data.text}
                        </div>
                    {/if}

                    {if $data.button_text !=""}

                        {if $data.button_type == "Ссылка"}
                            <a href="{$data.button_url}" class="button main-screen__more">
                                {$data.button_text}
                            </a>
                        {elseif $data.button_type == "Форма"}
                            <a href="#popup__order" class="button main-screen__more open__popup" data-title="{$data.button_popup}">
                                {$data.button_text}
                            </a>
                        {/if}

                    {/if}

                </div>
            </div>
        {/foreach}

    </div>
    <div class="main-screen__slider-nav">
        <button class="slider-nav__button slider-nav__prev"><img class="svg" src="/i/icon__slider-prev.svg" alt="">
        </button>
        <button class="slider-nav__button slider-nav__next"><img class="svg" src="/i/icon__slider-next.svg" alt="">
        </button>
    </div>
</section>