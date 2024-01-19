
    <main>
        <div class="quest__wrap">
            <div class="quest__bar">
                <h1>{$smarty_params.h1}</h1>
                <div class="quest__count">{$col_elements_find}</div>
                <a class="button button--orange quest__create js_create_new_quest">Создать вопрос</a>
            </div>


            <div class="js_inner_result_data">
                {if $col_elements_find == 0}
                    {$smarty_params.msg_null}
                {else}
                    {$html_inner}
                {/if}
            </div>


            <div class="js_pages">{$html_pages}</div>

        </div>
    </main>