<section class="team ver_01">
    <div class="container-fluid">
        {if $block.0.title !=""}
            <h1 class="page__title">{$block.0.title}</h1>
        {/if}
        <div class="team__slider">
            {foreach from=$block.0.inner item=data}
                <div class="team__item">

                    <div class="team__img">
                        {if $data.IMG !=""}
                        <img src="/{$data.IMG}" class="team__image" alt="">
                        {else}
                            <img src="/i/team/person.png" class="team__image" alt="">
                        {/if}
                    </div>

                    <div class="team__title">{$data.title}</div>
                    <div class="team__desc">{$data.text}</div>
                </div>
            {/foreach}
        </div>
    </div>
</section>