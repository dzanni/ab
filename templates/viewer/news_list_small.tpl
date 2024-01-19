<section id="news">
    <div class="container-fluid">
        <div class="row">
            <div class="section__header justify-space align-center">
                <div class="section__title">
                    Новости
                </div>
                <a href="/news/" class="section__btn">Смотреть все новости</a>
            </div>
        </div>
        <div class="row">
            <div class="news__list">

                {foreach from=$news key=key item=d}
                    <a href="/news/{$d.id}" class="news__item {if $key==0 || $key==7}news__item-big{/if}">
                        <div class="news__item-desc">
                            <div class="news__item-date">{$d.date}</div>
                            <div class="news__item-title">
                                {$d.title}</div>
                        </div>
                        <img src="/images/news/{$d.image}" alt="" class="news-item__img">
                    </a>
                {/foreach}

            </div>
        </div>
    </div>
</section>



