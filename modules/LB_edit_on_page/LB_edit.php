<?php
$smarty = SMARTY_GLOBAL::getInstance();
if (isset($_GET['LB_edit_show'])){
    $_SESSION['LB_edit'] = true;
}
if (isset($_GET['LB_edit_close'])){
    unset($_SESSION['LB_edit']);
}

$LB_edit = false;
if (isset($_SESSION['LB_edit'])){
    $LB_edit = $_SESSION['LB_edit'];
}
$smarty->assign("LB_edit",$LB_edit);
require_once (dirname(__FILE__)."/../../inc/landing_block_type.class.php");

$lb_title_by_code = array();
$tmp = landing_block_type::get_base_structure(DB::getInstance());
for($i=0;$i<count($tmp);$i++){
    $lb_title_by_code[$tmp[$i]['id']] = $tmp[$i]['title'];
}
$ROUTE = ROUTE::getInstance();
$smarty->assign("category", $ROUTE->category);

exit();
$smarty->assign("LB_base", $lb_title_by_code);
$LB_edit_HTML = $smarty->fetch(dirname(__FILE__)."/../../modules/LB_edit_on_page/templates/LB_edit_on_page.tpl");
echo $LB_edit_HTML;

$APP = APP::getInstance();
$APP->LB_edit = $LB_edit;