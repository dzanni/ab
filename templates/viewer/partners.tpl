{* Если передан любой $flag, то верстка для внутренних страниц, иначе для главной*}
{* Фактически сейчас выводится только на главную*}
<section id="partners">
    <div class="container-fluid">
        <div class="row">
            <div class="section__header {if $flag}justify-center{else}justify-space{/if} align-center">
                <div class="section__title">
                   {if $flag}
                      В библиотеке <span class="title-blue">{$col}</span> моделей
                    {else}
                        С нами работают такие производители
                    {/if}

                </div>
                {if !$flag}<a href="/brand/" class="section__btn">Смотреть всех производителей</a>{/if}
            </div>
        </div>
        <div class="row">
            <div class="partners__list">
                {foreach from=$brands->result key=key item=b}
                 {if $flag || $key<18}
                 <a href="/brand/?brand={$b.id}" class="partners__item"><img src="/images/f/{$b.id}.jpg" alt="" class="partners__img"></a>
                  {/if}
                {/foreach}
            </div>

        </div>
        {if $flag}
        <div class="row justify-center">
            <a href="/brand/" class="partners__link-more">Показать все бренды</a>
        </div>
        {/if}

    </div>
</section>

