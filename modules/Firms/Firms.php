<?php
$path = "/modules/Firms/";
$SEO = SEO::getInstance($ROUTE);
$user = CURRENT_USER::getInstance();


new render_firm();

$APP::add_js($path."script/firms.js");