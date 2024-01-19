<?php
require("../../start.php");


if (isset($_POST['addUserToFirm'])) {
    $user = $_POST['user'];
    $firm = $_POST['firm'];
    $flag =  $_POST['flag'];

    $user_firm = new dbl_user_firm();
    $user_firm->setFilter(array("user_id"=>$user, "firm_id"=>$firm));

    if ($flag == "add" && $user_firm->col()){
        $user_firm->get();
        if ($user_firm->result[0]['firm_agree'] == 0){
            $user_firm->chg(array("firm_agree"=>1));
        }
        if ($user_firm->result[0]['agree']){
            echo "- запрос подтвержден";
        }else{
            echo "- запрос отправлен";
        }
    }elseif ($flag == "add"){
        $user_firm->insert_local_table(array("user_id"=>$user, "firm_id"=>$firm, "firm_agree" => 1));
        echo "- запрос отправлен";
    }elseif ($flag == "del" && $user_firm->col()){
        $user_firm->delete();
        echo "- пользователь удален";
    }elseif ($flag == "del"){
        echo "";
    }
}