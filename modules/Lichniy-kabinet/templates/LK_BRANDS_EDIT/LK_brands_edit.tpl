<main>

    <div class="lk_menu lk_user">
        <h3>{$smarty_params.h1}</h3>
        {$msg_load_price}
        <a class="account__button button button--orange">Сохранить</a><br>
        {assign var="res" value=$result.0}
        {if $res.id}
        <!--<h4>ID: {$res.id}</h4>-->

        <input type="hidden" value="{$res.id}" class="js_brand_id">

        {if $smarty_params.new_page_option}
        <div class="content__block">
            <a href="/account/page/">Создать внутреннюю страницу</a>
        </div>
        {/if}

        <div class="content__block">

            <h4 class="block__title">Приглашайте Ваших клиентов в систему:</h4>

            Попросите своих клиентов оставить отзыв о вашей компании, отправив эту ссылку: https://expert.a-boss.ru/account/?lk_reg&u_from={$user->id}  <br><br>

            {$viewer->gen_share("https://expert.a-boss.ru/account/?lk_reg&u_from={$user->id}", true, "Добрый день, {$res.title} просит Вас, как клиента компании, оценить ее и сделать небольшой отзыв в профессиональной сети экспертов автобизнеса АвтоБосс.Эксперт. Большое спасибо!")}

            <h4 class="block__title">Базовые данные</h4>
            <div class="row__input">
                <div class="input__item"><h4>Наименование</h4>

                    <input type="text" class="js_chg slyle_input" data-field="f_title" value="{$res.title}"
                           data-id="{$res.id}"/>
                </div></div>
            <div class="row__input">
                <div class="input__item">
                    <h4><label for="field_description">Описание</label></h4>
                    <textarea class="js_chg slyle_input_textarea {*ckeditor_txt*}" id="field_description"
                              data-field="f_description" data-id="{$res.id}" rows="4">{$res.description}</textarea>
                    {* <a class="account__button js_chg_field" data-id="field_description">Сохранить описание</a>*}
                </div></div>
            <div class="row__input">
                <div class="input__item"><h4>Логотип</h4>
                    <img class="logo js_img_logo_brand" src="{$viewer->get_icon_by_firm($res.id)}" width="240">
                </div>
            </div>
            <div class="row__input">
                <div class="input__item"><h4>Загрузить логотип:</h4>
                    <form class="upload" data-type="brand_logo" method="post"
                          action="/account/brands/?lk_brands_edit_profile={$res.id}&upload" enctype="multipart/form-data">
                        <div class="drop">
                            <input type="hidden" name="brand" value="{$res.id}">
                            <input type="file" name="upl" id="file" multiple="">
                            <label for="file">Прикрепить файл</label>
                            <p>Или перетащите файл в эту область</p>
                        </div>
                        <ul></ul>
                    </form>
                </div></div>
            <div class="row__input">


                <div class="input__item w2">
                    <h4>Страна</h4>
                    <select class="select js_choose_state_brand" data-id="{$res.id}">
                        <option value="0">Ничего не выбрано</option>
                        {foreach from=$smarty_params.states item=data}
                            <option value="{$data.id}"
                                    {if $obj->check_tag_select($data.id,1)}selected{/if}>{$data.title}</option>
                        {/foreach}

                    </select>
                </div>
                <div class="input__item w2">
                    <h4>Город</h4>
                    <select class="select js_choose_city_brand" data-id="{$res.id}">
                        <option value="0">Ничего не выбрано</option>
                        {foreach from=$smarty_params.cities item=data}
                            <option value="{$data.id}"
                                    {if $obj->check_tag_select($data.id,-1)}selected{/if}>{$data.title}</option>
                        {/foreach}
                    </select>
                </div>
            </div>

            {* Тег "страна" ($data.id == 1) хардкодим на два уровня *}
            <!--<h4 class="lk_user_subtitle">Страна и регион</h4>
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
                                                               data-subj_type="firm"
                                                               data-id="{$res.id}"
                                                               data-tag="0"
                                                               data-root="{$data.id}"
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
                                                           data-subj_type="firm"
                                                           data-id="{$res.id}"
                                                           data-tag="{$data1.id}"
                                                           data-root="{$data.id}"
                                                           data-is_multi="{$data.is_multi}">
                                                    <span class="filter-form__label-title">{$data1.title}</span>
                                                </label>
                                            </div>
                                        {/foreach}
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="js_chg_element js_second_level"></div>
                    {/if}
                {/foreach}
            </div>-->
            <h4 class="block__title">Контакты</h4>
            <div class="row__input">
                <div class="input__item w2">
                    <h4>Телефон</h4>
                    <div class="input__item_inner_block">
                        {if !count($res.phone)}
                        <div class="input__item_inner">
                            <input type="text" class="js_chg slyle_input tel" data-field="f_phone" value="{$res.phone}" data-id="{$res.id}" data-multikey="0"/>
                        </div>
                         {else}
                            {foreach from=$res.phone key=key item=data}
                                <div class="input__item_inner">
                                    <input type="text" class="js_chg slyle_input tel" data-field="f_phone" value="{$data}" data-id="{$res.id}" data-multikey="{$key}"/>
                                </div>
                            {/foreach}
                        {/if}
                    </div>
                    <br>
                    <a class="js_add_firm_multifield button button__add-work">Добавить телефон</a>
                </div>
                <div class="input__item w2">
                    <h4>Адрес</h4>
                    <div class="input__item_inner_block">
                        {if !count($res.address)}
                            <div class="input__item_inner">
                                <input type="text" class="js_chg slyle_input" data-field="f_address" value="{$res.address}" data-id="{$res.id}" data-multikey="0"/>
                            </div>
                        {else}
                            {foreach from=$res.address key=key item=data}
                                <div class="input__item_inner">
                                    <input type="text" class="js_chg slyle_input" data-field="f_address" value="{$data}" data-id="{$res.id}" data-multikey="{$key}"/>
                                </div>
                            {/foreach}
                        {/if}
                    </div>
                    <br>
                    <a class="js_add_firm_multifield button button__add-work">Добавить адрес</a>
                </div>
            </div>
            <div class="row__input">
                <div class="input__item w2">
                    <h4>E-mail</h4>
                    <div class="input__item_inner_block">
                        {if !count($res.email)}
                            <div class="input__item_inner">
                                <input type="text" class="js_chg slyle_input" data-field="f_email" value="{$res.emalil}" data-id="{$res.id}" data-multikey="0"/>
                            </div>
                        {else}
                            {foreach from=$res.email key=key item=data}
                                <div class="input__item_inner">
                                    <input type="text" class="js_chg slyle_input" data-field="f_email" value="{$data}" data-id="{$res.id}" data-multikey="{$key}"/>
                                </div>
                            {/foreach}
                        {/if}
                    </div>
                    <br>
                    <a class="js_add_firm_multifield button button__add-work">Добавить email</a>
                </div>
                <div class="input__item w2">
                    <h4>Email для форм обратной связи</h4>
                       <input type="text" class="js_chg slyle_input" data-field="f_email_form" value="{$res.email_form}"
                data-id="{$res.id}"/>
                </div>
            </div>

            <h4 class="block__title">Сайты и соцсети</h4>
            <div class="row__input">
                <div class="input__item site_anchor">
                        {foreach from=$smarty_params.sites item=f}
                        <div class="site_block">
                            <div class="input__file">
                                <div class="input__file-label">
                                        <span class="js_delete_site delete_cross cross" data-id="{$f.id}">

										<svg class="svg-sprite-icon icon__delete">
											<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__delete"></use>
										</svg>
										</span>
                                </div>
                                <div class="input__file-label"><input type="text"
                                                                      class="js_chg_site slyle_input"
                                                                      value='{$f.URL}' data-id="{$f.id}"
                                                                      data-field="URL"
                                                                      placeholder="URL"/>
                                </div>
                                <div class="input__file-label"><input type="text"
                                                                      class="js_chg_site slyle_input"
                                                                      value='{$f.title}' data-id="{$f.id}"
                                                                      data-field="title"
                                                                      placeholder="Имя (при желании)"/>
                                </div>
                                <div class="input__file-label">
                                    <select class="js_chg_site lk_select select" data-id="{$f.id}" data-field="type">
                                        <option value="0" {if $f.type==0}selected="selected"{/if}>Сайт</option>
                                        <option value="1" {if $f.type==1}selected="selected"{/if}>Соцсеть</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        {/foreach}
                </div>
                    <a class="js_add_site button button__add-work" data-id="{$res.id}">Добавить сайт</a>
                <br><br><br>
            </div>


            <h4 class="block__title">Документы</h4>
            <div class="row__input">
                <div class="input__item">
                    <div class="sort_files">
                        {foreach from=$smarty_params.documents item=f}
                            <div class="files_block sort_file_item" data-id="{$f.id}">
                                <div class="input__file">
                                    <div class="input__file-label">
                                        {$f.user_filename}
                                        <span class="js_delete_docs_file delete_cross cross" data-id="{$f.id}"
                                              data-filename="{$f.filename}">

										<svg class="svg-sprite-icon icon__delete">
											<use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__delete"></use>
										</svg>
												</span>
                                    </div>
                                    <div class="input__file-label"><input type="text"
                                                                          class="js_chg_document slyle_input"
                                                                          value='{$f.title}' data-id="{$f.id}"
                                                                          data-field="title"
                                                                          placeholder="Наименование"/></div>
                                    <div class="input__file-label"><input type="text"
                                                                          class="js_chg_document slyle_input"
                                                                          value='{$f.description}'
                                                                          data-id="{$f.id}" data-field="description"
                                                                          placeholder="Описание"/></div>
                                    <div class="input__file-label"><input type="date"
                                                                          class="js_chg_document slyle_input"
                                                                          value="{$f.date}" data-id="{$f.id}"
                                                                          data-field="date"
                                                                          placeholder="Дата получения"/></div>


                                </div>
                            </div>
                            {assign var="max_position" value=$f.position+1}
                        {/foreach}
                    </div>
                    <form class="upload" data-type="firm_document" method="post"
                          action="/account/brands/?lk_brands_edit_profile={$res.id}&uploadDocument"
                          enctype="multipart/form-data">
                        <div class="drop">
                            <input type="hidden" name="loadDocument" value="true">
                            <input type="hidden" name="firm" value="{$res.id}">
                            <input type="hidden" class="js_max-position" name="max-position"
                                   value="{$max_position}">
                            <input type="file" name="upl" id="file_document" multiple="">
                            <label for="file_document">
                                <svg class="svg-sprite-icon icon-footer__logo">
                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__upload"></use>
                                </svg>
                                Загрузить файл</label>
                            <p>Или перетащите в эту область</p>
                        </div>
                        <ul></ul>
                    </form>
                </div>
            </div>


            <h4 class="block__title">Теги</h4>

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
                                            <span class="js_delete_tag_firm cross_small" data-id="{$data1.id}" data-firm="{$res.id}"></span>
                                        </div>
                                    {/if}
                                {/foreach}
                            </div>

                            <div class="filter_js_anchor tag_title_anchor">
                                <input type="text" placeholder="Найти"
                                       class="js_fast_filter_mark filter_checkbox_search_lk" value="">
                                <div class="tag_cloud">
                                    {foreach from=$data.inner key=key item=data1}
                                        <div class="tag_cloud_item label {if $obj->check_tag_select($data1.id, 0)}checked{/if} js_add_tag_firm" data-id="{$data1.id}" data-firm="{$res.id}">
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
                    {if $data.id ==1} {* К стране берем регионы*}
                        <div class="lk_tag_box_two_colons">
                            <div class="js_chg_element js_reg_tag_anchor">
                                <h4 class="tag_title_toggle js_tag_title_toggle">Регион</h4>

                                <div class="tag_cloud">
                                    {foreach from=$smarty_params.regions item=reg}
                                        {if $obj->check_tag_select($reg.id, 0)}
                                            <div class="tag_cloud_item checked">
                                                {$reg.title}
                                                <span class="js_delete_tag_firm cross_small" data-id="{$reg.id}" data-firm="{$res.id}"></span>
                                            </div>
                                        {/if}
                                    {/foreach}
                                </div>

                                <div class="filter_js_anchor tag_title_anchor">
                                    <input type="text" placeholder="Найти"
                                           class="js_fast_filter_mark filter_checkbox_search_lk" value="">
                                    <div class="tag_cloud">
                                        {foreach from=$smarty_params.regions item=reg}
                                            <div class="tag_cloud_item label {if $obj->check_tag_select($reg.id, 0)}checked{/if} js_add_tag_firm" data-id="{$reg.id}" data-firm="{$res.id}">
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

            {if $smarty_params.role_GAK >= 4}
            <h4 class="block__title">Технические параметры (видит только администратор)</h4>
            <div class="row__input">
                <div class="input__item">
                    <h4>Статус</h4>
                    <select class="select js_chg lk_select" data-field="f_status" data-id="{$res.id}">
                        <option value="0" {if $res.status==0}selected="selected"{/if}>Не активен</option>
                        <option value="2" {if $res.status==2}selected="selected"{/if}>На модерации</option>
                        <option value="1" {if $res.status==1}selected="selected"{/if}>Активен</option>
                    </select>
                </div>
                <div class="input__item">
                    <h4>Тариф</h4>
                    <select class="select js_chg lk_select" data-field="f_tarif" data-id="{$res.id}">
                        <option value="0" {if $res.tarif==0}selected="selected"{/if}>Базовый</option>
                        <option value="1" {if $res.tarif==1}selected="selected"{/if}>Платный</option>
                    </select>
                </div>
                <div class="input__item">
                    <h4>Игнорировать тариф (отключить все платные опции)</h4>
                    <select class="select js_chg lk_select" data-field="f_tarif" data-id="{$res.id}">
                        <option value="0" {if $res.tarif==0}selected="selected"{/if}>Нет</option>
                        <option value="1" {if $res.tarif==1}selected="selected"{/if}>Да</option>
                    </select>
                </div>


                <div class="input__item">
                    <h4>Доступные лендинг-блоки</h4>

                    {foreach from=$smarty_params.landing item=data}

                    <label class="lk_edit_checkbox">
                        <input type="checkbox" name="firm_landing" {if $obj->check_landing_select($data.id)}checked{/if} class="js_check_firm_landing">
                        <input type="hidden" class="js_firm_landing_id" value="{$data.id}">
                             {$data.title}
                    </label>

                    {/foreach}


                </div>

            </div>
             {/if}

            <br>
            {if $res.status == 0}<div class="moderation_block">

                <a class="js_moderation_firm account__button button button--orange" data-id="{$res.id}">Отправить на модерацию</a> </div>
            {elseif $res.status == 2}
                <div class="moderation_block">Запрос на модерацию отправлен

                </div>{/if}
    <br>
            <a class="account__button  button button--orange" href=/account/brands/>Редактировать все компании</a>



            <div class="alerts"></div>
            {else}
            <h3>Доступ запрещен</h3>
            {/if}
        </div>
    </div>
</main>