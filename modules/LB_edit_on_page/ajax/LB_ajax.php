<?php
session_start();

require_once ("../../../start.php");
require_once ("../../../db_connect.php");
require_once dirname(__FILE__).'/../../../core/inc/txt.class.php';
require_once dirname(__FILE__).'/../../../inc/landing_block_type.class.php';
require_once dirname(__FILE__).'/../LB_edit.class.php';

$smarty = new Smarty;
$smarty->compile_check = true;
$smarty->debugging = false;

require_once dirname(__FILE__).'/../../../inc/users.class.php';
if ($_SESSION['user']) {
    $role = users::getRole($dbh, $_SESSION['user']);
    $smarty->assign("role", $role);
    $LB_edit = false;
    if (isset($_SESSION['LB_edit'])){
        $LB_edit = $_SESSION['LB_edit'];
    }
    $smarty->assign("LB_edit",$LB_edit);
}

if (isset($_POST['remove_element'])){
    echo deleteTxtBlock($dbh,preg_replace("/[^0-9]/","",$_POST['id']));
    exit();
}

if (isset($_POST['chg_pos'])){
    $el = $_POST['el'];
    for($i=0;$i<count($el);$i++){
        $id = preg_replace("/[^0-9]/","",$el[$i]);
        txt::edit($dbh, "position", $i, $id);
    }
}

if (isset($_POST['copy_to_clip'])){
    $id = preg_replace("/[^0-9]/","",$_POST['copy_to_clip']);
    if ($id){
        $_SESSION['copy_to_clip'] = $_POST['copy_to_clip'];
        $smarty->assign("msg","OK");
    }else{
        $smarty->assign("msg","ERR");
    }
    $smarty->display("copy_clip.tpl");
    exit();
}

if (isset($_POST['add_type'])){
    $LB_edit = new LB_edit($dbh,$_POST['category'],$_POST['id'], $_POST['firm'], $_POST['firmpage']);
    $newId = $LB_edit->insert($_POST['LB_type'],$_POST['add_type']);
    if ($newId){
        $newData = $LB_edit->getById($newId);

        $smarty->assign("LB_edit", true); // Чтобы сразу показывался новый блок
        $smarty->assign("data", $newData);
        $smarty->assign("ADMIN_URL",dirname(__FILE__)."/../../../templates/");
        $smarty->display(dirname(__FILE__)."/../../../templates/shablon/txt_block.tpl");

    }else{
        echo "error";
    }
    exit();
}

if (isset($_POST['edit_element'])){
    $id = preg_replace("/[^0-9]/","",$_POST["id"]);
    $smarty->assign("id",$id);
    $smarty->display("edit_element.tpl");
    exit();
}
if (isset($_POST['get_element'])){
    $id = preg_replace("/[^0-9]/","",$_POST['get_element']);
    $txtBlock = category::getTxtBlock($dbh, $id);
    $smarty->assign("data",$txtBlock);
    $smarty->assign("ADMIN_URL",dirname(__FILE__)."/../../../templates/");
    $smarty->assign("LB_edit",false); // Добавляем, чтобы не добавлял блок еще раз.
    $smarty->display(dirname(__FILE__)."/../../../templates/shablon/txt_block.tpl");
    exit();
}

if (isset($_POST['get_add_new_form'])){
    $smarty->assign("category",$_POST['category']);
    $smarty->assign("id",$_POST['id']);
    $smarty->assign("firm",$_POST['firm']);
    $smarty->assign("firmpage",$_POST['firmpage']);

    //Для страниц фирм берем разрешенные для фирмы лендинги, для иных страниц - все лендинги
        if ($_POST['firm'] /*&& $_POST['firmpage']*/){
          $firm_landing = new dbl_firm_landing();
          $firm_landing->setTableJoin("firm_landing, landing_block_type", "firm_landing.landing = landing_block_type.id");
          $firm_landing->setSelectFields("landing_block_type.id AS id, landing_block_type.title AS title");
            $firm_landing->setFilter(array("firm_landing.firm"=>$_POST['firm']));
            if ($firm_landing->col()){
                $firm_landing->setOrderBy(array("landing_block_type.title"))->setCol(100)->get();
                $data = $firm_landing->result;
            }else{
                $data = array();
            }
        }else{
            $data = landing_block_type::get_base_structure($dbh);
        }

    $res = array();
    $res[] = array("id"=>"default","title"=>"Стандартный текстовый блок","filename"=>"/core/LB_img/default.jpg");
    if (isset($_SESSION['copy_to_clip'])){
        $res[] = array("id"=>"clipboard","title"=>"Из буфера","filename"=>"/core/LB_img/clipboard.jpg");
    }
    for($i=0;$i<count($data);$i++){
        $filename = "/core/LB_img/".$data[$i]['id'].".jpg";
        if (file_exists(dirname(__FILE__).'/../../..'.$filename)){
            $data[$i]['filename'] = $filename;
        }else{
            $data[$i]['filename'] = "/core/LB_img/noimg.jpg";
        }
        $res[] = $data[$i];
    }
    $smarty->assign("items",$res);
    $smarty->display("add_form.tpl");
    exit();
}