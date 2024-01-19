{if count($err)}
    <div class="bad">
    <p>Завершите настройку прайс-листа. Не указаны обязательные поля: </p>
        <ul>
            {foreach from=$err item=e}
                <li>{$e}</li>
            {/foreach}
        </ul>
    </div>
{else}
    <div class="good">
        <p>Все обязательные поля указаны. </p>
    </div>
{/if}