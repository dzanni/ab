{foreach from=$result item=ans}
    <div class="quest__item-inner quest__answer js_answer_anchor">
        <div class="quest__item-photo"><img class="quest__item-img" src="{$viewer->get_icon_by_user($ans.user)}" alt="">
        </div>
        <div class="quest__item-info">
            <div class="quest__item-header">
                <a class="quest__item-name" href="/users/?user={$ans.user}">{$ans.family_name} {$ans.name}</a>

                {if $ans.can_edit}
                    <div class="quest__nav-icon">
                        <a class="js_edit_answer">
                            <svg class="svg-sprite-icon icon-icon__q-edit">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-edit"></use>
                            </svg>
                        </a>

                        <a class="quest__nav-del js_remove_answer" data-id="{$ans.id}">
                            <svg class="svg-sprite-icon icon-icon__q-del">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-del"></use>
                            </svg>
                        </a>
                    </div>
                {/if}
            </div>
            <div class="quest__item-q-f js_tooltip_anchor">
                <div class="quest__item-q">{$ans.title_txt}

                    <div class="quest__item-like {if $ans.likes_my}checked{/if} {if $ans.can_like}js_like_counter{/if}"
                         {if $ans.can_like}data-id="{$ans.id}" data-obj="answer"{/if}>
                        <div class="quest__like-link">
                            <svg class="svg-sprite-icon icon-icon__like">
                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__like"></use>
                            </svg>
                            <span class="js_like_counter_anchor">{$ans.likes}</span>
                        </div>
                    </div>
                </div>

                {if count($ans.files)}
                    <div class="quest__item-files">
                        <div class="quest__item-file">

                            {foreach from=$ans.files item=file}
                                {if $file.is_img}
                                    <a class="quest__file-img-link" data-fancybox href="/files/answer/{$file.filename}"
                                       alt="">
                                        <img class="quest__file-img" src="/files/answer/{$file.filename}" alt="">
                                    </a>
                                {else}
                                    <a class="quest__file-link" href="/files/answer/{$file.filename}" target="_blank">
                                        <svg class="svg-sprite-icon icon-icon__file">
                                            <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__file"></use>
                                        </svg>
                                        <span>{$file.user_filename}.{$file.ext}</span>
                                    </a>
                                {/if}
                            {/foreach}
                        </div>

                    </div>
                {/if}
            </div>

           {* Формa редактирования ответа*}
            <div class="js_quest_add hidden js_edit_answer_anchor" data-id="{$ans.id}" data-quest="{$ans.quest_id}">
                <div class="quest__item-add">
                    <div class="quest__add">
                    <textarea
                            class="quest__add-input js_otvet_txt textarea_autoheight">{$ans.title}</textarea>
                        <button class="quest__add-button button js_public_answer" type="button">Изменить</button>
                    </div>
                </div>
                <div class="sort_files">
                    {if $ans.files}
                        {foreach from=$ans.files item=afile}
                            <div class="files_block">
                                <a href="/files/answer/{$afile.filename}" target="_blank">{$afile.user_filename}
                                    .{$afile.ext}</a>
                                <span class="js_delete_answer_files cross_tmp" data-filename="{$afile.filename}"
                                      data-id="{$afile.id}"></span>
                            </div>
                        {/foreach}
                    {/if}
                </div>
                <br>
                <form class="upload {if !$ans.id}hidden{/if}" data-type="answer_files" method="post"
                      action="/quests/?upload" enctype="multipart/form-data">
                    <div class="drop">
                        <input type="hidden" name="loadAnswerFiles" value="true">
                        <input type="hidden" name="ans" class="js_ans_id" value="{$ans.id}">
                        <input type="file" class="upl_main_obj" name="upl" id="file_{$ans.id}" multiple="">
                        <label for="file_{$ans.id}">Прикрепить файлы</label>
                        <p>Или перетащите файлы в эту область</p>
                    </div>
                    <ul></ul>
                </form>

            </div>
           {* Конец формы редактирования ответа*}

            <div class="quest__item-footer">
                <div class="quest__item-date">{$viewer->render_date($ans.date)}
                    {if $current_user_id}
                        <a class="js_open_inner_answer_form open_inner_answer_form">Ответить на ответ</a>
                    {/if}
                </div>
            </div>

            <!---- Второй уровень ответов ----->
            <div class="answer_inner">
                {* Начало вставки формы ответа на ответ*}
                {if $current_user_id}
                    <div class="js_quest_add hidden" data-id="{$data.current_answer.id}" data-quest="{$ans.quest_id}"
                         data-parent="{$ans.id}">
                        <div class="quest__item-add">
                            <div class="quest__item-photo"><img class="quest__item-img"
                                                                src="{$viewer->get_icon_by_user($current_user_id)}" alt=""></div>
                            <div class="quest__add">
                    <textarea
                            class="quest__add-input js_otvet_txt textarea_autoheight">{$ans.name}, {$data.current_answer.title}</textarea>
                                <button class="quest__add-button button js_public_answer" type="button">Ответить</button>
                            </div>
                        </div>


                        <div class="sort_files">
                            {if $data.current_answer.files}
                                {foreach from=$data.current_answer.files item=afile}
                                    <div class="files_block">
                                        <a href="/files/answer/{$afile.filename}" target="_blank">{$afile.user_filename}
                                            .{$afile.ext}</a>
                                        <span class="js_delete_answer_files cross_tmp" data-filename="{$afile.filename}"
                                              data-id="{$afile.id}"></span>
                                    </div>
                                {/foreach}
                            {/if}
                        </div>
                        <br>

                        <form class="upload {if !$data.current_answer.id}hidden{/if}" data-type="answer_files" method="post"
                              action="/quests/?upload" enctype="multipart/form-data">
                            <div class="drop">
                                <input type="hidden" name="loadAnswerFiles" value="true">
                                <input type="hidden" name="ans" class="js_ans_id" value="{$data.current_answer.id}">
                                <input type="file" class="upl_main_obj" name="upl" id="file_{$data.current_answer.id}" multiple="">
                                <label for="file_{$data.current_answer.id}">Прикрепить файлы</label>
                                <p>Или перетащите файлы в эту область</p>
                            </div>
                            <ul></ul>
                        </form>

                    </div>
                {/if}
                {* Конец вставки *}

                {* Ответы на ответы*}

                {if $ans.inner}
                    {foreach from=$ans.inner item=in}
                        <div class="quest__item-inner quest__answer" data-id="{$in.id}">
                            <div class="quest__item-photo"><img class="quest__item-img" src="{$viewer->get_icon_by_user($in.user)}"
                                                                alt="">
                            </div>
                            <div class="quest__item-info">
                                <div class="quest__item-header">
                                    <div class="">
                                        <a class="quest__item-name" href="/users/?user={$in.user}">{$in.family_name} {$in.name}</a> ответил <a class="quest__item-name-inner js_tooltip" data-parent="{$in.parent}">{$viewer->getParentUserNameByAnswerId($in.parent)}</a>
                                    </div>
                                    <div class="tooltip_answer hidden">
                                        Тут текст
                                    </div>

                                    {if $in.can_edit}
                                        <div class="quest__nav-icon">
                                            <a class="js_edit_answer">
                                                <svg class="svg-sprite-icon icon-icon__q-edit">
                                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-edit"></use>
                                                </svg>
                                            </a>
                                            <a class="quest__nav-del js_remove_answer" data-id="{$in.id}">
                                                <svg class="svg-sprite-icon icon-icon__q-del">
                                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__q-del"></use>
                                                </svg>
                                            </a>
                                        </div>
                                    {/if}
                                </div>
                                <div class="quest__item-q-f second_level">
                                    <div class="quest__item-q">{$in.title_txt}

                                        <div class="quest__item-like {if $in.likes_my}checked{/if} {if $ans.can_like}js_like_counter{/if}"
                                             {if $in.can_like}data-id="{$in.id}" data-obj="answer"{/if}>
                                            <div class="quest__like-link">
                                                <svg class="svg-sprite-icon icon-icon__like">
                                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__like"></use>
                                                </svg>
                                                <span class="js_like_counter_anchor">{$in.likes}</span>
                                            </div>
                                        </div>
                                    </div>

                                    {if count($in.files)}
                                        <div class="quest__item-files">
                                            <div class="quest__item-file">

                                                {foreach from=$in.files item=file}
                                                    {if $file.is_img}
                                                        <a class="quest__file-img-link" data-fancybox
                                                           href="/files/answer/{$file.filename}"
                                                           alt="">
                                                            <img class="quest__file-img" src="/files/answer/{$file.filename}" alt="">
                                                        </a>
                                                    {else}
                                                        <a class="quest__file-link" href="/files/answer/{$file.filename}"
                                                           target="_blank">
                                                            <svg class="svg-sprite-icon icon-icon__file">
                                                                <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__file"></use>
                                                            </svg>
                                                            <span>{$file.user_filename}.{$file.ext}</span>
                                                        </a>
                                                    {/if}
                                                {/foreach}
                                            </div>

                                        </div>
                                    {/if}
                                </div>

                                {* Форма редактирования ответа на ответ*}
                                <div class="js_quest_add hidden js_edit_answer_anchor" data-id="{$in.id}" data-quest="{$ans.quest_id}"
                                     data-parent="{$ans.id}">
                                    <div class="quest__item-add">
                                        <div class="quest__add">
                    <textarea
                            class="quest__add-input js_otvet_txt textarea_autoheight">{$in.title}</textarea>
                                            <button class="quest__add-button button js_public_answer" type="button">Изменить</button>
                                        </div>
                                    </div>


                                    <div class="sort_files">
                                        {if $in.files}
                                            {foreach from=$in.files item=afile}
                                                <div class="files_block">
                                                    <a href="/files/answer/{$afile.filename}" target="_blank">{$afile.user_filename}
                                                        .{$afile.ext}</a>
                                                    <span class="js_delete_answer_files cross_tmp" data-filename="{$afile.filename}"
                                                          data-id="{$afile.id}"></span>
                                                </div>
                                            {/foreach}
                                        {/if}
                                    </div>
                                    <br>

                                    <form class="upload {if !$in.id}hidden{/if}" data-type="answer_files" method="post"
                                          action="/quests/?upload" enctype="multipart/form-data">
                                        <div class="drop">
                                            <input type="hidden" name="loadAnswerFiles" value="true">
                                            <input type="hidden" name="ans" class="js_ans_id" value="{$in.id}">
                                            <input type="file" class="upl_main_obj" name="upl" id="file_{$in.id}" multiple="">
                                            <label for="file_{$in.id}">Прикрепить файлы</label>
                                            <p>Или перетащите файлы в эту область</p>
                                        </div>
                                        <ul></ul>
                                    </form>

                                </div>
                                {* Конец формы редактирования ответа на ответ*}

                                <div class="quest__item-footer">
                                    <div class="quest__item-date">{$viewer->render_date($in.date)}
                                        {if $current_user_id}
                                            <a class="js_open_inner_answer_form_1 open_inner_answer_form">Ответить на ответ</a>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        </div>

                        {* Начало вставки формы ответа на ответ на ответ*}
                        {if $current_user_id}
                            <div class="js_quest_add hidden" data-id="{$data.current_answer.id}" data-quest="{$ans.quest_id}"
                                 data-parent="{$in.id}">
                                <div class="quest__item-add">
                                    <div class="quest__item-photo"><img class="quest__item-img"
                                                                        src="{$viewer->get_icon_by_user($current_user_id)}" alt=""></div>
                                    <div class="quest__add">
                    <textarea
                            class="quest__add-input js_otvet_txt textarea_autoheight">{$in.name}, {$data.current_answer.title}</textarea>
                                        <button class="quest__add-button button js_public_answer" type="button">Ответить</button>
                                    </div>
                                </div>


                                <div class="sort_files">
                                    {if $data.current_answer.files}
                                        {foreach from=$data.current_answer.files item=afile}
                                            <div class="files_block">
                                                <a href="/files/answer/{$afile.filename}" target="_blank">{$afile.user_filename}
                                                    .{$afile.ext}</a>
                                                <span class="js_delete_answer_files cross_tmp" data-filename="{$afile.filename}"
                                                      data-id="{$afile.id}"></span>
                                            </div>
                                        {/foreach}
                                    {/if}
                                </div>
                                <br>

                                <form class="upload {if !$data.current_answer.id}hidden{/if}" data-type="answer_files" method="post"
                                      action="/quests/?upload" enctype="multipart/form-data">
                                    <div class="drop">
                                        <input type="hidden" name="loadAnswerFiles" value="true">
                                        <input type="hidden" name="ans" class="js_ans_id" value="{$data.current_answer.id}">
                                        <input type="file" class="upl_main_obj" name="upl" id="file_{$data.current_answer.id}" multiple="">
                                        <label for="file_{$data.current_answer.id}">Прикрепить файлы</label>
                                        <p>Или перетащите файлы в эту область</p>
                                    </div>
                                    <ul></ul>
                                </form>

                            </div>
                        {/if}
                        {* Конец вставки *}

                    {/foreach}
                {/if}
            </div>



        </div>
    </div>

{/foreach}

{if count($pages) > 1}
    <div class="pagination js_answers_pagination">

        {*{if $page_current != 1}
            <a class="pagination-link">
                <svg class="svg-sprite-icon icon-icon__arrow-l">
                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__arrow-l"></use>
                </svg>
            </a>
        {/if}*}

        {foreach $pages as $p}
            {if $p.page == "..."}
                <span class="pagination-link">{$p.page}</span>
            {else}
                <a data-page="{$p.page}" class="pagination-link {if $p.active}active{/if}">{$p.page}</a>
            {/if}
        {/foreach}

        {*{if $page_current != count($pages)}
            <a href="{$right_url}" class="pagination-link">
                <svg class="svg-sprite-icon icon-icon__arrow-r">
                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__arrow-r"></use>
                </svg>
            </a>
        {/if}*}

    </div>
{/if}