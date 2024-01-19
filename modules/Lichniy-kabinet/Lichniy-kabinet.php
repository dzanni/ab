<?php
$path = "/modules/Lichniy-kabinet/";
$SEO = SEO::getInstance($ROUTE);
$SEO->title = "Личный кабинет";
$SEO->H1 = "Личный кабинет";

$USER = CURRENT_USER::getInstance();
$APP::add_js($path."script/libs/jquery.fileupload.js");
$APP::add_js($path."script/libs/jquery.formstyler.min.js");
$APP::add_js($path."script/libs/jquery.knob.js");
$APP::add_js($path."script/libs/file_upload_init.js");

$APP::add_js("https://cdn.ckeditor.com/4.8.0/standard-all/ckeditor.js");
$APP::add_js("/script/plugin/ckeditor/adapters/jquery.js");
$APP::add_js("/modules/Quests/script/quest.js");

$APP::add_js($path."script/lk.js");
$APP::add_js($path."script/orders.js");
$APP::add_css($path."style/lk.css");
$APP::add_css($path."style/lk_tmp.css");
$APP::add_js($path."script/messages.js");
$APP::add_js($path."script/remarks.js");
$APP::add_css($path."style/msg.css");

$smarty = SMARTY_GLOBAL::getInstance();
$smarty->assign("lk_page", true);

$LK = new LK();

