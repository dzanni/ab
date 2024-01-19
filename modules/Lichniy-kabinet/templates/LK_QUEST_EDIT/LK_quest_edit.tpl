<main>
    <div class="lk_menu lk_user quest__edit">
        <h1>{$smarty_params.h1}</h1>
        {$msg_load_price}

        {assign var="res" value=$result.0}
        {if $res.id}
            <div class="quest__edit-wrap">
                <div class="quest__edit-photo">
                    <img src="{$viewer->get_icon_by_user($res.user)}" class="quest__edit-img">
                </div>
                <div class="quest__edit-info">
                    <h4>{$viewer->get_name_user($res.user)}</h4>
                    <!--<h4>ID: {$res.id}</h4>
            <h4>Дата: {$res.date}</h4>

            <hr>-->
                    <!--h4 class="lk_user_subtitle"><label for="field_description">Вопрос</label></h4-->
                    <textarea class="js_chg slyle_input_textarea " id="field_title"
                              data-field="f_title" data-id="{$res.id}" rows="14">{$res.title}</textarea>
                    {* <a class="account__button js_chg_field" data-id="field_description">Сохранить описание</a>*}


                    <!--h4 class="lk_user_subtitle">Файлы</h4-->
                    <div class="sort_files">
                        {foreach from=$smarty_params.files item=f}
                            <div class="files_block">
                                {$f.user_filename}.{$f.ext}
                                <span class="js_delete_quest_files cross" data-filename="{$f.filename}" data-id="{$f.id}"></span>
                            </div>
                        {/foreach}
                    </div>
                    <form class="upload" data-type="quest_files" method="post"
                          action="/account/quests/?lk_quest_edit_profile={$res.id}&upload" enctype="multipart/form-data">
                        <div class="drop">
                            <input type="hidden" name="quest" value="{$res.id}">
                            <input type="file" name="upl" id="file" multiple="">
                            <label for="file">Прикрепить файлы</label>
                            <p>Или перетащите файлы в эту область</p>
                        </div>
                        <ul></ul>
                    </form>

                    <h4 class="lk_user_subtitle">Теги</h4>
                    <p>Отметьте свой вопрос тегами, чтобы его быстрее могли найти другие эксперты</p>
                    <div class="lk_tag_box">
                        {foreach from=$smarty_params.tags item=data}

                            <div class="lk_tag_box_two_colons">
                                <div class="js_chg_element">
                                    <h4 class="tag_title_toggle js_tag_title_toggle">{$data.title}</h4>

                                    <div class="tag_cloud">
                                        {foreach from=$data.inner key=key item=data1}
                                            {if $obj->check_tag_select($data1.id, 0)}
                                                <div class="tag_cloud_item checked">
                                                    {$data1.title}
                                                    <span class="js_delete_tag_quest cross_small" data-id="{$data1.id}" data-quest="{$res.id}"></span>
                                                </div>
                                            {/if}
                                        {/foreach}
                                    </div>

                                    <div class="filter_js_anchor tag_title_anchor">
                                        <input type="text" placeholder="Найти"
                                               class="js_fast_filter_mark filter_checkbox_search_lk" value="">
                                        <div class="tag_cloud">
                                            {foreach from=$data.inner key=key item=data1}
                                                <div class="tag_cloud_item label {if $obj->check_tag_select($data1.id, 0)}checked{/if} js_add_tag_quest" data-id="{$data1.id}" data-quest="{$res.id}">
                                                    <span class="filter-form__label-title">{$data1.title}</span>
                                                </div>
                                            {/foreach}
                                            <div class="tag_cloud_item label gray">
                                                <a href="#popup__tag" class="filter-form__label-title open__popup_tag" data-id="{$data.id}">Предложить другой тег</a>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            {if $data.id ==1}
                                <div class="lk_tag_box_two_colons">
                                    <div class="js_chg_element js_reg_tag_anchor">
                                        <h4 class="tag_title_toggle js_tag_title_toggle">Регион</h4>

                                        <div class="tag_cloud">
                                            {foreach from=$smarty_params.regions item=reg}
                                                {if $obj->check_tag_select($reg.id, 0)}
                                                    <div class="tag_cloud_item checked">
                                                        {$reg.title}
                                                        <span class="js_delete_tag_quest cross_small" data-id="{$reg.id}" data-quest="{$res.id}"></span>
                                                    </div>
                                                {/if}
                                            {/foreach}
                                        </div>

                                        <div class="filter_js_anchor tag_title_anchor">
                                            <input type="text" placeholder="Найти"
                                                   class="js_fast_filter_mark filter_checkbox_search_lk" value="">
                                            <div class="tag_cloud">
                                                {foreach from=$smarty_params.regions item=reg}
                                                    <div class="tag_cloud_item label {if $obj->check_tag_select($reg.id, 0)}checked{/if} js_add_tag_quest" data-id="{$reg.id}" data-quest="{$res.id}">
                                                        <span class="filter-form__label-title">{$reg.title}</span>
                                                    </div>
                                                {/foreach}
                                                <div class="tag_cloud_item label gray">
                                                    <a href="#popup__tag" class="filter-form__label-title open__popup_tag" data-id="-1">Предложить другой тег</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                        {/foreach}
                    </div>

                    {if $smarty_params.role_GAK < 4}
                        <div class="moderation_block">
                            <a class="js_activate_quest account__button button button--orange" data-id="{$res.id}" data-status="{$res.status}">{if $res.status}Скрыть{else}Активировать{/if}</a>
                            <div class="alerts_moderation"></div>
                        </div>
                    {/if}

                    {if $smarty_params.role_GAK >= 4}
                        <br>
                        <h4 class="lk_user_subtitle">Технические параметры (видно только администраторам)</h4>
                        <h4>Статус</h4>
                        <select class="js_add_tlg_quest js_chg lk_select select" data-field="f_status" data-id="{$res.id}">
                            <option value="0" {if $res.status==0}selected="selected"{/if}>Не активен</option>
                            {*<option value="2" {if $res.status==2}selected="selected"{/if}>На модерации</option>*}
                            <option value="1" {if $res.status==1}selected="selected"{/if}>Активен</option>
                        </select>
                        <br><br>
                        <h4>Закреп</h4>
                        <select class="js_chg lk_select select" data-field="f_main" data-id="{$res.id}">
                            <option value="0" {if $res.main==0}selected="selected"{/if}>Без закрепа</option>
                            <option value="1" {if $res.main==1}selected="selected"{/if}>Закреп</option>
                        </select>
                    {/if}


                    {*  <div class="moderation_block">
                                {if $res.status == 0}
                                        <a class="js_moderation_quest account__button orange" data-id="{$res.id}">Отправить на модерацию</a>
                                {elseif $res.status == 2}
                                        Запрос на модерацию отправлен
                                {/if}
                        </div>
                    *}


                    <br><br>
                    <a class="account__button button button--orange" href=/account/quests/>Редактировать все вопросы и новости</a>
                    <br><br>


                    <div class="alerts"></div>
                </div></div>
        {else}
            <h3>Доступ запрещен</h3>
        {/if}


    </div>
</main>