<section class="search ver_02 ver_02_small left_form">
    <div class="search__items">
        <div class="search__items-tabs">
            {$viewer->render_tyre_search_form("main_form.tpl", "tire", true)}
        </div>
    </div>
    <div class="search__slider owl-theme media-hidden">
        {foreach from=$block item=data}
            <div class="search__slider-item" style="background-image: url(/{$data.IMG});">
                <div class="container-fluid">
                    {if $data.text !=""}
                        <div class="search__title">
                            {$data.text}
                        </div>
                    {/if}
                    {if $data.button_text !=""}
                        {if $data.button_type == "Ссылка"}
                        <a href="{$data.URL}" class="button search__more">
                            {$data.button_text}
                        </a>
                        {elseif $data.button_type == "Форма"}
                            <a href="#popup__order" class="button search__more open__popup" data-title="Подбор шин">
                                {$data.button_text}
                            </a>
                        {/if}
                    {/if}
                </div>
            </div>
        {/foreach}
    </div>
    {if count($block) > 1}
    <div class="search__slider-nav">
        <button class="slider-nav__button slider-nav__prev"><img class="svg" src="/i/icon__slider-prev.svg" alt="">
        </button>
        <button class="slider-nav__button slider-nav__next"><img class="svg" src="/i/icon__slider-next.svg" alt="">
        </button>
    </div>
    {/if}
</section>

<div class="shina_disk_search_result"></div>



