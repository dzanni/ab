<section id="partners">
    <div class="container-fluid">
        <div class="row">
            <div class="section__header justify-space align-center">
                {*<div class="section__title">
                    С нами работают такие производители
                </div>*}
                          </div>
        </div>
        <div class="row">
            <div class="partners__list">
                {foreach from=$brands->result key=key item=b}
                    <a href="/brand/?brand={$b.id}" class="partners__item"><img src="/images/f/{$b.id}.jpg" alt="" class="partners__img"></a>
                {/foreach}

                </a>
            </div>
        </div>
    </div>
</section>



{*

<div class="partners">
    <div class="row">
        {foreach from=$brands->result item=b}
            <div class="col-md-2">
                <a href="/brand/?brand={$b.id}" class="partners__item"><img src="/images/f/{$b.id}.jpg" alt=""></a>
            </div>
        {/foreach}
    </div>
</div>
*}