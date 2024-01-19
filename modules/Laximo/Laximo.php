<?php

$data['laximo_search'] = "laximo";
//$data['laximo_search'] = "all_brands";

    if (!($data['laximo_search'] == "laximo" || $data['laximo_search'] == "all_brands") && !isset($_GET["sr"])){
        require_once("laximo.class.php");
        $smarty_l = new Smarty;
        if ($brandList = laximo::getCatalogFirstLevel($data['laximo_search']));
        if (count($brandList) == 1){
            $_GET['c']=$brandList[0]['code'];
            $_GET['sr'] = true;
            $_GET['ssd'] = "";
            $_GET['type'] = "catalog";
            if ($brandList[0]['features']['wizardsearch2']){
                $_GET['spi2'] = "t";
            }
        }else{
            $smarty_l->assign("brandList", $brandList);
            $laximo = $smarty_l->fetch(dirname(__FILE__)."/../templates/laximo/brandList.tpl");
        }
    }
    if ($data['laximo_search'] == "laximo" || $data['laximo_search'] == "all_brands" || isset($_GET['sr'])){
        if ($data['laximo_search'] == "all_brands"){
            $_GET['type'] = "catalogs";
            $_GET['sr'] = 1;
        }

        ini_set('include_path', dirname(__FILE__)."/laximo/");
        ob_start();
        if (isset($_GET['sr']) && isset($_GET['type'])){
            if (isset($_GET['ft']) && isset($_GET['vin']) && strlen($_GET['vin']) != 17){
                echo "<div class='error'>Ошибка. Вин номер должен содержать 17 знаков</div>";
            }else{
                if(file_exists(dirname(__FILE__)."/laximo/".$_GET['type'].".php")){
                    require_once($_GET['type'].".php");
                }
            }
        }
        $laximo = ob_get_contents();
        ob_end_clean();
        if (isset($_GET['type']) && $_GET['type'] == "qdetails" && isset($_GET['ajax'])){
            echo $laximo;
            exit();
        }
    }


    $html = $laximo;
    if ($html) {
        $html = "<div class=\"content_padding_default\">$html</div>";
        $content = CONTENT::getInstance(ROUTE::getInstance());
        if (count($content->html) > 1) {
            array_splice($content->html, 1, 0, $html);
        } else {
            $content->html[] = $html;
        }
    }


$APP::add_css("/modules/Laximo/style/poisk_po_vin.css");