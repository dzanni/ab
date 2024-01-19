<h2>{$user.name} {$user.family_name}!</h2>
<p>&nbsp;</p>
<p>
    В системе Autoboss.Expert произошли следующие события:

    {if $obj->msg}
        <h3>
            <a href="https://expert.a-boss.ru/account/messages/">Новых личных сообщений: {$obj->msg} шт.</a>
        </h3>
    {/if}

    {if $obj->ans.col}
        <h3>Ответов на Ваши вопросы: {$obj->ans.col}</h3>

        {foreach from=$obj->ans.res item=ans}
            <p>
                <a href="https://expert.a-boss.ru/quests/?quest={$ans.quest_id}">{$ans.title}: {$ans.col} шт.</a>
            </p>
        {/foreach}

    {/if}

{if $obj->rmk.col}
    <h3>Отзывов на Ваши компании: {$obj->rmk.col}</h3>

    {foreach from=$obj->rmk.res item=rmk}
        <p>
            <a href="https://expert.a-boss.ru/firms/?firm={$rmk.firm_id}">{$rmk.title}: {$rmk.col} шт.</a>
        </p>
    {/foreach}

{/if}
