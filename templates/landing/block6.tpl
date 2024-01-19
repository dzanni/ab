<section class="pict_slider ver_01">
    <div class="pict_slider__slider owl-theme">
        {foreach from=$block item=data}
            <div class="pict_slider__slider-item" style="background-image: url(/{$data.IMG});">
                <div class="container-fluid">
                    {if $data.text != ""}
                        <div class="pict_slider__title">
                            {$data.text}
                        </div>
                    {/if}
                    {if $data.button_text != ""}

                        {if $data.button_type == "Ссылка"}
                            <a href="{$data.button_url}" class="button pict_slider__more">
                                {$data.button_text}
                            </a>
                        {elseif $data.button_type == "Форма"}
                            <a href="#popup__order" class="button pict_slider__more open__popup" data-title="{$data.button_popup}">
                                {$data.button_text}
                            </a>
                        {/if}

                    {/if}
                </div>
            </div>
        {/foreach}
    </div>
    <div class="pict_slider__slider-nav">
        <button class="slider-nav__button slider-nav__prev"><img class="svg" src="/i/icon__slider-prev.svg" alt="">
        </button>
        <button class="slider-nav__button slider-nav__next"><img class="svg" src="/i/icon__slider-next.svg" alt="">
        </button>
    </div>
</section>
