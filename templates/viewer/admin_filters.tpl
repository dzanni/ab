{if $role_GAK >= 4}
<div class="admin_filter">
    <div class="filter__subtitle">Фильтры администратора</div>

<form class="admin_filter-form" action="/Poisk-po-shinam/" method="GET">
    <div class="admin_filter-title">Поиск по ID:</div>
    <input class="admin_filter-input" type="text" name="code" placeholder="{$code}">
    <input class="admin_filter-btn" type="submit" name="searchByCode" value="ПОИСК">
</form>

<form class="admin_filter-form" action="/Poisk-po-shinam/" method="GET">
    <div class="admin_filter-title">Поиск по OEM:</div>
    <input class="admin_filter-input" type="text" name="code_OEM" placeholder="{$code_OEM}">
    <input class="admin_filter-btn" type="submit" name="searchByCode" value="ПОИСК">
</form>

<form class="admin_filter-form" action="/Poisk-po-shinam/" method="GET">
    <div class="admin_filter-title">Поиск по КОДУ:</div>
    <input class="admin_filter-input" type="text" name="code_xml" placeholder="{$code_xml}">
    <input class="admin_filter-btn" type="submit" name="searchByCode_xml" value="ПОИСК">
</form>
</div>
{/if}