<?php
$_GET['debug'] = true;
require("../../start.php");

$user = CURRENT_USER::getInstance();
if ($user->role < 1){
    $res = array();
    $res['class'] = 'bad';
    $res['msg'] = "Ошибка! Доступ запрещен!";
    echo json_encode($res,JSON_UNESCAPED_UNICODE);
    exit();
}
if (isset($_POST['chg_data'])){
    if (isset($_POST['item'])){
        $obj = new dbl_orderData();
        $obj->setFilter(array("id"=>$_POST['item']));
    }else{
        $obj = new dbl_orders();
        $obj->setFilter(array("id"=>$_POST['id']));
    }
    $field = preg_replace("/[^0-9a-zA-Z_\-]/", "", $_POST['f']);
    $val = array(
        $_POST['f'] => $_POST['v'],
    );
    $res = array();
    if ($obj->chg($val)){
        $res['class'] = 'good';
        $res['msg'] = "Успешно изменено $obj->result шт.";
    }else{
        $res['class'] = 'bad';
        $res['msg'] = "Ошибка при изменении";
    }
    echo json_encode($res,JSON_UNESCAPED_UNICODE);
}

if (isset($_POST['remove_from_order'])){
    $obj = new dbl_orderData();
    $search = array(
        "id" => $_POST['order_element_id'],
        "orders" => $_POST['order_id'],
    );

    if ($obj->setFilter($search)->delete()){
        $res['class'] = 'good';
        $res['msg'] = "Позиция удалена";
        $res['reload_order'] = "1";
    }else{
        $res['class'] = 'bad';
        $res['msg'] = "Ошибка при удалении товара";
    }
    echo json_encode($res,JSON_UNESCAPED_UNICODE);
    exit();
}

if (isset($_POST['apply_order'])) {
    $obj = new dbl_orders();
    $obj->setFilter(array("id"=>$_POST['id']));
    $val = array(
        "manager" => $user->id,
    );
    $res = array();
    if ($obj->chg($val)){
        $res['class'] = 'good';
        $res['msg'] = "Вы приняли заказ";
    }else{
        $res['class'] = 'bad';
        $res['msg'] = "Ошибка при изменении";
    }
    echo json_encode($res,JSON_UNESCAPED_UNICODE);
}
if (isset($_POST['add_in_order'])){

    $res = array();
    $tovar = new catalogTovarInner();
    $filter = array("tovarInner.id"=>$_POST['art']);
    if (!$tovar->setFilter($filter)->col()){
        $res = array();
        $res['class'] = 'bad';
        $res['msg'] = "Ошибка! Товар с артикулом ".$_POST['art']." не найден!";
        echo json_encode($res,JSON_UNESCAPED_UNICODE);
        exit();
    }else{
        $tovar->get();
        $data = $tovar->result[0];
        $search = array(
            "tovarId" => $data['id'],
            "orders" => $_POST['id'],
        );
        $obj = new dbl_orderData();
        if ($obj->setFilter($search)->col()){
            $res['class'] = 'bad';
            $res['msg'] = "Ошибка! Такой товар уже есть в этом заказе";
        }else{
            $insert = array(
                "tovarId" => $data['id'],
                "price"   => $data['price'],
                "orders" => $_POST['id'],
                "title"  => $data['title'],
                "firm"  => $data['title'],
                "seller_id"  => $data['sellers'],
                "days_avg"  => $data['deliver_days'],
                "buyPrice"  => $data['buyPrice'],
                "code"  => $data['artikul'],
                "max_col"  => $data['col'],
                "col"  => $_POST['col'],
                "users"  => $user->id,
            );

            if ($obj->insert_local_table($insert)){
                $res['class'] = 'good';
                $res['msg'] = "Позиция добавлена в заказ";
                $res['reload_order'] = "1";
            }
        }
    }
    echo json_encode($res,JSON_UNESCAPED_UNICODE);
    exit();
}