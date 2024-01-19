<main>
    <div class="lk_menu lk_user">
        <h3>Написать отзыв о компании</h3>

        <div class="content__block remarks_add">
            <h4 class="block__title" id="verificate">Укажите данные компании</h4>

            <div class="row__input">
                <div class="input__item js_toggle_remarks_btns">
                    <a class="account__button button button--orange active" data-name="js_company_add">Нужной компании нет в списке</a>
                    <a class="account__button button button--orange hidden" data-name="js_company_select">Выбрать компанию из списка (рекомендуется)</a>
                </div>
            </div>
            <div class="row__input js_company_select js_toggle_remarks">
                <div class="input__item">
                    <h4>Выберите компанию из списка:</h4>

                    <div class="filter_js_anchor tag_title_anchor on js_lk_search_remark_firm">
                        <input type="text" placeholder="Найти"
                               class="js_fast_filter_mark filter_checkbox_search_lk" value="">
                        <div class="tag_cloud">
                            {foreach from=$smarty_params.firm key=key item=data1}
                                <div class="tag_cloud_item label js_lk_search_remark_firm_label" data-id="{$data1.id}">
                                    <span class="filter-form__label-title">{$data1.title}</span>
                                </div>
                            {/foreach}
                        </div>

                    </div>

                </div>
            </div>

            <div class="row__input hidden js_company_add js_toggle_remarks">
                <div class="input__item w2">
                    <h4>Укажите наименование компании *</h4>
                    <input type="text" class="slyle_input js_remark_title" value="">
                </div>
                <div class="input__item w2">
                    <h4>Адрес сайта компании *</h4>
                    <input type="text" class="slyle_input js_remark_url" value="">
                </div>
            </div>

        </div>
        <div class="content__block remarks_add">
            <h4 class="block__title" id="verificate">Ваш отзыв:</h4>
            <div class="row__input">
                <div class="input__item">

                    <div class="rating-area-wrap">
                        <div class="rating-area" data-client="0">
                            <input class="js_change_rating_lk_firm" type="radio" id="star-5" name="rating" value="5">
                            <label for="star-5" title="Оценка «5»"></label>
                            <input class="js_change_rating_lk_firm" type="radio" id="star-4" name="rating" value="4">
                            <label for="star-4" title="Оценка «4»"></label>
                            <input class="js_change_rating_lk_firm" type="radio" id="star-3" name="rating" value="3">
                            <label for="star-3" title="Оценка «3»"></label>
                            <input class="js_change_rating_lk_firm" type="radio" id="star-2" name="rating" value="2">
                            <label for="star-2" title="Оценка «2»"></label>
                            <input class="js_change_rating_lk_firm" type="radio" id="star-1" name="rating" value="1">
                            <label for="star-1" title="Оценка «1»"></label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row__input">
                <div class="input__item">
                    <textarea class="js_txt_ramark"></textarea>
                </div>
            </div>

            <div class="row__input">
                <div class="input__item">
                    <p class="js_result"></p>
                    <a class="account__button button button--orange js_company_send_remark">Оставить отзыв</a>
                </div>
            </div>
        </div>
    </div>
</main>
