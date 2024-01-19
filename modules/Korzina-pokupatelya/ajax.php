<?php
require("../../start.php");
require(dirname(__FILE__) . "/autoload.php");


$user = CURRENT_USER::getInstance();
$order = CURRENT_ORDER::getInstance();

//$order->checkOrderPhone();

if (isset($_POST['checkOrderTel'])) {
    $tel = $_POST['tel'];
    if ($user->tel == $tel && $user->tel_verification == 1) {
        echo "Телефон подтвержден";
    } else {
        echo "<div class='js_prove_order_tel button cart__order-button form__button'>Подтвердить телефон заказа</div>";
    }
}

if (isset($_POST['proveOrderTel'])) {
    $tel = $_POST['tel'];
    $tel_code = random_int(1000, 9999);
    $order = CURRENT_ORDER::getInstance();
    if ($order->setOrderParamAndSave("tel_code", $tel_code) == 1 && $order->setOrderParamAndSave("tel_verification", 0) == 1) {
        $text = "Код подтверждения $tel_code";
        if (SMS::send($tel, $text)) {
            echo "<div style='display: inline-flex'><input type='text' style='width: 50%' placeholder='Код из sms'><a class='button js_accept_order_tel'>Отправить</a></div>";
        } else {
            echo "Ошибка отправки SMS";
        }
    } else{
        echo "Ошибка при записи параметров заказа";
    }
}

if (isset($_POST['acceptOrderTel'])) {
    //$tel_code = preg_replace("/[^0-9]/", "", $_POST['tel_code']);

    if ($order->checkOrderPhone() == 1) {
        echo "Телефон подтвержден";
    } else {
        echo "<div style='display: inline-flex'><input type='text' style='width: 50%' placeholder='Код из sms'><a class='button js_accept_order_tel'>Повторить ввод</a></div>"."<br><br>".
            "<div class='js_prove_order_tel button cart__order-button form__button'>Еще раз отправить SMS</div>"
        ;
    }
}

   /*
    $orders = new dbl_orders();
    $orders->setSelectFields("tel_code")->setFilter(array("id" => $id));
    if ($orders->col()) {
        $orders->get();
        if ($orders->result[0]['tel_code'] == $tel_code) {
            $orders->setFilter(array("id" => $id))->chg(array("tel_verification" => 1));
            echo "Телефон подтвержден";
        } else {
            echo "Телефон не подтвержден. Неверный код";
        }
    } else {
        echo "Пользователь не обнаружен";
    }
}*/
