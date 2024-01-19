<div class="container-fluid">
    <div class="lk_menu label_style">
        <div class="auth_form">
            <h3>Восстановленее пароля: </h3>
            {if $chg_pwd}
                <p class="good">Ваш пароль изменен. Вы можете войти в свой аккаунт по новым данным.</p>
            {else}
                {if $error}<div class="bad">{$error}</div>{/if}
                {if $show_form}
                    <form action="" method="post">
                        <label>Ваш новый пароль: <input type="password"  class="slyle_input"  placeholder="пароль" name="pwd"> </label>
                        <input type="submit" class="account__button" value="Сменить" name="mk_chg_pwd">
                        {if $error}<div class="errorMsg">{$user->auth_result}</div>{/if}
                    </form>
                {/if}
            {/if}
        </div>
    </div>
</div>