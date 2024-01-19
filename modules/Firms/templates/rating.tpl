{*Рейтинг: {$rating}*}
{*<br>*}
{*<div class="rating-result">*}
    {*<span {if $rating > 0}class="active"{/if}></span>*}
    {*<span {if $rating > 1}class="active"{/if}></span>*}
    {*<span {if $rating > 2}class="active"{/if}></span>*}
    {*<span {if $rating > 3}class="active"{/if}></span>*}
    {*<span {if $rating > 4}class="active"{/if}></span>*}
{*</div>*}

<div class="comp__item-rating-count">{$rating|string_format:"%.1f"}</div>
<div class="comp__item-rating-stars js_reviews">
    <div class="comp__item-rating-stars active"
         style="width: width: {$firm.rating_persent}%">
        {for $i=1 to $rating|ceil}
            <img src="/i/build/content/svg/icon_star-full_03.svg" alt="">
        {/for}
    </div>
    <img src="/i/build/content/svg/icon_star_03.svg" alt="">
    <img src="/i/build/content/svg/icon_star_03.svg" alt="">
    <img src="/i/build/content/svg/icon_star_03.svg" alt="">
    <img src="/i/build/content/svg/icon_star_03.svg" alt="">
    <img src="/i/build/content/svg/icon_star_03.svg" alt="">
</div>
<div class="comp__item-rating-reviews">({$col})</div>
