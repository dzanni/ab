<div class="container-fluid">
    <div class="pageData text_block">
        <div class="page-inner page-main">
            <main>
                <div class="content__block">



                    <div class="main__title">Нужно быстро получить достоверную информацию от экспертов автобизнеса?</div>
                    <div class="main__subtitle">Стань частью международного сообщества экспертов в автобизнесе!</div>
                    <!--<div class="main__twotitle">Зачем это мне?</div> -->
                    <div class="main__list">
                        <div class="main__item">
                            <a class="main__item-num" href="/users/">
                                <div class="main__item-num-wrap">
                                    <div class="main__item-count">1</div>
                                    <div class="main__item-desc">Контакты экспертов<br>
                                        в отрасли</div>
                                </div>
                            </a>
                            <div class="main__item-info">
                                <ul class="main__item-info-list">
                                    <li class="main__item-info-item">Посоветуйся с коллегой</li>
                                    <li class="main__item-info-item">Обменивайся актуальной информацией</li>
                                    <li class="main__item-info-item">Получай инсайты из первых уст </li>
                                </ul>
                            </div>
                        </div>
                        <div class="main__item">
                            <a class="main__item-num" href="/firms/">
                                <div class="main__item-num-wrap">
                                    <div class="main__item-count">2</div>
                                    <div class="main__item-desc">каталог отраслевых<br>
                                        поставщиков</div>
                                </div>
                            </a>
                            <div class="main__item-info">
                                <ul class="main__item-info-list">
                                    <li class="main__item-info-item">Найди надежных отраслевых поставщиков</li>
                                    <li class="main__item-info-item">Пожалуйся на поставщиков, кто подвел/обманул</li>
                                    <li class="main__item-info-item">Добавь проверенных поставщиков</li>
                                </ul>
                            </div>
                        </div>
                        <div class="main__item">
                            <a class="main__item-num" href="/account/?lk_reg">
                                <div class="main__item-num-wrap">
                                    <div class="main__item-count">3</div>
                                    <div class="main__item-desc">личная страница<br>
                                        эксперта с рейтингом</div>
                                </div>
                            </a>
                            <div class="main__item-info">
                                <ul class="main__item-info-list">
                                    <li class="main__item-info-item">Заяви о себе как эксперте</li>
                                    <li class="main__item-info-item">Делись уникальным опытом</li>
                                    <li class="main__item-info-item">Повышай свою стоимость на рынке труда</li>
                                </ul>
                            </div>
                        </div>
                    </div>


                    <div class="main__list-big">
                        <div class="list-big__item">
                            <div class="list-big__title">{$obj->toaday()} нас</div>
                            <div class="list-big__num"> {$obj->count_all()}</div>
                        </div>
                        <div class="list-big__item">
                            <div class="list-big__title">за неделю</div>
                            <div class="list-big__num">+{$obj->count_lastweek()}</div>
                        </div>
                    </div>



                    <div class="main__users">
                        <div class="main-users__col">
                            <div class="main-users__title">выбери страну</div>
                            {foreach from=$obj->get_countries() item=country}
                                <div class="main-users__item"><a href="/users/?tag={$country.id}">{$country.title}
                                        <span class="main-users__num">{$country.COL}</span>
                                    </a>

                                </div>
                            {/foreach}
                            {*<a class="main-users__more" href="#">Все страны</a>*}
                        </div>
                        <div class="main-users__col">
                            <div class="main-users__title">выбери компанию</div>
                            <div class="main-users__item"><a href="/firms/?tag=794">Автодилеры
                                    <span class="main-users__num">{$obj->count_company_by_tag("794,795")}</span>
                                </a>

                            </div>
                            <div class="main-users__item"><a href="/firms/?tag=797">Дистрибьюторы
                                    <span class="main-users__num">{$obj->count_company_by_tag(797)}</span>
                                </a>

                            </div>
                            <div class="main-users__item"><a href="/firms/?tag=799">СТО
                                    <span class="main-users__num">{$obj->count_company_by_tag("800,799")}</span>
                                </a>

                            </div>
                            <div class="main-users__item"><a href="/firms/?tag=801">Поставщик услуг
                                    <span class="main-users__num">{$obj->count_company_by_tag(801)}</span>
                                </a>

                            </div>
                            <div class="main-users__item"><a href="/firms/?tag=897">Производитель
                                    <span class="main-users__num">{$obj->count_company_by_tag(897)}</span>
                                </a>

                            </div>
                            <a class="main-users__more" href="/firms/">Все компании</a>
                        </div>
                        <div class="main-users__col">
                            <div class="main-users__title">выбери эксперта</div>
                            <div class="main-users__item"><a href="/users/?tag=831">Управление компанией
                                    <span class="main-users__num">{$obj->count_user_by_tag(831)}</span>
                                </a>
                            </div>
                            <div class="main-users__item"><a href="/users/?tag=829">Продажи
                                    <span class="main-users__num">{$obj->count_user_by_tag(829)}</span>
                                </a>

                            </div>
                            <div class="main-users__item"><a href="/users/?tag=830">Сервис
                                    <span class="main-users__num">{$obj->count_user_by_tag(830)}</span>
                                </a>

                            </div>
                            <div class="main-users__item"><a href="/users/?tag=827">Маркетинг
                                    <span class="main-users__num">{$obj->count_user_by_tag(827)}</span>
                                </a>

                            </div>
                            <div class="main-users__item"><a href="/users/?tag=818">F&I
                                    <span class="main-users__num">{$obj->count_user_by_tag(818)}</span>
                                </a>

                            </div>
                            <a class="main-users__more" href="/users/">Все эксперты</a>
                        </div>
                    </div>


                    <div class="main__best">
                        <div class="main-best__title">лучшие отраслевые решения</div>
                        <table class="main-best__table">
                            <tr>
                                <th>Статус компании</th>
                                <th>Сфера деятельности компании</th>
                                <th>Наименование</th>
                                {*<th>Сайт</th>*}
                                <th>Рейтинг</th>
                            </tr>

                            {foreach from=$obj->get_best_companies() item=data}
                                <tr>
                                    <td>{$data.status_title}</td>
                                    <td>{$data.activities}</td>
                                    <td><a href = "/firms/?firm={$data.firmId}">{$data.title}</a></td>
                                   {* <td>{$data.url}</td>*}
                                    <td>
                                        <div class="comp__item-rating">
                                            <div class="comp__item-rating-count">{$data.firm_rating}</div>
                                            <div class="comp__item-rating-stars">
                                                <div class="comp__item-rating-stars active" style="width: {$data.percent}%">
                                                    <svg class="svg-sprite-icon icon-icon__start">
                                                        <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
                                                    </svg>
                                                    <svg class="svg-sprite-icon icon-icon__start">
                                                        <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
                                                    </svg>
                                                    <svg class="svg-sprite-icon icon-icon__start">
                                                        <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
                                                    </svg>
                                                    <svg class="svg-sprite-icon icon-icon__start">
                                                        <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
                                                    </svg>
                                                    <svg class="svg-sprite-icon icon-icon__start">
                                                        <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
                                                    </svg>
                                                </div>
                                                <svg class="svg-sprite-icon icon-icon__start">
                                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
                                                </svg>
                                                <svg class="svg-sprite-icon icon-icon__start">
                                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
                                                </svg>
                                                <svg class="svg-sprite-icon icon-icon__start">
                                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
                                                </svg>
                                                <svg class="svg-sprite-icon icon-icon__start">
                                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
                                                </svg>
                                                <svg class="svg-sprite-icon icon-icon__start">
                                                    <use xlink:href="/i/v2/svg/symbol/sprite.svg#icon__start"></use>
                                                </svg>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                {/foreach}

                        </table><a class="main-best__more" href="/firms/">Все отраслевые решения</a>
                    </div>
                    <br><br>
                   {* В рейтинг выводятся компании
                    1-я колонка Статус компании - по одной компании, получившей наивысшую оценку среди аналогичных с учетом коэффициента: рейтинг*кол-во отзывов. Т.е. если среди поставщиков услуг есть 2 компании с рейтингом 5 звезд, выводится та, у которой больше отзывов :
                    Поставщик услуг - тег поставщик услуг
                    Производитель - тег производитель
                    Классифайд - классифайд
                    Банк - тег банк
                    Страховая компания - тег страховая компания
                    2-я колонка Сфера деятельности компании
                    выводятся теги, выбранные компанией в своей катрочке в категории сфера деятельности компании, через запятую, не более 3-х*}

                  {*Таблица "Лучшие отраслевые решения" - это ТОП-10 компаний с максимальной суммой оценок. Любая оценка компании, даже низкая, увеличивает сумму ее оценок.<br>
                    Колонка "Статус компании" - статус, указанный в карточке компании.<br>
                    Колонка "Сфера деятельности компании" - теги сферы деятельности, указанные в карточке компании (не более трех).<br>
                    Колонка "Рейтинг" - средняя оценка компании.*}


                </div>
            </main>
        </div>
    </div>
</div>