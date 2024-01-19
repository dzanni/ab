<?php
$path = "/modules/Quests/";
$path_lk = "/modules/Lichniy-kabinet/";
$SEO = SEO::getInstance($ROUTE);

$APP::add_js($path_lk."script/libs/jquery.fileupload.js");
$APP::add_js($path_lk."script/libs/jquery.formstyler.min.js");
$APP::add_js($path_lk."script/libs/jquery.knob.js");
$APP::add_js($path_lk."script/libs/file_upload_init.js");
$APP::add_js("/modules/Quests/script/quest.js");

new render_quest();
