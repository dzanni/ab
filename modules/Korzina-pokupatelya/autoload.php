<?php
spl_autoload_register(function ($class_name) {
    $path = dirname(__FILE__);
    if (file_exists($path."/inc/".$class_name . '.class.php')){
        include($path."/inc/".$class_name . '.class.php');
    }
});