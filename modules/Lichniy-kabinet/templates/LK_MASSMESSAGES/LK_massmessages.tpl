<main>
    <form class="lk_menu lk_user massmessages_add">
        <h3>Отправить массовое сообщение</h3>

        <div class="content__block ">
            <h4 class="block__title">Фильтры</h4>

            <div class="row__input">

                <div class="input__item main_checkbox">
                    <label>
                        <input type="checkbox" name="to_all" class="js_filter_massmessage"><span>Отправить всем, игнорируя фильтры</span>
                    </label>
                </div>

                <div class="input__item">
                    <h4>ID тега или несколько ID через запятую. Например: 157,337 (произойдет отбор по тегам "Легковые
                        автомобили" и "Стерлитамак")</h4>

                    <input type="text" name="tags" class="js_filter_massmessage" placeholder="Введите теги">
<br><br>
                    <a class="js_open_tag_list tag_list_button">Список всех тегов</a>
                    <div class="tag_list hidden">

                        <div class="tag_list_subtitle">СТРАНЫ</div>
                        {foreach from=$smarty_params.tags.0.inner item=data}
                            <div class="tag_list_subtitle">{$data.title} ({$data.id})</div>
                            <div class="tag_list_text">
                                {foreach from=$data.inner key=key item=data1}
                                    {$data1.title} ({$data1.id}) {if $key+1 != count($data.inner)} - {/if}
                                {/foreach}
                            </div>
                        {/foreach}
                        <br>
                        <div class="tag_list_subtitle">ПРОЧИЕ ТЕГИ</div>
                        {foreach from=$smarty_params.tags key=key item=data}
                            {if $key > 0}
                                <div class="tag_list_subtitle">{$data.title}</div>
                                <div class="tag_list_text">
                                    {foreach from=$data.inner key=k item=data1}
                                        {$data1.title} ({$data1.id}) {if $k+1 != count($data.inner)} - {/if}
                                    {/foreach}
                                </div>
                            {/if}
                        {/foreach}
                    </div>
                </div>

                <div class="input__item checkbox">
                    <h4>Заполненность личной карточки</h4>
                    <label>
                    <input type="checkbox" name="no_foto" class="js_filter_massmessage"><span>Нет фото</span>
                    </label>
                    <label>
                        <input type="checkbox" name="no_tags" class="js_filter_massmessage"><span>Нет тегов</span>
                    </label>
                    <label>
                        <input type="checkbox" name="family_name" class="js_filter_massmessage"><span>Нет фамилии</span>
                    </label>
                    <label>
                        <input type="checkbox" name="name" class="js_filter_massmessage"><span>Нет имени</span>
                    </label>
                    <label>
                        <input type="checkbox" name="state" class="js_filter_massmessage"><span>Нет страны</span>
                    </label>
                    <label>
                        <input type="checkbox" name="city" class="js_filter_massmessage"><span>Нет города</span>
                    </label>
                    <label>
                        <input type="checkbox" name="expert_tag" class="js_filter_massmessage"><span>Нет тега в категории "Сфера деятельности эксперта"</span>
                    </label>
                    <label>
                        <input type="checkbox" name="job_place" class="js_filter_massmessage"><span>Нет места работы</span>
                    </label>
                    <label>
                        <input type="checkbox" name="job_level" class="js_filter_massmessage"><span>Нет уровня должности</span>
                    </label>
                    {*<label>
                        <input type="checkbox" name="no_profile" class="js_filter_massmessage"><span>Не заполнен профиль (Фамилия, Имя,
Страна, Город, Хотя бы 1 тег в категории "Сфера деятельности эксперта", Место работы (текущее или последнее),
Уровень должности)</span>
                    </label>*}
                </div>

                <div class="input__item">
                    <h4>Число дней с последней активности</h4>
                    <input type="number" name="days" class="js_filter_massmessage" placeholder="Введите число дней">
                </div>

                <input type="hidden" name="useFilter"">

                <div class="input__item">
               {* <a class="account__button button button--orange js_filter_massmessage">Применить фильтр</a>*}
                    <p class="js_result_tmp"></p>
                </div>
            </div>
        </div>

        <div class="content__block massmessages_send">
            <h4 class="block__title" id="verificate">Ваше сообщение:</h4>
            <div class="row__input">
                <div class="input__item">
                    <textarea class="js_txt_mail_anchor" name="msg"></textarea>
                </div>
            </div>

            <div class="row__input">
                <div class="input__item">
                    <p class="js_result"></p>
                    {*<a class="account__button button button--orange js_send_massmessage">Отправить сообщение</a>*}
                    <input type="button" class="account__button button button--orange js_filter_send_msg" name="send" value="Отправить сообщение">
                </div>
            </div>
        </div>
    </form>
</main>

{*
1. Фильтр по тегам (список ИД).
2. Без фото
3. Нет тегов
4. Не заходил более Х дней
5. Не заполнен профиль:
"Фамилия Имя
Страна
Город
Хотя бы 1 тег в категориях: регион, сфера деятельности эксперта
Место работы (текущее или последнее)
Уровень должности"*}