<?php
spl_autoload_register(function ($class_name) {
    $path = dirname(__FILE__);
    $module_dirs = scandir($path.'/modules');
    if (file_exists($path."/inc2/".$class_name . '.class.php')){
        include($path."/inc2/".$class_name . '.class.php');
    }elseif (file_exists($path."/inc2/db_lib/".$class_name . '.class.php')){
        include($path."/inc2/db_lib/".$class_name . '.class.php');
    }elseif (file_exists($path."/inc/".$class_name . '.class.php')){
        include($path."/inc/".$class_name . '.class.php');
    }
    for($i=2;$i<count($module_dirs);$i++){
        if (file_exists($path."/modules/".$module_dirs[$i]."/inc/".$class_name . '.class.php')){
            include($path."/modules/".$module_dirs[$i]."/inc/".$class_name . '.class.php');
        }
    }
});
require dirname(__FILE__).'/inc2/recaptcha/autoload.php';
require dirname(__FILE__).'/vendor/autoload.php';  /* автозагрузка классов сторонних библиотек */