<section id="catalog">
    <div class="container-fluid">

    <div class="news">
      {*  <h1>Лента новостей</h1>*}

        {foreach from=$news item=d}
            <div class="news__item">
            <div class="news__title">{$d.title}</div>
            <div class="news__text">{$d.date}</div>
            <div class="news__text">{$d.content}</div>
            <a href="/news/{$d.id}/" class="btn__news"><span>Перейти к новости</span></a>
            </div>
        {/foreach}

    {if count($pages) != 1 && !$no_show_extra_params}
        <div class="catalog__pagination justify-center">

            {if $page_current != 1}
                <a href="{$left_url}" class="catalog__pagination-prev">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M15.8334 10H4.16669" stroke="#4C5475" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M10 15.8334L4.16669 10.0001L10 4.16675" stroke="#4C5475" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </a>
            {/if}

            {foreach $pages as $p}
                {if $p.page == "..."}
                    <span class="catalog__pagination-link">{$p.page}</span>
                {else}
                    <a href="{$p.url}" class="catalog__pagination-link {if $p.active}active{/if}">{$p.page}</a>
                {/if}
            {/foreach}

            {if $page_current != $p.page}
                <a href="{$right_url}" class="catalog__pagination-next">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M4.16671 10H15.8334" stroke="#4C5475" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M10 15.8334L15.8334 10.0001L10 4.16675" stroke="#4C5475" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </a>
            {/if}

        </div>
   {/if}

    </div>
</div>
</section>