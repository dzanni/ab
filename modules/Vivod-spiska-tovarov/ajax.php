<?php
require("../../start.php");

if (isset($_POST['addFavorite'])) {
    $id = $_POST['id'];
    $user_id = CURRENT_USER::getInstance()->id;

//ini_set("display_errors",1);
//error_reporting(E_ALL);

    $favorite = new dbl_favorite();
    $filter = array("tovar_id" => $id);
    $favorite->setCol(1)->setSelectFields("id, tovar_id, user_id")->setFilter($filter);
    if ($favorite->col() == 0) {
        $insert = array(
            'tovar_id' => $id,
            'user_id' => $user_id,
        );
        $favorite->insert_local_table($insert);
        echo "on";
    } else {
        $delete = array(
            'tovar_id' => $id,
            'user_id' => $user_id,
        );
        $favorite->delete($delete);
        echo "off";
    }
}
/*
if (isset($_POST['editOptions'])) {
    $options_id = $_POST['options_id'];
    $tovar_id = $_POST['tovar_id'];

    $options_val = new dbl_options_values();
    $options_val->setFilter(array("parent" => $options_id))->get();
    $options_values = $options_val->result;
   if (count($options_values) > 0){
       $data = new dbl_data;
       $data->setSelectFields("options")->setFilter(array("tovar" => $tovar_id))->get();

       //debug::d($data->result, 1);

       $arr2 = array();
       foreach ($data->result as $val) {
           $arr2[] = $val['options'];
       }
       foreach ($options_values as &$value) {
           if (in_array($value['id'], $arr2)) {
               $value['flag'] = 1;
               //$options_val = new dbl_options_values();
               $options_val->setFilter(array("parent" => $value['id']))->get();
               if  ($options_val->col()){
                   $needRecursion = true;
               }else{
                   $needRecursion = false;
               }
           }else{
               $value['flag'] = 0;
           }
       }

       //debug::d($needRecursion, 1);
       //debug::d($options_values, 1);

       $smarty = SMARTY_GLOBAL::get();
       $smarty->assign("needRecursion", $needRecursion);
       $smarty->assign("options_values", $options_values);
       $smarty->assign("tovar_id", $tovar_id);
       echo $smarty->fetch(dirname(__FILE__)."/../../templates/lk_edit_selector.tpl");
       exit();
   }else{
      exit();
   }
}

if (isset($_POST['chgOptions'])) {
    $options_id = $_POST['options_id'];
    $tovar_id = $_POST['tovar_id'];
    $text = $_POST['value'];
    $flag = $_POST['flag'];
    $data = new dbl_data();
    if ($flag == 1) {
        $data->insert_local_table(array("tovar" => $tovar_id, "options" => $options_id, "text" => $text));
    }
    else {
        $data->setFilter(array("tovar" => $tovar_id, "options" => $options_id, "text" => $text))->delete();
    }
}


if (isset($_POST['saveOptions'])) {
    $tovar_id = $_POST['tovar_id'];
    $key = $_POST['key'];
    $options = $_POST['options'];
    //debug::d($options, 1);

    saveOptions ($tovar_id, $key, $options);
}

*/

if (isset($_POST['riseDownloadCounter'])) {
    $brand = $_POST['brand'];

    $firm = new dbl_firm;
    $firm->setSelectFields("downloads")->setFilter(array("id" => $brand))->get();
    $counter = $firm->result[0]['downloads'];
    $counter++;
    $firm->setFilter(array("id" => $brand))->chg(array("downloads" => $counter));
}

if (isset($_POST['riseVisitCounter'])) {
    $brand = $_POST['brand'];

    $firm = new dbl_firm;
    $firm->setSelectFields("visits")->setFilter(array("id" => $brand))->get();
    $counter = $firm->result[0]['visits'];
    $counter++;
    $firm->setFilter(array("id" => $brand))->chg(array("visits" => $counter));
}

if (isset($_GET['getModels'])) {
    $search_by_car = new search_by_car();
    echo $search_by_car->renderModels();
    exit();
}
if (isset($_GET['getYear'])) {
    $search_by_car = new search_by_car();
    echo $search_by_car->renderYear();
    exit();
}
if (isset($_GET['getModification'])) {
    $search_by_car = new search_by_car();
    echo $search_by_car->renderModification();
    exit();
}
if (isset($_GET['getVariants'])) {
    $search_by_car = new search_by_car();
    echo $search_by_car->renderVariants();
    exit();
}

if (isset($_POST['showAlsoVariants'])) {
    $smarty = SMARTY_GLOBAL::getInstance();
    $role = CURRENT_USER::getInstance()->role;
    $id = preg_replace("/[^0-9]/", "", $_POST['id']);

    //$smarty->assign("tovar", tovar::getAllTovarByTyporazmer($dbh, $id, $role)); // Старая функция
    $tovar_inner = new dbl_tovarInner();
    $tovar_inner->setSelectFields("tovar, tiporazmer")->setFilter(array("id" => $id));
    if ($tovar_inner->col()) {
        $tovar_inner->get();
        $tovar_tovar = $tovar_inner->result[0]['tovar'];
        $tiporazmer = $tovar_inner->result[0]['tiporazmer'];
    } else {
        exit();
    }

    $query = new db_lib();
    $query->setTableJoin("tovarInner, sellers", "tovarInner.sellers = sellers.id");

    $fields = "tovarInner.id AS tovarId, tovarInner.showUser as showUser, tovarInner.podZakaz AS tovarZakaz, tovarInner.casheTitle, tovarInner.casheIndex, tovarInner.casheRFXL, tovarInner.OEM, tovarInner.col, tovarInner.RRC, tovarInner.price, tovarInner.buyPrice, tovarInner.b2b, sellers.title AS sTitle";
    $filter = array("tovarInner.tovar" => $tovar_tovar, "tovarInner.tiporazmer" => $tiporazmer);
    if ($role == 1){
        $filter[">tovarInner.showUser"] = 0;
    }

    $query->setSelectFields($fields)->setFilter($filter)->setOrderBy(array("tovarInner.price"))->get();
    $tovar =  $query->result;

    foreach ($tovar as &$data){
        $data['delta'] = $data['price']-$data['buyPrice'];

        $data['delta'] = str_replace(" ", "&nbsp;", number_format($data['delta'], 0, '.', " "));
        $data['price'] = str_replace(" ", "&nbsp;", number_format($data['price'], 0, '.', " "));

        $data['buyPrice'] = str_replace(" ", "&nbsp;", number_format($data['buyPrice'], 0, '.', " "));
    }

//Запрос старой логики, отсюда берем псевдонимы:    $stml = $dbh->prepare("SELECT tovarInner.*, sellers.*, tovarInner.podZakaz AS tovarZakaz, tovarInner.id AS tovarId, sellers.title AS sTitle FROM `tovarInner`, sellers WHERE tovarInner.sellers = sellers.id AND `tovar`= ?  AND `casheTitle` =  ?  AND `casheIndex` =  ?  AND `runflat` =  ? AND tovarInner.col > 0 AND tovarInner.price > 0 $addSQL ORDER BY price");


    $smarty->assign("role", $role);
    $smarty->assign("tovarId", $id);
    $smarty->assign("tovar", $tovar);

    echo $smarty->fetch(dirname(__FILE__) . "/templates/all_variants.tpl");
}

/*
function saveOptions ($tovar_id, $key, $options){

    $options_values = new dbl_options_values;
    $options_values->setSelectFields("id")->setFilter(array("id_options" => $key))->get();
    $arr_to_delete = array();
    foreach ($options_values->result as $val){
        $arr_to_delete[] = $val['id'];
    }

    $data = new dbl_data();
    $data->setSelectFields("options")->setFilter(array("tovar" => $tovar_id))->get();
    foreach ($data->result as $value) {
        if (in_array($value['options'], $arr_to_delete)) {
            $data->setFilter(array("tovar" => $tovar_id, "options" => $value['options']))->delete();
        }
    }
    foreach ($options as $value) {
        if ($value != -1){
            $data->insert_local_table(array("tovar" => $tovar_id, "options" => $value));
        }
    }
}

*/