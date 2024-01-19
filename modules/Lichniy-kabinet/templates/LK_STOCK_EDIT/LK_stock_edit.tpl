<h3>{$smarty_params.h1}</h3>

<div class="alerts"></div>
<div>{$msg_load_price}</div>
{$smarty_params.lk_stock_edit_profile_msg}
<p>Кодировка файла:
    <select class="js_chg_and_reload" data-field="f_csv_charset" data-id="{$result.0.id}">
        {foreach from=$lk_price_charset item=chr}
            <option value="{$chr}" {if $result.0.csv_charset == $chr}selected="selected"{/if}>{$chr}</option>
        {/foreach}
    </select>
</p>
<p>Разделитель для файла:
    <select class="js_chg_and_reload" data-field="f_csv_delitel" data-id="{$result.0.id}">
        <option>Попробовать автоматически</option>
        {foreach from=$lk_price_razdelitel key=key item=rzd}
            <option value="{$key}" {if $result.0.csv_delitel == $key}selected="selected"{/if}>{$rzd}</option>
        {/foreach}
    </select>
</p>
<input class="js_chg js_f_fOrder" type="hidden" value="{$result.0.fOrder}" data-field="f_fOrder" data-id="{$result.0.id}">
<p>Акивность прайс-листа: </p>
<div class="js_check_price"></div>

<p>Загрузка прайс-листа: принимается только формат csv!</p>
<form action="/account/stocks/?lk_stock_edit_profile={$result.0.id}" method="post" enctype="multipart/form-data">
    <input type="hidden" value="{$result.0.id}" name="seller">
    <input type="file" class="filename" name="filename">
    <input type="submit" class="fileUpload" value="Загрузить" name="fileUpload">
</form>
<p>
    Вам нужно произвести настройку соответствия полей. После того, как все необходимые поля будут сопоставлены достаточно еще раз загрузить прайс-лист и он пойдет в обработку.
</p>
<div class="load_price_set_settings" data-id="{$smarty_params.id}"></div>