<div class="job_item">
    <div class="row__input">
        <div class="input__item w3">
            <h4>Начало работы</h4>
            <div class="input__ym" data-field="date_start" data-id="{$id}">
                <select class="lk_select select input__ym-m">
                    <option value="">Месяц</option>
                    <option value="01">январь</option>
                    <option value="02">февраль</option>
                    <option value="03">март</option>
                    <option value="04">апрель</option>
                    <option value="05">май</option>
                    <option value="06">июнь</option>
                    <option value="07">июль</option>
                    <option value="08">август</option>
                    <option value="09">сентябрь</option>
                    <option value="10">октябрь</option>
                    <option value="11">ноябрь</option>
                    <option value="12">декабрь</option>
                </select>
                <select class="lk_select select input__ym-y">
                    <option value="">Год</option>
                    {foreach from=$all_years item=year}
                        <option value="{$year}">{$year}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="input__item w3">
            <h4>Окончание</h4>

            <div class="input__checkbox">
                <input class="js_job_date_till" name="till_{$id}" type="checkbox"
                       id="check_{$id}" data-id="{$id}">
                <label class="input__checkbox-label" for="check_{$id}">
                    По настоящее время
                </label>
            </div>
        </div>
        <div class="input__item w3">
            <h4>&nbsp;</h4>
            <div class="input__ym" data-field="date_end" data-id="{$id}">
                <select class="lk_select select input__ym-m">
                    <option value="">Месяц</option>
                    <option value="01">январь</option>
                    <option value="02">февраль</option>
                    <option value="03">март</option>
                    <option value="04">апрель</option>
                    <option value="05">май</option>
                    <option value="06">июнь</option>
                    <option value="07">июль</option>
                    <option value="08">август</option>
                    <option value="09">сентябрь</option>
                    <option value="10">октябрь</option>
                    <option value="11">ноябрь</option>
                    <option value="12">декабрь</option>
                </select>
                <select class="lk_select select input__ym-y">
                    <option value="">Год</option>
                    {foreach from=$all_years item=year}
                        <option value="{$year}">{$year}</option>
                    {/foreach}
                </select>
            </div>
        </div>
    </div>
    <div class="row__input">
        <div class="input__item w2">
            <h4>Название компании</h4>
            <input type="text" class="js_job_fields slyle_input" data-field="firm_title"
                   data-id="{$id}"/>
        </div>
        <div class="input__item w2">
            <h4>Должность</h4>
            <input type="text" class="js_job_fields slyle_input" data-field="job_title"
                   data-id="{$id}"/>
        </div>
    </div>

    <div class="row__input">
        <div class="input__item">
            <a class="js_del_user_job button button__add-work" data-id="{$id}">Удалить место
                работы</a>
            <br>
        </div>
    </div>
</div>