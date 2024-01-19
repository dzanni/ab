{*<div class="page-inner page-comp03">*}
    {*<aside>*}
    {*</aside>*}
    {*<main>*}
        {*{if $right_block}*}
        {*<div class="comp__column">*}
            {*<div class="comp__block">*}
                {*{/if}*}

                <div class="content__block">
                    <div class="block__title">{$block.0.title}</div>
                    <div class="block__content">
                        <div class="event__list block__hidden">
                            {foreach from=$block.0.inner key=key item=data}
                            <div class="event__item {if $key > 1}to_hide hidden{/if}">
                                <div class="event__img">
                                    <img src="/{$data.img}" alt="">
                                </div>
                                <div class="event__desc">
                                    <a class="event__title" href="{$data.URL}" target="_blank">{$data.title}</a>
                                    <div class="event__text">{$data.text}</div>
                                    <div class="event__date">Дата проведения<span>{$data.date}</span></div>
                                    <a class="event__button" href="{$data.URL}" target="_blank">Узнать подробнее </a>
                                </div>
                            </div>
                            {/foreach}
                        </div>
                        {if count($block.0.inner) > 2}
                            <a class="show__all js_show_all" data-msg="Показать все">Показать все</a>
                        {/if}
                    </div>
                 </div>

                {*{if $right_block}*}
            {*</div>*}
        {*</div>*}
        {*{/if}*}
    {*</main>*}
{*</div>*}

