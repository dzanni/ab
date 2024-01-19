<div class="container-fluid">
    <div class="lk_menu">
        <h3>{$smarty_params.h1}</h3>
        {$msg_load_price}

        {assign var="res" value=$result.0}
        {$res.tovarURL}

        <h4>ID: {$res.id}</h4>

        <h4>Производитель </h4>
        <select class="js_lk_brand_select lk_select" data-id="{$res.id}">
            {foreach from=$smarty_params.all_brands item=data}
                <option value="{$data.id}" {if $data.title == $smarty_params.brand_title}selected="selected"{/if}>{$data.title}</option>
            {/foreach}
        </select>

        <h4>Наименование</h4>
        <input type="text" class="js_chg slyle_input" data-field="f_title" value="{$res.title}" data-id="{$res.id}" />

        <h4>Цена</h4>
        <input type="number" class="js_chg slyle_input" data-field="f_price" value="{$res.price}" data-id="{$res.id}" />

        <h4><label for="field_about">Описание</label></h4>
        <textarea class="js_chg slyle_input_textarea ckeditor_txt" id="field_about" data-field="f_about" data-id="{$res.id}" rows="4">{$res.about}
</textarea>
        <a class="account__button js_chg_field" data-id="field_about">Сохранить описание</a>

        <h4>Статус</h4>
        <select class="js_chg lk_select" data-field="f_active" data-id="{$res.id}">
            <option value="1" {if $res.active==1}selected="selected"{/if}>Активен</option>
            <option value="0" {if $res.active==0}selected="selected"{/if}>Не активен</option>
        </select>

        <h4>Изображения</h4>

        <div class="sort_img">
            {foreach from=$smarty_params.images item=img}
                <div class="img_block">
                    <img class="logo_img sort_img_item" src="/images/photo/{$img.filename}" width="240" data-id="{$img.filename}">
                    <span class="js_delete_img cross" data-filename="{$img.filename}"></span>
                </div>
                {assign var="max_position" value=$img.position+1 }
            {/foreach}
        </div>

        Загрузить изображения:
        <form class="upload" data-type="tovar_img" method="post" action="/account/tovar/?brand={$res.firm}&lk_tovar_edit_profile={$res.id}&upload" enctype="multipart/form-data">
            <div class="drop">
                <input type="hidden" name="load_img" value="true">
                <input type="hidden" class="js_max-position" name="max-position" value="{$max_position}">
                <input type="hidden" name="tovar" value="{$res.id}">
                <input type="file" name="upl" id="file" multiple="">
                <label for="file">Прикрепить изображения</label>
                <p>Или перетащите изображения в эту область</p>
            </div>
            <ul></ul>
        </form>

        {*
    <h4>Файлы</h4>
    <div class="sort_files">
    {foreach from=$smarty_params.files item=f}
        <div class="files_block">
        <input type="text" class="js_chg_filename slyle_input" value="{$f.user_filename}" data-id="{$f.id}"/>
            {$f.ext} <span class="js_delete_files cross" data-filename="{$f.filename}"></span>
         </div>
    {/foreach}
    </div>


    Загрузить файлы:
    <form class="upload" data-type="tovar_files" method="post" action="/account/tovar/?brand={$res.firm}&lk_tovar_edit_profile={$res.id}&uploadFiles" enctype="multipart/form-data">
        <div class="drop">
            <input type="hidden" name="load_files" value="true">
            <input type="hidden" name="tovar" value="{$res.id}">
            <input type="file" name="upl" id="file_files" multiple="">
            <label for="file_files">Прикрепить файлы</label>
            <p>Или перетащите файлы в эту область</p>
        </div>
        <ul></ul>
    </form>
*}

        <div>
            {assign var='options' value=$smarty_params.options}
            {foreach from=$options item=data key=key}

                    <div class="js_chg_element">
                        <h4>{$data.title}</h4>
                        {if $data.output==1}  {* Селектор *}
                            <div class="js_selectors lk_checkbox_group">

                                <div class="lk_checkbox_anchor">
                                    <select class="js_select_options lk_select" data-options="{$data.id}">
                                        <option value="-1">НЕ ВЫБРАНО</option>
                                        {foreach from=$data.values item=data1 key=key1}
                                            {if $data1.parent == 0}
                                                <option value="{$data1.id}" {if $data1.flag == 1}selected="selected" class="js_options_anchor"{/if}>{$data1.title}</option>
                                            {/if}
                                        {/foreach}
                                    </select>
                                </div>

                                {* Логика для многоуровнего селектора, скрываем
                                <a class="js_save_option_line" data-id="{$res.id}" data-key="{$key}">Сохранить цепочку «{$data.title}»</a><br><br>
                                <select class="js_edit_options" data-id="{$res.id}">
                                     <option value="-1">НЕ ВЫБРАНО</option>
                                     {foreach from=$data.values item=data1 key=key1}
                                         {if $data1.parent == 0}
                                             <option value="{$key1}" {if $data1.flag == 1}selected="selected" class="js_options_anchor"{/if}>{$data1.title}</option>
                                         {/if}
                                     {/foreach}
                                 </select>*}

                                <div class="lk_checkbox_after">
                                    <a class="js_add_option_open account__button-min">Добавить {$data.title}</a>
                                    <input type="text" class="js_add_option slyle_input hidden" data-option="{$data.id}"  data-output="select" placeholder="Введите значение">
                                </div>

                            </div>

                        {elseif $data.output==2} {* Текст *}
                            <input type="text" class="js_input_option slyle_input" data-option="{$data.id}" data-id="{$res.id}" placeholder="{$data.values}">

                        {elseif $data.output==3} {* Текстареа *}

                            <textarea class="js_input_option slyle_input_textarea" data-option="{$data.id}" data-id="{$res.id}" rows="4">{$data.values}</textarea>

                        {else} {* Чекбокс по дефолту *}
                            <div class="lk_checkbox_group">

                                {if count($data.values)>4}
                                    <input type="text" placeholder="Найти" class="js_fast_filter_mark filter_checkbox_search" value="">
                                {/if}

                                <div class="{if count($data.values)>4}lk_checkbox{/if} lk_checkbox_anchor">
                                    {foreach from=$data.values item=data1 key=key1}
                                        <div class="lk_checkbox-item">
                                            {if $data1.parent == 0}
                                                <input type="checkbox" {if $data1.flag == 1}checked{/if} class="js_check_options" data-options="{$data.id}" data-value="{$data1.id}">
                                                <label class="checkbox_js_label" {if $data1.flag == 1}checked{/if}>{$data1.title}</label>
                                            {/if}
                                        </div>
                                    {/foreach}

                                </div>
                                <div class="lk_checkbox_after">

                                    <input type="text" class="js_add_option slyle_input" data-option="{$data.id}" data-output="checkbox" placeholder="Введите значение">
                                    <a class="js_add_option_open account__button">Добавить {$data.title}</a>
                                </div>

                            </div>

                        {/if}
                    </div>
            {/foreach}
        </div>


        {*    <h4>Категории</h4>
            <div class="options-selector">
            <select class="js_edit_options" data-id="{$res.id}">
                <option value="">КАТЕГОРИЯ</option>
                {foreach from=$smarty_params.options item=data key=key}
                <option value="{$key}">{$data.title}</option>
                {/foreach}
            </select>

            </div>*}


        <h4></h4>
        <a class=account__button href=/account/tovar/?brand={$res.firm}>Назад к товарам производителя</a>
        <h4></h4>


        <div class="alerts"></div>
    </div>
</div>