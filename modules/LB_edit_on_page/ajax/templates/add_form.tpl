<div class="LB_form">
    <input type="hidden" value="{$category}" class="LB_send_element LB_send_element__category" data-field="category">
    <input type="hidden" value="{$id}" class="LB_send_element LB_send_element__id" data-field="id">
    <input type="hidden" value="{$firm}" class="LB_send_element LB_send_element__firm" data-field="firm">
    <input type="hidden" value="{$firmpage}" class="LB_send_element LB_send_element__firmpage" data-field="firmpage">

    <div class="LB_modal_block_form__title">Добавление нового блока на страницу:</div>

    <div class="LB_form_row">
        <input type="hidden" value="default" class="LB_send_element LB_send_element__LB_type" data-field="LB_type">
        {foreach from=$items key=key item=d}
            <a class="LB_select_add_block_type {if $key==0}LB_selected{/if}" data-id="{$d.id}">
                <span class="LB_img" style="background-image: url('{$d.filename}')"></span>
                <span class="LB_title">{$d.title}</span>
            </a>
        {/foreach}
    </div>
    <div class="LB_form_row">
        <select class="LB_send_element" data-field="add_type">
            <option value="after">После текущего блока</option>
            <option value="before">Перед текущим блоком</option>
        </select>
    </div>
    <div class="LB_form_row">
        <a class="LB_confirm_add_block LB_send_form LB_btn LB_btn_red">Добавить</a>
    </div>
</div>