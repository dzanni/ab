<?php
require 'start.php';

$APP = APP::getInstance();
//$APP::add_css("/style/main.css");
$APP::add_js("/script/libs.js");
$USER = CURRENT_USER::getInstance();

$ROUTE = ROUTE::getInstance();

$ORDER = CURRENT_ORDER::getInstance();
$SEO = SEO::getInstance($ROUTE);
$CONTENT = CONTENT::getInstance($ROUTE);
$CONTENT->parse_content();
$MENU = menu::get($ROUTE);


foreach ($ROUTE->modules as $m){
    $fn = "modules/".$m['titleEN']."/".$m['titleEN'].".php";
    if (file_exists($fn)){
        include($fn);
    }
}

$smarty = SMARTY_GLOBAL::getInstance();

$APP->user = $USER;
$APP->order = $ORDER;
$APP->content = $CONTENT;
$APP->route = $ROUTE;
$APP->seo = $SEO;
$APP->menu = $MENU;
$APP->viewer = new viewer();
$smarty->assign("APP",$APP);
$smarty->assign("mainParams",mainParams::getAllByNames(DB::getInstance()));

if (isset($_GET['debug'])){debug::d($APP);}
$smarty->display("main.tpl");