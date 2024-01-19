<div class="LB_edit" data-category="{$category}" data-firm="{$firm}" data-firmpage="{$firmpage}" {if $LB_edit}data-edit="true"{/if}>
    {if $tovarId}
        <a href="/account/tovar/?brand=get&lk_tovar_edit_profile={$tovarId}">Редактировать товар</a>
    {else}
        {if $LB_edit}
            <a href="{$link_close}">Выключить режим редактирования</a>
        {else}
            <a href="{$link_show}">Включить режим редактирования</a>
        {/if}
    {/if}
    <a href="/account/?exit_from_lk">Выход</a>
</div>

<div class="LB_edit_DEFAULT_ELEMENT">
<div class="LB_edit_element">
    <a class="LB_edit_icon LB_edit__del"></a>
    <a class="LB_edit_icon LB_edit__copy">
    <a class="LB_edit_icon LB_edit__down"></a>
    <a class="LB_edit_icon LB_edit__up"></a>
    <a class="LB_edit_icon LB_edit__edit"></a>
    <a class="LB_edit_icon LB_edit__add"></a>
</div>
</div>

<div style="display: none;">
    <div class="LB_edit_element_modal LB_edit_small LB_edit__del_modal">
        <a href="#" class="LB_edit_element_modal__close arcticmodal-close">
            <img src="/modules/LB_edit_on_page/i/no-checked.png" alt="close">
        </a>
        <div class="LB_modal_block">
            <div class="LB_modal_block_form">
                <div class="LB_modal_block_form__title">Вы уверены, что хотите удалить блок?</div>

                <div class="LB_form_row">
                    <a class="LB_confirm_remove LB_btn LB_btn_red">Да, удалить блок</a>
                    <a class="arcticmodal-close LB_btn">Нет, закрыть окно</a>
                </div>
                <div class="LB_form_row">При удалении восстановление невозможно</div>
            </div>
        </div>
    </div>

    <div class="LB_edit_element_modal LB_edit__add_modal">
        <a href="#" class="LB_edit_element_modal__close arcticmodal-close">
            <img src="/modules/LB_edit_on_page/i/no-checked.png" alt="close">
        </a>
        <div class="LB_modal_block">
            <div class="LB_modal_block_form">
            </div>
        </div>
    </div>

    <div class="LB_edit_element_modal LB_edit__edit_modal">
        <a href="#" class="LB_edit_element_modal__close arcticmodal-close">
            <img src="/modules/LB_edit_on_page/i/no-checked.png" alt="close">
        </a>
        <div class="LB_modal_block">
            <div class="LB_modal_block_form">
            </div>
        </div>
    </div>

    <div class="LB_edit_element_modal LB_edit_small LB_edit__copy_modal">
        <a href="#" class="LB_edit_element_modal__close arcticmodal-close">
            <img src="/modules/LB_edit_on_page/i/no-checked.png" alt="close">
        </a>
        <div class="LB_modal_block">
            <div class="LB_modal_block_form">
            </div>
        </div>
    </div>
</div>