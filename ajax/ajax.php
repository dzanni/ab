<?php
require (dirname(__FILE__)."/../start.php");

if (isset($_POST['chgHeaderFooter'])) {
    $choice = $_POST['choice'];
    $type = $_POST['type'];

    $mainParams = new dbl_mainParams();
    $mainParams->setFilter(array("param" => $type))->chg(array("value" => $choice));

    exit();
}

