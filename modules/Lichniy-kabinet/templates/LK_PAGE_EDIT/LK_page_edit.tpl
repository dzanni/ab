<main>

    <div class="lk_menu lk_user">
        <h3>{$smarty_params.h1}</h3>
        {$msg_load_price}
        <a class="account__button button button--orange">Сохранить</a><br>
        {assign var="res" value=$result.0}
        {if $res.id}
        <!--<h4>ID: {$res.id}</h4>-->

      Заглушка
            <div class="alerts"></div>
            {else}
            <h3>Доступ запрещен</h3>
            {/if}
        </div>
    </div>
</main>