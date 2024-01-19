{assign var="a" value=$firm.tarif}
<div class="content__block">
    <div class="block__title">Контакты</div>
    <div class="comp-contacts__list">
        {if $firm.email}
            <div class="comp-contacts__title">Почта</div>
            <div class="comp-contacts__value">
                {if ($firm.email|is_array)}
                    {if $a}
                        {foreach from=$firm.email item=data}
                            <div class="comp-contacts__value_inner">
                                <a href="mailto:{$data}">{$data}</a>
                            </div>
                        {/foreach}
                    {else}
                        {$firm.email.0}
                    {/if}
                {else}
                    {if $a}
                        <a href="mailto:{$firm.email}">{$firm.email}</a>
                    {else}
                        {$firm.email}
                    {/if}
                {/if}
            </div>
        {/if}
        {if $firm.phone}
            <div class="comp-contacts__title">Телефон{if (count($firm.phone)>1) && $a}ы{/if}</div>
            <div class="comp-contacts__value">
                {if ($firm.phone|is_array)}
                    {if $a}
                        {foreach from=$firm.phone item=data}
                            <div class="comp-contacts__value_inner">
                                <a href="tel:{$data}">{$data}</a>
                            </div>
                        {/foreach}
                    {else}
                        {$firm.phone.0}
                    {/if}
                {else}
                     {if $a}
                        <a href="tel:{$firm.phone}">{$firm.phone}</a>
                    {else}
                         {$firm.phone}
                    {/if}
                {/if}
            </div>
        {/if}
        {if $firm.address}
            <div class="comp-contacts__title">Адрес{if count($firm.address) > 1}а{/if}</div>
            <div class="comp-contacts__value">
                {if ($firm.address|is_array)}
                    {foreach from=$firm.address item=data}
                        <div class="comp-contacts__value_inner">
                            {$data}
                        </div>
                    {/foreach}
                {else}
                    {$firm.address}
                {/if}
            </div>
        {/if}
        {if $firm.site.0}
            <div class="comp-contacts__title">Сайт{if (count($firm.site.0)>1) && $a}ы{/if}</div>
            <div class="comp-contacts__value">
                {if $a}
                {foreach from=$firm.site.0 item=data}
                    <div class="comp-contacts__value_inner">
                        <a href="{$data.URL}"
                           target="_blank">{if $data.title}{$data.title}{else}{$data.URL}{/if}
                        </a>
                    </div>
                {/foreach}
                {else}
                    {$firm.site.0.0.URL}
                {/if}
            </div>
        {/if}
        {if $firm.site.1 && $a}
            <div class="comp-contacts__title">Другие ссылки</div>
            <div class="comp-contacts__value">
                {foreach from=$firm.site.0 item=data}
                    <div class="comp-contacts__value_inner">
                        <a href="{$data.URL}"
                         target="_blank">{if $data.title}{$data.title}{else}{$data.URL}{/if}
                        </a>
                    </div>
                {/foreach}
            </div>
        {/if}

    </div>
</div>

{if $firm.docs}
    <div class="content__block">
        <div class="block__title">Документы</div>
        <div class="documents__list block__hidden">
            {foreach from=$firm.docs key=key item=data}
                <div class="documents__item {if $key > 2}to_hide hidden{/if}">
                    <div class="documents__img"><img class="svg" src="/i/build/content/svg/icon_document_03.svg" alt=""></div>
                    <div class="documents__desc">
                        <div class="documents__title">{if $data.title}{$data.title}{else}Без названия{/if}</div>
                        {if $data.date}
                            <div class="documents__date">{$data.date}</div>
                        {/if}
                        <a class="documents__link" href="/files/docs/{$data.filename}" target="_blank">Открыть</a>
                    </div>
                </div>
            {/foreach}
        </div>
        {if count($firm.docs) > 3}
            <a class="show__all js_show_all" data-msg="Показать все документы">Показать все документы</a>
        {/if}
    </div>
{/if}