<div class="container-fluid">
    <div class="lk_menu lk_user">
        {assign var="res" value=$result.0}

        {if $res.id}
            <h3>{$smarty_params.h1} (ID: {$res.id})</h3>
            {$msg_load_price}
            <hr>
            <h4 class="lk_user_subtitle">Базовые данные</h4>
            <h4>Имя *</h4>
            <input type="text" class="js_chg slyle_input" data-field="f_name" value="{$res.name}" data-id="{$res.id}"/>
            <h4>Отчество </h4>
            <input type="text" class="js_chg slyle_input" data-field="f_father_name" value="{$res.father_name}"
                   data-id="{$res.id}"/>
            <select class="js_chg lk_select" data-field="f_father_name_show" data-id="{$res.id}">
                <option value="0" {if $res.father_name_show==0}selected="selected"{/if}>Не показывать пользователям
                </option>
                <option value="1" {if $res.father_name_show==1}selected="selected"{/if}>Показывать пользователям
                </option>
            </select>
            <h4>Фамилия *</h4>
            <input type="text" class="js_chg slyle_input" data-field="f_family_name" value="{$res.family_name}"
                   data-id="{$res.id}"/>
            <h4>Дата рождения *</h4>
            <input type="date" class="js_chg slyle_input" data-field="f_birthday" value="{$res.birthday}"
                   data-id="{$res.id}"/>
            <select class="js_chg lk_select" data-field="f_birthday_show" data-id="{$res.id}">
                <option value="0" {if $res.birthday_show==0}selected="selected"{/if}>Не показывать пользователям
                </option>
                <option value="1" {if $res.birthday_show==1}selected="selected"{/if}>Показывать пользователям</option>
            </select>
            <h4>Фото *</h4>
            {if $smarty_params.foto_exist == true}
                <img class="logo" src="/images/u/{$res.id}.jpg" width="240">
            {/if}
            <form class="upload" data-type="user_foto" method="post"
                  action="/account/users/?lk_users_edit_profile={$res.id}&upload" enctype="multipart/form-data">
                <div class="drop">
                    <input type="hidden" name="user" value="{$res.id}">
                    <input type="file" name="upl" id="file" multiple="">
                    <label for="file">Прикрепить файл</label>
                    <p>Или перетащите файл в эту область</p>
                </div>
                <ul></ul>
            </form>
            <br>
            <br>
            <hr>
            <h4 class="lk_user_subtitle">Контакты</h4>
            <h4>Телефон * <span style="color:red">(пока здесь в режиме теста, без права смены)</span></h4>
            <input type="tel" class="js_chg slyle_input" data-field="f_tel" value="{$res.tel}" data-id="{$res.id}"/>
            <select class="js_chg lk_select" data-field="f_tel_show" data-id="{$res.id}">
                <option value="0" {if $res.tel_show==0}selected="selected"{/if}>Не показывать пользователям</option>
                <option value="1" {if $res.tel_show==1}selected="selected"{/if}>Показывать пользователям</option>
            </select>
            <h4>E-mail * <span style="color:red">(пока здесь в режиме теста, без права смены)</span></h4>
            <input type="email" class="js_chg slyle_input" data-field="f_login" value="{$res.login}"
                   data-id="{$res.id}"/>
            <select class="js_chg lk_select" data-field="f_login_show" data-id="{$res.id}">
                <option value="0" {if $res.login_show==0}selected="selected"{/if}>Не показывать пользователям</option>
                <option value="1" {if $res.login_show==1}selected="selected"{/if}>Показывать пользователям</option>
            </select>
            <br>
            <br>
            <hr>
            <h4 class="lk_user_subtitle">Карьера</h4>
            <h4>Основное место работы *</h4>
            <input type="text" class="js_chg slyle_input" data-field="f_job_place" value="{$res.job_place}"
                   data-id="{$res.id}"/>
            <h4>Должность *</h4>
            <input type="text" class="js_chg slyle_input" data-field="f_job_title" value="{$res.job_title}"
                   data-id="{$res.id}"/>
            <select class="js_chg lk_select" data-field="f_job_title_show" data-id="{$res.id}">
                <option value="0" {if $res.job_title_show==0}selected="selected"{/if}>Не показывать пользователям
                </option>
                <option value="1" {if $res.job_title_show==1}selected="selected"{/if}>Показывать пользователям</option>
            </select>
            <h4>Уровень должности (не отражается на личной странице) *</h4>
            <select class="js_chg lk_select" data-field="f_job_level" data-id="{$res.id}">
                <option value="0" {if $res.job_level==0}selected="selected"{/if}> Не выбрано</option>
                <option value="1" {if $res.job_level==1}selected="selected"{/if}> Собственник/директор компании</option>
                <option value="2" {if $res.job_level==2}selected="selected"{/if}>Руководитель</option>
                <option value="3" {if $res.job_level==3}selected="selected"{/if}>Специалист</option>
            </select>
            <h4><label for="field_education">Образование</label></h4>
            <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_education" data-field="f_education"
                      data-id="{$res.id}" rows="4">{$res.education}
</textarea>
            <a class="account__button js_chg_field" data-id="field_education">Сохранить описание</a>
            <h4><label for="field_experience">Опыт в автобизнесе</label></h4>
            <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_experience"
                      data-field="f_experience" data-id="{$res.id}" rows="4">{$res.experience}
</textarea>
            <a class="account__button js_chg_field" data-id="field_experience">Сохранить описание</a>
            <h4><label for="field_success">Достижения в автобизнесе</label></h4>
            <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_success" data-field="f_success"
                      data-id="{$res.id}" rows="4">{$res.success}
</textarea>
            <a class="account__button js_chg_field" data-id="field_success">Сохранить описание</a>
            <h4><label for="field_about">Несколько слов о себе</label></h4>
            <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_about" data-field="f_about"
                      data-id="{$res.id}" rows="4">{$res.about}
</textarea>
            <a class="account__button js_chg_field" data-id="field_about">Сохранить описание</a>
            <br>
            <br>
            <hr>
            {* Тег "страна" ($data.id == 1) хардкодим на два уровня *}
            <h4 class="lk_user_subtitle">Страна и регион</h4>
            <div class="lk_tag_box">
                {foreach from=$smarty_params.tags item=data}
                    {if $data.id ==1}
                        <div class="lk_tag_box_two_colons"> {* Div для вывода страна-регион в две колонки*}
                            <div class="js_chg_element">
                                <h4>{$data.title}</h4>
                                <div class="filter_js_anchor">
                                    <input type="text" placeholder="Найти"
                                           class="js_fast_filter_mark filter_checkbox_search_lk" value="">

                                    <div {if count($data.inner) > 5}class="filter_content_lk"{/if}> {*div для локализации прокрутки контента*}
                                        {foreach from=$data.inner key=key item=data1}
                                            {if $data.is_multi==0 && $key == 0}
                                                <div>
                                                    <label>
                                                        <input type="radio" name="radio{$data.id}" class="js_check_tags"
                                                               data-id="{$res.id}"
                                                               data-tag="0" data-root="{$data.id}"
                                                               data-is_multi="{$data.is_multi}">
                                                        <span class="filter-form__label-title">Ничего не выбрано</span>
                                                    </label>
                                                </div>
                                            {/if}
                                            <div>
                                                <label>
                                                    <input {if $data.is_multi==1}type="checkbox" {else}type="radio"
                                                           name="radio{$data.id}"{/if} {if $obj->check_tag_select($data1.id, $data.id)}checked="checked"{/if}
                                                           class="js_check_tags js_check_tags_second_level"
                                                           data-id="{$res.id}" data-tag="{$data1.id}"
                                                           data-root="{$data.id}" data-is_multi="{$data.is_multi}">
                                                    <span class="filter-form__label-title">{$data1.title}</span>
                                                </label>
                                            </div>
                                        {/foreach}
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="js_chg_element js_second_level">


                        </div>
                    {/if}
                {/foreach}
            </div>
            <br>
            <br>
            <hr>
            {* Теги кроме  "страна" ($data.id == 1) *}
            <h4 class="lk_user_subtitle">Теги<br> (страны в качестве тегов можно выбирать любыею, независимо от страны из раздела "Страна и регион")</h4>
            <div class="lk_tag_box">
                {foreach from=$smarty_params.tags item=data}
                    {*{if $data.id !=1}*}
                        <div class="lk_tag_box_two_colons"> {* Div для вывода страна-город в две колонки*}
                            <div class="js_chg_element">
                                <h4>{$data.title}</h4>
                                <div class="filter_js_anchor">
                                    <input type="text" placeholder="Найти"
                                           class="js_fast_filter_mark filter_checkbox_search_lk" value="">

                                    <div {if count($data.inner) > 5}class="filter_content_lk"{/if}> {*div для локализации прокрутки контента*}
                                        {foreach from=$data.inner key=key item=data1}
                                            {if $data.is_multi==0 && $key == 0}
                                                <div>
                                                    <label>
                                                        <input type="radio" name="radio{$data.id}" class="js_check_tags"
                                                               data-id="{$res.id}"
                                                               data-tag="0" data-root="{$data.id}"
                                                               data-is_multi="{$data.is_multi}">
                                                        <span class="filter-form__label-title">Ничего не выбрано</span>
                                                    </label>
                                                </div>
                                            {/if}
                                            <div>
                                                <label>
                                                    <input {if $data.is_multi==1}type="checkbox" {else}type="radio"
                                                           name="radio{$data.id}"{/if} {if $obj->check_tag_select($data1.id, $data.id)}checked="checked"{/if}
                                                           class="js_check_tags" data-id="{$res.id}"
                                                           data-tag="{$data1.id}"
                                                           data-root="{$data.id}" data-is_multi="{$data.is_multi}">
                                                    <span class="filter-form__label-title">{$data1.title}</span>
                                                </label>
                                            </div>
                                        {/foreach}

                                    </div>
                                </div>
                            </div>
                        </div>
                        {if $data.id == 1}
                            <div class="js_chg_element js_second_level"></div>
                        {/if}
                   {* {/if}*}
                {/foreach}
            </div>
            {if $smarty_params.role_GAK >= 4 || $res.status == 0}
                <br>
                <br>
                <hr>
                <h4 class="lk_user_subtitle">Дополнительная информация для администраторов<br>
                    (заполняется один раз при регистрации, не отражается на сайте)</h4>
                <h4><label for="field_is_course_autoboss">Обучались ли Вы на курсах Автобосса? Если да, то когда и на
                        каких
                        курсах?</label></h4>
                <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_is_course_autoboss"
                          data-field="f_is_course_autoboss" data-id="{$res.id}" rows="4">{$res.is_course_autoboss}
</textarea>
                <a class="account__button js_chg_field" data-id="field_is_course_autoboss">Сохранить описание</a>
                <h4><label for="field_is_course_other">Обучались ли Вы на курсах дистрибьютора, в специализированных
                        учебных
                        организациях и пр.?</label></h4>
                <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_is_course_other"
                          data-field="f_is_course_other" data-id="{$res.id}" rows="4">{$res.is_course_other}
</textarea>
                <a class="account__button js_chg_field" data-id="field_is_course_other">Сохранить описание</a>
                <h4><label for="field_is_speaker">Были ли Вы спикером на профессиональных мероприятиях (конференциях,
                        вебинарах и пр.)?</label></h4>
                <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_is_speaker"
                          data-field="f_is_speaker" data-id="{$res.id}" rows="4">{$res.is_speaker}
</textarea>
                <a class="account__button js_chg_field" data-id="field_is_speaker">Сохранить описание</a>
                <h4><label for="field_is_author">Являетесь ли Вы автором книг, профессиональных статей, учебных курсов и
                        пр.?</label></h4>
                <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_is_author"
                          data-field="f_is_author"
                          data-id="{$res.id}" rows="4">{$res.is_author}
</textarea>
                <a class="account__button js_chg_field" data-id="field_is_author">Сохранить описание</a>
            {/if}


            {if $smarty_params.role_GAK >= 4}
                <br>
                <br>
                <hr>
                <h4 class="lk_user_subtitle">Технические параметры</h4>
                <h4>Статус</h4>
                <select class="js_chg lk_select" data-field="f_status" data-id="{$res.id}">
                    <option value="-2" {if $res.status==-2}selected="selected"{/if}>Заблокирован</option>
                    <option value="-1" {if $res.status==-1}selected="selected"{/if}>Регистрация без подтверждения
                        телефона
                    </option>
                    <option value="0" {if $res.status==0}selected="selected"{/if}>Регистрация с подтверждением
                        телефона
                    </option>
                    <option value="2" {if $res.status==2}selected="selected"{/if}>Отправлен запрос на активацию</option>
                    <option value="1" {if $res.status==1}selected="selected"{/if}>Активен</option>
                </select>
                {if $smarty_params.role_GAK >= 10}
                    <h4>Роль (видно только разработчикам)</h4>
                    <select class="js_chg lk_select" data-field="f_role_GAK" data-id="{$res.id}">
                        {foreach from=$smarty_params.GAK item=data}
                            <option value="{$data.id}"
                                    {if $data.id>=$role_GAK}selected="selected"{/if}>{$data.title}</option>
                        {/foreach}
                    </select>
                {/if}
                <h4>Баллы</h4>
                <input type="number" class="js_chg slyle_input" data-field="f_score" value="{$res.score}"
                       data-id="{$res.id}"/>
                <h4>Экспертный статус: </h4>
                <select class="js_chg lk_select" data-field="f_autoboss_status" data-id="{$res.id}">
                    <option value="0" {if $data.id==0}selected="selected"{/if}>Не выбрано</option>
                    {foreach from=$smarty_params.autoboss_status item=data}
                        <option value="{$data.id}"
                                {if $data.id==$res.autoboss_status}selected="selected"{/if}>{$data.title}</option>
                    {/foreach}
                </select>
                <h4></h4>
                <a class=account__button href=/account/users/>Назад к пользователям</a>
                <h4></h4>
            {/if}
            <br>
            <br>
            <div class="moderation_block">
                {if $res.status == 0}
                    <a class="js_moderation_user account__button button button--orange" data-id="{$res.id}">Отправить на модерацию</a>
                {elseif $res.status == 2}
                    Запрос на модерацию отправлен
                {/if}
            </div>
            <div class="alerts"></div>
        {else}
            <h3>Доступ запрещен</h3>
        {/if}
    </div>
</div>
