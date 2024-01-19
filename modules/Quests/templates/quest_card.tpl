<section class="firm_card">
    <div class="container-fluid">
        <div class="firm_card_top">

            <div class="firm_logo_group">
                <div class="firm_logo">
                    <img style="max-width: 100%;" alt="{$quest.name} {$quest.family_name}"
                         src="/images/u/{if $quest.foto}{$quest.user}.jpg{else}incognito.svg{/if}" width="100%"
                         height="100%">
                </div>
                <div>Автор: <a href="/users/?user={$quest.user}"
                               class="user_link_render">{$quest.name} {$quest.family_name}</a>
                </div>
            </div>

            <div class="firm_info">

                <h1>{$quest.title} </h1>

                {if $tags}
                    <div class="tags tooltip_parent">
                        {foreach from=$tags item=data}
                            {if $data.title != ''} <a href="/quests/?tag={$data.id}">#{$data.title}</a>{/if}
                        {/foreach}
                        <img class="js_tooltip" src="/i/info_icon_min.png">
                    </div>
                    <div class="tooltip_text hidden">Отвечать на вопрос могут пользователи, у которые
                        есть {if count($tags) == 1}этот тег{else}все перечисленные теги{/if}</div>
                {/if}

                <div>
                    <br>
                    {$quest.date}
                </div>

                {if $files}
                    <div>
                        <br>
                        Приложенные файлы:<br>
                        <br>
                        {foreach from=$files item=data}
                            <a href="/files/quest/{$data.filename}"
                               style="text-decoration: underline">{$data.user_filename}.{$data.ext}</a>
                            <br>
                        {/foreach}
                    </div>
                {/if}

            </div>
        </div>

        {if $obj->checkAnswerRight($quest.id)}
            <div class="render_work_parent" data-answer="{$quest.answer.id}" data-quest="{$quest.id}">
                <div class="render_work_button">
                    <a class="account__button_render js_render_work_button js_answer_create">Ответить</a>
                </div>
                <div class="render_work hidden" data-answer_in_page="{$quest.answer_in_page}">
                    <div class="render_work-cross"><span
                                class="cross_small_render js_render_work_button"></span></div>

                    <div class="render_work-info">Ответ:</div>
                    <div>
                        <div>
                            <textarea class="answer">{$quest.answer.title}</textarea>
                        </div>
                    </div>

                    <div class="sort_files">
                        {foreach from=$quest.answer.files item=f}
                            <div class="files_block">
                                <a href="/files/answer/{$f.filename}" target="_blank">{$f.user_filename}.{$f.ext}</a>
                                <span class="js_delete_answer_files cross_tmp" data-filename="{$f.filename}" data-id="{$f.id}"></span>
                            </div>
                        {/foreach}
                    </div>
                    <br>
                    <form class="upload" data-type="answer_files" method="post"
                          action="/quests/?quest={$quest.id}&uploadAnswerFiles" enctype="multipart/form-data">
                        <div class="drop">
                            <input type="hidden" name="loadAnswerFiles" value="true">
                            <input type="hidden" name="answer" value="{$quest.answer.id}">
                            <input type="file" name="upl" id="file" multiple="">
                            <label for="file">Прикрепить файлы</label>
                            <p>Или перетащите файлы в эту область</p>
                        </div>
                        <ul></ul>
                    </form>

                    <a class="js_answer_submit account__button_render">Выполнить</a>
                    <div class="alert"></div>
                </div>

            </div>
            <br>
            <br>
        {/if}

        <hr>
        <br>
        <div class="firm_card_item_title">ОТВЕТЫ</div>
        <div class="js_answer_anchor">
            {foreach from=$quest.answers key=key item=data}
                <div class="user_card_item">
                    <div class="firm_card_item_title">
                        <a href="/users/?user={$data.user}">{$data.full_name}</a><br>
                    </div>
                    <div class="firm_card_item_date">
                        {$data.date}
                    </div>
                    {if $current_user->role_GAK >= 4 || $current_user->id == $data.user}
                        <textarea class="quest_answer">{$data.title}</textarea>
                        {foreach from=$data.files item=$data1}
                            <div class="firm_card_item_text">
                                <a href="/files/answer/{$data1.filename}" target="_blank">{$data1.user_filename}.{$data1.ext}</a>
                            </div>
                        {/foreach}
                        <a class="js_change_quest_answer account__button_render" data-id="{$data.id}">Сохранить</a>
                        <a class="js_delete_quest_answer black account__button_render" data-id="{$data.id}">Удалить</a>
                    {else}
                        <div class="firm_card_item_text">
                            {$data.title}
                        </div>
                        {foreach from=$data.files item=$data1}
                            <div class="firm_card_item_text">
                                <a href="/files/answer/{$data1.filename}" target="_blank">{$data1.user_filename}.{$data1.ext}</a>
                            </div>
                        {/foreach}
                    {/if}


                    <div class="firm_card_item_like">
                        <img src="/i/like1.svg" width="20" height="20"
                             {if $current_user->auth}class="js_like_counter like_img" data-id="{$data.id}"
                             data-obj="answer"{/if}> (<span class="js_like_counter_anchor">{$data.like}</span>)<br>
                    </div>
                </div>
            {/foreach}

            {if count($pages_answer) >1}
                <div class="catalog__pagination justify-center" data-quest="{$quest.id}">

                    {if $page_current_answer != 1}
                        <a class="js_change_answer_page catalog__pagination-prev"
                           data-page="{$page_current_answer-1}">
                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M15.8334 10H4.16669" stroke="#4C5475" stroke-width="1.66667"
                                      stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M10 15.8334L4.16669 10.0001L10 4.16675" stroke="#4C5475"
                                      stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </a>
                    {/if}

                    {foreach $pages_answer as $p}
                        {if $p.page == "..."}
                            <span class="catalog__pagination-link">{$p.page}</span>
                        {else}
                            <a class="js_change_answer_page catalog__pagination-link {if $page_current_answer == $p.page}active{/if}"
                               data-page="{$p.page}">{$p.page}</a>
                        {/if}
                    {/foreach}

                    {if $page_current_answer != count($pages_answer)}
                        <a class="js_change_answer_page catalog__pagination-next"
                           data-page="{$page_current_answer+1}">
                            <svg width="20" height="20" viewBox="0 0 20 20" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M4.16671 10H15.8334" stroke="#4C5475" stroke-width="1.66667"
                                      stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M10 15.8334L15.8334 10.0001L10 4.16675" stroke="#4C5475"
                                      stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </a>
                    {/if}

                </div>
            {/if}


        </div>


    </div>
    <br>
</section>