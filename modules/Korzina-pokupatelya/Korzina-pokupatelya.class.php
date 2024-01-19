<?php
$path = "/modules/Korzina-pokupatelya/";
$SEO = SEO::getInstance($ROUTE);
$SEO->title = "Корзина покупателя";
$SEO->H1 = "Корзина покупателя";

new BASKET();
