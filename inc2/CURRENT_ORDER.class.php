<?php

class CURRENT_ORDER
{
    protected static $_instance;
    private $id;
    private $db;
    private $orderData;
    private $order;
    private $sum = 0;
    private $sum_formatted = 0;
    private $col = 0;
    private $sum_delay = 0;
    private $col_delay = 0;
    private $round = 2;
    private $user = 0;
    private $default_order_filter = array("status" => 0);
    private $lifetime_of_gen_basket = 1800; // 30 min in seconds
    private $userAddress;
    private $userContacts;

    public $orders_obj;
    public $orderData_obj;


    public function __construct()
    {
        $this->db = DB::getInstance();
        $this->user = CURRENT_USER::getInstance()->id;
        $this->get_order_id();

        $this->orders_obj = new dbl_orders();
        $this->orderData_obj = new dbl_orderData();

        $this->add_in_basket_check();
        $this->chg_in_basket();

        $this->get();
        $this->mk_order();

    }

    public static function getInstance()
    {
        if (self::$_instance === null) {
            self::$_instance = new self;
        }

        return self::$_instance;
    }

    private function __clone()
    {
    }

    private function __wakeup()
    {
    }

    public function render_mini_basket()
    {
        $smarty = SMARTY_GLOBAL::get();
        $smarty->assign("order", $this);
        return $smarty->fetch("mini_basket.tpl");
    }

    public function render_basket_col_and_price()
    {
        $smarty = SMARTY_GLOBAL::get();

        $smarty->assign("order", $this);
        return $smarty->fetch("basket_col_and_price.tpl");
    }

    public function getOrderParam($param)
    {
        if (isset($this->order[$param])) {
            return $this->order[$param];
        }
    }

    public function setOrderParamAndSave($param, $value)
    {
        if (isset($this->id)) {
            $order_chg = new dbl_orders();
            $order_chg->setFilter(array("id" => $this->id))->chg(array($param => $value));
            $this->order[$param] = $value;
            return 1;
        } else {
            return 0;
        }
    }

    private function mk_order()
    {
        if (!isset($_POST['mk_order'])) {
            return false;
        }
        if ($this->id == 0) {
            return $this->return_error_json("Ошибка №MK_ORDER_2. Ошибка получения заказа.");
        }
        if ($this->order['users'] > 0 && $this->order['users'] != $this->user) {
            return $this->return_error_json("Ошибка №MK_ORDER_3. Вам запрещено оформлять этот заказ.");
        }
        if (!$this->user) {
            $resultAutoCreate = $this->createNewUserFromOrder();
            if ($resultAutoCreate['status'] != "OK") {
                return $this->return_error_json($resultAutoCreate['msg']);
            } else {
                $this->user = $resultAutoCreate['id'];
                $this->setOrderParamAndSave("users", $this->user);
            }
        }

        $orderData = new dbl_orderData();
        $filter = array(
            "orders" => $this->id,
            "delay" => 0,
        );
        if ($orderData->setFilter($filter)->col()) {
            $orderData->chg(array("status" => 1, "users" => $this->user));
            $order = new dbl_orders();
            $order->setFilter(array("id" => $this->id))->chg(array("status" => 1, "users" => $this->user, "date_" => date("Y-m-d H:i:s")));
        } else {
            return $this->return_error_json("Ошибка №MK_ORDER1. В заказе нет ни одной позиции.");
        }

        /*$userAddress = new dbl_userAddress();
        if ($this->order['save_address'] == 1){
            $userAddress->insert(array("user_id"=>$this->user, "address" => $this->order['address']));
        }

        $userContacts = new dbl_userContacts();
        if ($this->order['save_contact'] == 1){
            $userContacts->insert(array("user_id"=>$this->user, "contact" => $this->order['contact']));
        }*/

        $order_id = $this->id; // сохраняем ИД т.к. он будет сейчас затерт. Для того, чтобы переместить позиции, которые не нужно оформлять в новый заказ.
        $this->unset_session_and_cookie();

        $filter = array(
            "orders" => $order_id,
            "delay" => 1,
        );
        if ($orderData->setFilter($filter)->col()) {
            $new_order_id = $this->get_new_order_id();
            $orderData->chg(array("orders" => $new_order_id));
            $this->get();
        }
        $_SESSION['step'] = 1;
        $this->return_ok_json("Заказ №$order_id оформлен");
    }

    private function chg_in_basket()
    {
        if (isset($_POST['chg_col_item_in_basket'])) {
            $orderData = new dbl_orderData();
            $filter = array(
                "orders" => $this->id,
                "id" => $_POST['id'],
            );
            $col = $orderData->setFilter($filter)->chg(array("col" => $_POST['col']));

            if ($col > 0) {
                $this->get()->sum_and_col();
                $sum = 0;
                foreach ($this->orderData as $v) {
                    if ($v['id'] == $_POST['id']) {
                        $sum = $v['sum'];
                        break;
                    }
                }
                $this->return_ok_json(array("html" => $this->render_mini_basket(), "sum_all" => $this->sum_formatted(), "col_all" => $this->col(), "sum_local" => $sum));
            } else {
                return $this->return_error_json("Ошибка №BSKCHG1. Обновите страницу пожалуйста.");
            }
        }
        if (isset($_POST['chg_delay_in_basket'])) {
            $orderData = new dbl_orderData();
            $filter = array(
                "orders" => $this->id,
                "id" => $_POST['id'],
            );
            $col = $orderData->setFilter($filter)->chg(array("delay" => $_POST['delay']));

            if ($col > 0) {
                $this->get()->sum_and_col();
                $sum = 0;
                foreach ($this->orderData as $v) {
                    if ($v['id'] == $_POST['id']) {
                        $sum = $v['sum'];
                        break;
                    }
                }
                $this->return_ok_json(array("html" => $this->render_mini_basket(), "sum_all" => $this->sum_formatted(), "col_all" => $this->col(), "sum_local" => $sum));
            } else {
                return $this->return_error_json("Ошибка №BSKCHG1. Обновите страницу пожалуйста.");
            }
        }
        if (isset($_POST['chg_field_in_order_data_basket'])) {
            $fields_to_change = array("comment"); // Доступный для изменения список
            $field = $_POST['field'];
            $value = $_POST['value'];
            // field проверить на доступный список
            if (in_array($field, $fields_to_change)) {
                $orderData = new dbl_orderData();
                $filter = array(
                    "orders" => $this->id,
                    "id" => $_POST['id'],
                );
                $col = $orderData->setFilter($filter)->chg(array($field => $value));
                if ($col > 0) {
                    $this->return_ok_json("OK");
                } else {
                    return $this->return_error_json("Ошибка №BSKCHG1. Обновите страницу пожалуйста.");
                }
            }
        }

        if (isset($_POST['chg_field_in_order_basket'])) {
            $fields_to_change = array("address", "comment", "address_id", "contact", "contact_id", "deliver", "payType", "save_contact", "save_address", "email", "f", "tel", "tel_code", "tel_verification"); // Доступный для изменения список
            $field = $_POST['field'];
            $value = $_POST['value'];
            // field проверить на доступный список
            if (in_array($field, $fields_to_change)) {
                $orders = new dbl_orders();
                $filter = array(
                    "id" => $this->id,
                );

                $chg_params = array(
                    $field => $value,
                );
                $needReloadPrice = false;
                if ($field == "deliver") {
                    $deliver = new dbl_deliver();
                    $deliver->setFilter(array("id" => $value))->setSelectFields("price")->get();
                    $deliverPrice = $deliver->result[0]['price'];
                    $chg_params['deliverPrice'] = $deliverPrice;
                    $needReloadPrice = true;
                    $this->order->deliverPrice = $deliverPrice;
                }

                $col = $orders->setFilter($filter)->chg($chg_params);
                if ($col > 0) {
                    if ($needReloadPrice) {
                        $this->get()->sum_and_col();
                        $this->return_ok_json(array("html" => $this->render_mini_basket(), "sum_all" => $this->sum_formatted(), "col_all" => $this->col(), "reload_price" => "true"));
                    } else {
                        $this->return_ok_json(array("status" => "OK", "reload_price" => "false"));
                    }

                } else {
                    return $this->return_error_json("Ошибка №BSKCHG1. Обновите страницу пожалуйста.");
                }
            } else {
                return $this->return_error_json("Ошибка №BSKCHG2. Изменение запрещено.");
            }
        }

        if (isset($_POST['remove_from_basket'])) {
            $orderData = new dbl_orderData();
            $filter = array(
                "orders" => $this->id,
                "id" => $_POST['id'],
            );
            $col = $orderData->setFilter($filter)->delete();
            if ($col > 0) {
                $this->get()->sum_and_col();
                $sum = 0;
                foreach ($this->orderData as $v) {
                    if ($v['id'] == $_POST['id']) {
                        $sum = $v['sum'];
                        break;
                    }
                }
                $this->return_ok_json(array("html" => $this->render_mini_basket(), "sum_all" => $this->sum_formatted(), "col_all" => $this->col(), "sum_local" => $sum));
            } else {
                return $this->return_error_json("Ошибка №BSKCHG2. Попробуйте еще раз.");
            }
        }
    }

    private function add_in_basket_check()
    {
        if (isset($_POST['addInBasket'])) {
            if ($this->id == 0) {
                $this->id = $this->get_new_order_id();
            }
            if ($this->id > 0) {
                $data = $this->parse_add_data();
                if (!$data) {
                    return $this->return_error_json("Ошибка №BSK2. Ошибка данных. Обновите страницу и попробуйте еще раз.");
                }
                if (!isset($_POST['col'])) {
                    return $this->return_error_json("Ошибка №BSK3. Не задано количество товара.");
                }
                if (!isset($data['date_gen']) || ($data['date_gen'] + $this->lifetime_of_gen_basket) < time()) {
                    return $this->return_error_json("Ошибка №BSK4. Запрет на добавление в корзину. Прошло слишком много времени с момента генерации страницы. Цена могла измениться.");
                }
                if ($_POST['col'] > $data['max_col']) {
                    $_POST['col'] = $data['max_col'];
                }
                $this->add_in_basket($data);
            } else {
                return $this->return_error_json("Ошибка №BSK1. Попробуйте обновить страницу и попробовать еще раз.");
            }
        }
    }

    public function check_is_in_basket($element)
    {
        // add_in_basket() в этой функции тоже ведется поиск при добавлении товара.
        if (!$this->id) return 0;
        if (!count($this->orderData)) return 0;

        foreach ($this->orderData as $od) {
            if ($element['id'] == $od['tovarId'] && $element['id_1c'] == $od['ID_1C'] &&
                $element['sellers'] == $od['seller_id']) {
                return $od['col'];
            }
        }
        return 0;
    }

    private function add_in_basket($basket)
    {
        $params = array();
        foreach ($_POST as $key => $item) {
            $params[$key] = $item;
        }
        foreach ($basket as $key => $item) {
            $params[$key] = $item;
        }

        $params['price'] = round($params['price'], 2);
        $add = array(
            "orders" => $this->id,
            "seller_id" => $params['seller_id'],
            "ID_1C" => $params['id_1c'],
            "tovarId" => $params['id'],
        );
        // check_is_in_basket() в этой функции тоже ведется поиск при добавлении товара.
        $order_data = new dbl_orderData();
        if ($order_data->setFilter($add)->col() > 0) {
            $this->return_error_json("Ошибка №BSK5. Такая позиция уже добавлена в корзину.");
        }

        if ($this->user) {
            $user = $this->user;
        } else {
            $user = 0;
        }

        $add = array(
            "orders" => $this->id,
            "seller_id" => $params['sellers'],
            "ID_1C" => $params['id_1c'],
            "tovarId" => $params['id'],
            "price" => $params['price'],
            "ws_detail_id" => "",
            "col" => $params['col'],
            "days_avg" => 0,
            "days_max" => 0,
            "code" => $params['artikul'],
            "firm" => $params['fName'],
            "title" => $params['title'],
            "max_col" => $params['max_col'],
            "inpack" => 1,//$params['inpack'],
            "buyPrice" => $params['buyPrice'],
        );

        $order_data->insert_local_table($add);
        $this->get()->sum_and_col();
        $this->return_ok_json(array("html" => $this->render_mini_basket(), "btn" => viewer::added_in_basket($params)));
    }

    private function return_error_json($err)
    {
        echo json_encode(array("status" => "ERR", "msg" => $err), JSON_UNESCAPED_UNICODE);
        exit();
    }

    private function return_ok_json($msg)
    {
        echo json_encode(array("status" => "OK", "msg" => $msg), JSON_UNESCAPED_UNICODE);
        exit();
    }

    private function get_new_order_id()
    {
        $order = new dbl_orders();
        $insert = array("date_" => date("Y-m-d H:i:s"), "status" => 0);
        if ($this->user) {
            $insert['users'] = $this->user;
        }
        $this->id = $order->insert_local_table($insert);
        $_SESSION['order_id'] = $this->id;
        setcookie('order_id', $_SESSION['order_id'], time() + 150 * 864000, "/");  /* срок действия 150 дней */
        return $this->id;
    }

    private function get_order_id()
    {
        if (!isset($_COOKIE['order_id']) && isset($_SESSION['order_id'])) {
            setcookie('order_id', $_SESSION['order_id'], time() + 150 * 864000, "/");  /* срок действия 150 дней */
        } elseif (isset($_COOKIE['order_id']) && isset($_SESSION['order_id']) && $_COOKIE['order_id'] <> $_SESSION['order_id']) {
            setcookie('order_id', $_SESSION['order_id'], time() + 150 * 864000, "/");  /* срок действия 150 дней */
        } elseif (isset($_COOKIE['order_id']) && !isset($_SESSION['order_id'])) {
            $_SESSION['order_id'] = $_COOKIE['order_id'];
        }
        if (!$_SESSION['order_id'] && $this->user > 0) {
            /* если заказа нет в сессии - но пользователь авторизован */
            $filter = $this->default_order_filter;
            $filter["users"] = $this->user; /* ищем неоформленные заказы по этому пользователю */
            $order = new dbl_orders();
            $order->setSelectFields("id")->setFilter($filter)->get();
            if (count($order->result)) {
                $_SESSION['order_id'] = $order->result[0]['id'];
                setcookie('order_id', $_SESSION['order_id'], time() + 150 * 864000, "/");
                /* срок действия 150 дней */
            }
        }
        if ($_SESSION['order_id']) {
            $this->id = $_SESSION['order_id'];
        } else {
            $this->id = 0;
        }
    }

    private function unset_session_and_cookie()
    {
        $this->id = 0;
        if (isset($_SESSION['order_id'])) {
            unset($_SESSION['order_id']);
            setcookie('order_id', '', time() - 50000, "/");
        }
    }

    public function get()
    {
        if ($this->id > 0) {

            $filter = $this->default_order_filter;
            $filter["id"] = $this->id;
            $this->orders_obj->set_getDeliverAndPayNames(true);
            $this->orders_obj->setFilter($filter)->get();
            if (count($this->orders_obj->result)) {
                if ($this->user > 0 && $this->orders_obj->result[0]['users'] == 0) {
                    /* заказ делался без авторизации */
                    $this->orders_obj->result[0]['users'] = $this->user;
                    $this->orders_obj->chg(array("users" => $this->user));
                } elseif ($this->user == 0 && $this->orders_obj->result[0]['users'] > 0) {
                    $this->orders_obj->result = array(); // запрещаем просматривать заказ без регистрации
                    $this->unset_session_and_cookie();   // удаляем переменную заказа (при авторизации они создадутся)
                } elseif ($this->user > 0 && $this->orders_obj->result[0]['users'] > 0 && $this->user != $this->orders_obj->result[0]['users']) {
                    $this->orders_obj->result = array(); // запрещаем просматривать чужой заказ
                    $this->unset_session_and_cookie();   // удаляем переменную заказа (при авторизации они создадутся)
                }

                $this->order = $this->orders_obj->result[0];
            } else {
                $this->unset_session_and_cookie();
                $this->order = "ERROR: no such order in DB";
                return $this;
            }

            $this->getOrderData();

            return $this;
        } else {
            return false;
        }
    }

    public function getOrderData()
    {
        $filter = array("orders" => $this->order['id']);
        $this->orderData_obj->setFilter($filter)->get();
        $this->orderData = $this->orderData_obj->result;

        $this->sum_and_col();

        return $this;
    }

    private function sum_and_col()
    {
        $this->sum = 0;
        $this->col = 0;

        for ($i = 0; $i < count($this->orderData); $i++) {
            $this->orderData[$i]['sum'] = $this->round($this->orderData[$i]['col'] * $this->orderData[$i]['price']);
            $this->orderData[$i]['sum_formatted'] = str_replace(" ", "&nbsp;", number_format($this->orderData[$i]['sum'], PARAMS::get("ROUND_PRICE"), '.', " "));
            if ($this->orderData[$i]['delay']) {
                $this->sum_delay += $this->orderData[$i]['sum'];
                $this->col_delay += $this->orderData[$i]['col'];
            } else {
                $this->sum += $this->orderData[$i]['sum'];
                $this->col += $this->orderData[$i]['col'];
            }
        }

        $this->sum += $this->order['deliverPrice'];
        $this->sum = $this->round($this->sum);
        $this->sum_formatted = str_replace(" ", "&nbsp;", number_format($this->sum, PARAMS::get("ROUND_PRICE"), '.', " "));
        $this->sum_delay = $this->round($this->sum_delay);
        return $this;
    }

    public function sum()
    {
        return $this->sum;
    }
    public function sum_formatted()
    {
        return $this->sum_formatted;
    }

    public function col()
    {
        return $this->col;
    }

    private function round($val)
    {
        return round($val, $this->round);
    }

    public function param($param)
    {
        return $this->order[$param];
    }

    public function orderData()
    {
        return $this->orderData;
    }

    private function parse_add_data()
    {
        if (!isset($_POST["add_in_basket"])) {
            return false;
        }
        $basket = explode(self::get_razdelitel(), $_POST["add_in_basket"]);
        if (count($basket) != 2) {
            return false;
        }
        $basket = json_decode(base64_decode($basket[0]), true);
        $basket_check = self::mk_add_in_basket_row($basket);
        if ($basket_check == $_POST["add_in_basket"]) {
            return $basket;
        }
        return false;
    }

    static function mk_sign($val)
    {
        return md5(PARAMS::get("PRICE_PWD") . $val);
    }

    static function mk_add_in_basket_row($item)
    {
        $fields = self::get_add_in_basket_params();
        $res = array();
        foreach ($fields as $f) {
            if (isset($item[$f])) {
                $res[$f] = $item[$f];
            } else {
                if ($f == "max_col") {
                    $res[$f] = $item["col"]; // максимально возможное количество. А количество вписывает клиент сам
                } elseif ($f == "date_gen") {
                    $res[$f] = time();
                    // дата генерации цены (фиксируем какое-то время жизни) - не даем делать заказ если прошло больше ХХХ секунд.
                } else {
                    $res[$f] = "";
                }
            }
        }
        if ($res == false) {
            return false;
        }
        $res = json_encode($res, JSON_UNESCAPED_UNICODE);
        $res = base64_encode($res);
        $res .= self::get_razdelitel() . self::mk_sign($res);
        return $res;
    }

    static function get_add_in_basket_params()
    {
        return array("id", "artikul", "fName", "title", "max_col", "sellers", "buyPrice", "price", "date_gen", "id_1c");
    }

    static function get_razdelitel()
    {
        return "~|-|~";
    }

    private function createNewUserFromOrder()
    {
        $user = CURRENT_USER::getInstance();
        if ($user->id) {
            return array("status" => "OK", "msg" => "Вы уже авторизованы", "id" => $this->id);
        }

        $email = $this->getOrderParam("email");
        $tel = $this->getOrderParam("tel");
        $name = $this->getOrderParam("f");

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return array("status" => "ERR", "msg" => "Некорректный формат е-мейл", 'id' => 0);
        }

        $user = new dbl_users();
        $user->setFilter(array("login" => $email));
        if ($user->col() > 0) {
            /* привязываем заказ к пользователю по почте, но не авторизуемся и ничего больше не меняем */
            $user->setSelectFields("id")->get();
            $this->setOrderParamAndSave("comment", $this->getOrderParam("comment") . " Заказ без авторизации");
            return array("status" => "OK", "msg" => "Привязан к существующему пользователю. Без входа", "id" => $user->result[0]['id']);
        } else {
            $pwd_user = dbl_users::gen_password(6);
            $pwd = password_hash($pwd_user, PASSWORD_BCRYPT);
            $tel_code = random_int(1000, 9999);
            $newUser = array(
                "login" => $email,
                "tel" => $tel,
                "name" => $name,
                "pwd" => $pwd,
                "status" => 1,
                "tel_code" => $tel_code
            );
            $userId = $user->insert_local_table($newUser);

            if ($userId) {
                $token = CURRENT_USER::genToken($email, $userId);
                $_SESSION['token'] = $token;
                $user->setFilter(array("id" => $userId))->chg(array("token" => $token));

                self::send_mail_auto_registration($email, $pwd_user);

                return array("status" => "OK", "msg" => "Создан новый пользователь. Авторизован.", "id" => $userId);
            } else {
                return array("status" => "ERR", "msg" => "Ошибка при создании пользователя.", 'id' => 0);
            }
        }
    }

    static function send_mail_auto_registration($login, $pwd_user)
    {
        $mail = new mail();
        $mail->setTo($login)->setTheme("Данные для входа на сайт " . PARAMS::get('COMPANY_EXP'));
        $smarty = SMARTY_GLOBAL::getInstance();
        $smarty->assign("params", PARAMS::getAll());
        $smarty->assign("pwd", $pwd_user);
        $smarty->assign("login", $login);
        $mail->setTxt($smarty->fetch(dirname(__FILE__) . "/../templates/mail/send_autoreg_data.tpl"));
        if ($mail->send() == 1) {
            return true;
        } else {
            return false;
        }
    }

    public function checkOrderPhone(){
        if (isset($_POST['tel_code'])){
            if ($this->param("tel_code") == $_POST['tel_code']){
                if ($this->setOrderParamAndSave("tel_verification", 1) == 1){
                    return 1;
                }else{
                    return 0;
                }
            }else{
                return 0;
            }
            exit();
        }

    }


}