<section class="user_card">
    <div class="container-fluid">
        <div class="user_card_full">

            <div class="user_card_left">

                <h1>{$user.family_name} {$user.name} {if $user.father_name_show}{$user.father_name}{/if}  {if $user.autoboss_status}({$user.autoboss_status}){/if} </h1>

                <div class="user_card_foto_inner">
                    <img style="max-width: 100%;" alt="{$user.name} {$user.family_name}"
                         src="/images/u/{if $user.foto}{$user.id}.jpg{else}incognito.svg{/if}">
                    {if $user.score}
                    <div class="user_card_item">
                        <div class="user_card_item_title">
                            Рейтинг: {$user.score} баллов
                        </div>
                    </div>
                {/if}
                </div>

                {if $user.job_title_show}
                    <div class="job_title">{$user.job_title}</div>
                {/if}
                <div class="job_place">{$user.job_place}</div>

                {if $user.login_show}
                    <div class="user_card_contact">
                        <div class="user_card_item_text">
                            <img src="/i/icon__mail.svg" class="user_card_item_img">
                            <a href="mailto:{$user.login}">{$user.login}</a>
                        </div>
                    </div>
                {/if}
                {if $user.tel_show}
                    <div class="user_card_contact">
                        <div class="user_card_item_text">
                            <img src="/i/icon__phone.svg" class="user_card_item_img">
                            <a href="tel:{$user.tel}">{$user.tel}</a>
                        </div>
                    </div>
                {/if}
                <br>
                {if $user.birthday_show}
                    <div class="user_card_birthday">
                        Дата рождения:
                        {$user.birthday}
                    </div>
                {/if}
                {if $user.country_show}
                    <div class="user_card_birthday">
                        Страна: {$user.country}
                    </div>
                {/if}
                {if $user.region_show}
                    <div class="user_card_birthday">
                        Регион: {$user.region}

                    </div>
                {/if}

                <br><br>

                <div class = "tags">
                {foreach from=$tags key=key item=data}

                   {* {if $key != ''} {$key} >{/if}*}
                        {foreach from=$data item=data1}
                            {if $data1 != ''} #{$data1}{/if}
                        {/foreach}

                {/foreach}
                </div>

                <br><br>
                <div class="user_card_item">
                    <div class="user_card_item_title">
                        Опыт в автобизнесе
                    </div>
                    <div class="user_card_item_text">
                        {$user.experience}
                    </div>
                </div>
                <div class="user_card_item">
                    <div class="user_card_item_title">
                        Достижения в автобизнесе
                    </div>
                    <div class="user_card_item_text">
                        {$user.success}
                    </div>
                </div>
                <div class="user_card_item">
                    <div class="user_card_item_title">
                        О себе
                    </div>
                    <div class="user_card_item_text">
                        {$user.about}
                    </div>
                </div>

                <br>


                {*

                        {foreach from=$field_netto key=key item=data}
                            <div class="user_card_item">
                            {$key}:<br>
                                {$user.$data}
                            </div>
                        {/foreach}

                *}

            </div>
            <div class="user_card_right">
                <img style="max-width: 100%;" alt="{$user.name} {$user.family_name}"
                     src="/images/u/{if $user.foto}{$user.id}.jpg{else}incognito.svg{/if}">
                {if $user.score}
                <div class="user_card_item">
                    <div class="user_card_item_title">
                        Рейтинг: {$user.score} баллов
                    </div>
                </div>
{/if}

            </div>


        </div>
    </div>
</section>