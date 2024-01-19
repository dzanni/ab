<?php
session_start();
if (!isset($_GET['debug'])){
    error_reporting(0);
    ini_set("display_errors",1);
}
require dirname(__FILE__).'/autoload.php';