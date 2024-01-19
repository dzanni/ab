<?php
$path = "/modules/Korzina-pokupatelya/";
$SEO = SEO::getInstance($ROUTE);
$SEO->title = "Корзина покупателя";
$SEO->H1 = "Корзина покупателя";

require_once (dirname(__FILE__)."/autoload.php");
new BASKET();