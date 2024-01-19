<h4>Регион</h4>

<div class="filter_js_anchor">
    <input type="text" placeholder="Найти"
           class="js_fast_filter_mark filter_checkbox_search_lk" value="">

    <div {if count($tags) > 5}class="filter_content_lk"{/if}> {*div для локализации прокрутки контента*}
        {foreach from=$tags key=key item=data1}
            {if $is_multi==0 && $key == 0}
                <div>
                    <label>
                        <input type="radio" name="radio_-1" class="js_check_tags" data-subj_type="{$subj_type}" data-id="{$id}"
                               data-tag="0" data-root="-1" data-is_multi="{$is_multi}">
                        <span class="filter-form__label-title">Ничего не выбрано</span>
                    </label>
                </div>
            {/if}
            <div>
                <label>
                    <input {if $is_multi==1}type="checkbox" {else}type="radio"
                           name="radio_-1"{/if} {if $obj->check_tag_select($data1.id, -1)}checked="checked"{/if}
                           class="js_check_tags" data-subj_type="{$subj_type}" data-id="{$id}" data-tag="{$data1.id}"
                           data-root="-1" data-is_multi="{$is_multi}">
                    <span class="filter-form__label-title">{$data1.title}</span>
                </label>
            </div>
        {/foreach}



    </div>
</div>


