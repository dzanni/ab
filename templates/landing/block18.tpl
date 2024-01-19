<section class="team ver_02">
    <div class="container-fluid">
        {if $block.0.title !=""}
            <h1 class="page__title">{$block.0.title}</h1>
        {/if}
        <div class="team__slider">

            {foreach from=$block.0.inner item=data}
                <div class="team__item">
                    <div class="team__inner">
                        <div class="team__img">
                            {if $data.IMG !=""}
                                <img src="/{$data.IMG}" class="team__image" alt="">
                            {else}
                                <img src="/i/team/person.png" class="team__image" alt="">
                            {/if}
                        </div>
                        <div class="team__info">

                            <div class="team__title">{$data.title}</div>
                            {if $data.subtitle != ""}
                                <div class="team__desc">{$data.subtitle}</div>
                            {/if}
                            <div class="team__old">{$data.param}{if $data.param !=""}:{/if} <span>{$data.text}</span>
                            </div>

                            <div class="team__soc">
                                {if $data.VK != ""}
                                    <a href="{$data.VK}" class="team-soc__link">
                                        <img src="/i/soc__vk.svg" alt="" class="svg">
                                    </a>
                                {/if}{if $data.FB != ""}
                                    <a href="{$data.FB}" class="team-soc__link">
                                        <img src="/i/soc__fb.svg" alt="" class="svg">
                                    </a>
                                {/if}
                                {if $data.INST != ""}
                                    <a href="{$data.INST}" class="team-soc__link">
                                        <img src="/i/soc__in.svg" alt="" class="svg">
                                    </a>
                                {/if}
                                {if $data.TLG != ""}
                                    <a href="{$data.TLG}" class="team-soc__link">
                                        <img src="/i/soc__tg.svg" alt="" class="svg">
                                    </a>
                                {/if}
                                {if $data.VB != ""}
                                    <a href="{$data.VB}" class="team-soc__link">
                                        <img src="/i/soc__vi.svg" alt="" class="svg">
                                    </a>
                                {/if}
                                {if $data.WA != ""}
                                    <a href="{$data.WA}" class="team-soc__link">
                                        <img src="/i/soc__wa.svg" alt="" class="svg">
                                    </a>
                                {/if}
                            </div>


                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</section>