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
                        <div class="vacancies__list block__hidden">

                            {foreach from=$block.0.inner key=key item=data}
                            <div class="vacancies__item {if $key > 3}to_hide hidden{/if}">
                                <div class="vacancies__item-inner">
                                    <div class="vacancies__title">{$data.title}</div>
                                    <div class="vacancies__price">{$data.text}</div>
                                    <div class="vacancies__city">{$data.text1}</div>
                                    {if $data.URL}
                                        <br>                                                                                <a class="vacancies__city" href="{$data.URL}" target="_blank">
                                           Подробнее
                                        </a>
                                    {/if}
                                </div>
                            </div>
                            {/foreach}

                        </div>
                        {if count($block.0.inner) > 4}
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

