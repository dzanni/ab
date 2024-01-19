<div style="font-weight: bold">Массовый импорт наград</div>
<br>
<form action='/account/honor/' method='post' enctype='multipart/form-data'>
    <input type='file' class='filename' name='filename'>
    <input type='submit' value='Загрузить' name='honorAllListUpload'>
</form>
<a href='/modules/Lichniy-kabinet/honor_all_example.xlsx' target='_blank'>Скачать пример файла загрузки</a>


{if count($pages) > 1}
    <div class="catalog__pagination">
        <p>&nbsp;</p>
        Страницы:
        {foreach $pages as $p}
            <a data-page="{$p.page}" class="js_pages_chg catalog__pagination-page {if $p.active}active{/if}" >{$p.page}</a>
        {/foreach}
    </div>

{/if}