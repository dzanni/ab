<?php
$path = "/modules/Lichniy-kabinet/";
$SEO = SEO::getInstance($ROUTE);
$SEO->title = "Поиск по номеру запчасти";
$SEO->H1 = "Поиск по номеру запчасти";

$USER = CURRENT_USER::getInstance();
require_once (dirname(__FILE__)."/autoload.php");
$ASEARCH = new ASEARCH_GAK();
