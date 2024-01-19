<nav class="aside">
    <a class="aside__open" href="#">Меню  </a>
    <ul class="aside__list">
        {if $current_user->auth && $current_user->status == 1}
        <li class="aside__item">
            <a class="aside__link" href="/account/">
                <img class="svg" src="/i/build/content/svg/icon_user_03.svg" alt="">
                <span class="aside__title">Мой профиль</span>
            </a>
        </li>
        {/if}
        <li class="aside__item">
            <a class="aside__link" href="/users/">
                <img class="svg" src="/i/build/content/svg/icon_exp_03.svg" alt="">
                <span class="aside__title">Эксперты</span>
            </a>
        </li>
        {if $current_user->auth && $current_user->status == 1}
        <li class="aside__item"><a class="aside__link" href="/account/messages/">
                <img class="svg" src="/i/build/content/svg/icon_mess_03.svg" alt="">
                <span class="aside__title">Сообщения</span>
            </a>
        </li>
        {/if}
        <li class="aside__item"><a class="aside__link" href="/firms/">
                <img class="svg" src="/i/build/content/svg/icon_comp_03.svg" alt="">
                <span class="aside__title">Компании</span>
            </a>
        </li>
        <li class="aside__item"><a class="aside__link" href="/quests/">
                <img class="svg" src="/i/build/content/svg/icon_disc_03.svg" alt="">
                <span class="aside__title">Обсуждения</span>
            </a>
        </li>
        <li class="aside__item"><a class="aside__link" href="/quests/">
                <img class="svg" src="/i/build/content/svg/icon_news_03.svg" alt="">
                <span class="aside__title">Новости</span>
            </a>
        </li>
        <li class="aside__item">
            <a class="aside__link" href="/Kachalka/">
                <img class="svg" src="/i/build/content/svg/icon_prokach_03.svg" alt="">
                <span class="aside__title">Прокачка</span>
            </a>
        </li>
        <li class="aside__item">
            <a class="aside__link" href="/FAQ/">
                <img class="svg" src="/i/build/content/svg/icon_faq_03.svg" alt="">
                <span class="aside__title">FAQ</span>
            </a>
        </li>
    </ul>
</nav>