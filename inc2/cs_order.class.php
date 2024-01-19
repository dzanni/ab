<?php
require_once(dirname(__FILE__)."/dbl_orders.class.php");
require_once(dirname(__FILE__)."/dbl_orderData.class.php");

class cs_order
{
    private $id;
    private $db;
    private $orderData;
    private $order;
    private $sum;
    private $col;
    private $round = 2;


    public $orders_obj;
    public $orderData_obj;


    public function __construct($db, $id)
    {
        $this->db = $db;
        $this->id = $id;

        $this->orders_obj = new dbl_orders($db);
        $this->orderData_obj = new dbl_orderData($db);

        $this->get();
    }

    public function get()
    {
        $filter = array("id" => $this->id);
        $this->orders_obj->setFilter($filter)->get();
        if (count($this->orders_obj->result)) {
            $this->order = $this->orders_obj->result[0];
        } else {
            $this->order = "ERROR: no such order in DB";
            return $this;
        }

        $this->getOrderData();

        return $this;
    }


    public function getOrderData(){
        $filter = array("orders" => $this->order['id']);
        $this->orderData_obj->setFilter($filter)->get();
        $this->orderData = $this->orderData_obj->result;

        $this->sum_and_col();

        return $this;
    }

    private function sum_and_col(){
        $this->sum = 0;
        $this->col = 0;

        for($i=0;$i<count($this->orderData);$i++){
            $this->orderData[$i]['sum'] = $this->round($this->orderData[$i]['col'] * $this->orderData[$i]['price']);
            $this->sum+= $this->orderData[$i]['sum'];
            $this->col+= $this->orderData[$i]['col'];
        }

        $this->sum += $this->order['deliverPrice'];

        return $this;
    }
    public function sum(){
        return $this->sum;
    }
    public function col(){
        return $this->col;
    }

    private function round($val){
        return round($val,$this->round);
    }
    public function param($param){
        return $this->order[$param];
    }
    public function orderData(){
        return $this->orderData;
    }

    public function getObjTinkoff() {
        return new TinkoffMerchantAPI(
            //' ',  //Ваш Terminal_Key test
            //' '   //Ваш Secret_Key test
        );
    }
    public function getStatusTinkoff() {
        $api = $this->getObjTinkoff();
        $params = [
            'PaymentId' => $this->orders_obj->result[0]['tinkoff_paymentId'],
        ];
        $api->getState($params);
        return $api->status;
    }

    public function payTinkoff() {
        global $dbh;
        $payment_url = $this->orders_obj->result[0]['tinkoff_paymentUrl'];
        if ($payment_url == "" || $this->getStatusTinkoff() == "DEADLINE_EXPIRED") {
            $orderData = $this->orderData();
            $sum = $this->sum();

            $api = $this->getObjTinkoff();
            $email = users::getLogin($dbh, $this->orders_obj->result[0]['users']);

            $taxations = [
                'osn' => 'osn',                // Общая СН
                'usn_income' => 'usn_income',         // Упрощенная СН (доходы)
                'usn_income_outcome' => 'usn_income_outcome', // Упрощенная СН (доходы минус расходы)
                'envd' => 'envd',               // Единый налог на вмененный доход
                'esn' => 'esn',                // Единый сельскохозяйственный налог
                'patent' => 'patent'              // Патентная СН
            ];

            $paymentMethod = [
                'full_prepayment' => 'full_prepayment', //Предоплата 100%
                'prepayment' => 'prepayment',      //Предоплата
                'advance' => 'advance',         //Аванc
                'full_payment' => 'full_payment',    //Полный расчет
                'partial_payment' => 'partial_payment', //Частичный расчет и кредит
                'credit' => 'credit',          //Передача в кредит
                'credit_payment' => 'credit_payment',  //Оплата кредита
            ];

            $paymentObject = [
                'commodity' => 'commodity',             //Товар
                'excise' => 'excise',                //Подакцизный товар
                'job' => 'job',                   //Работа
                'service' => 'service',               //Услуга
                'gambling_bet' => 'gambling_bet',          //Ставка азартной игры
                'gambling_prize' => 'gambling_prize',        //Выигрыш азартной игры
                'lottery' => 'lottery',               //Лотерейный билет
                'lottery_prize' => 'lottery_prize',         //Выигрыш лотереи
                'intellectual_activity' => 'intellectual_activity', //Предоставление результатов интеллектуальной деятельности
                'payment' => 'payment',               //Платеж
                'agent_commission' => 'agent_commission',      //Агентское вознаграждение
                'composite' => 'composite',             //Составной предмет расчета
                'another' => 'another',               //Иной предмет расчета
            ];

            $vats = [
                'none' => 'none', // Без НДС
                'vat0' => 'vat0', // НДС 0%
                'vat10' => 'vat10',// НДС 10%
                'vat20' => 'vat20' // НДС 20%
            ];

            $amount = $sum * 100;

            $receiptItem = array();
            foreach ($orderData as $item) {
                $receiptItem[] = array(
                    "Name" => $item['name'],
                    "Price" => $item['price'] * 100,
                    "Quantity" => $item['col'],
                    "Amount" => $item['col'] * $item['price'] * 100,
                    'PaymentMethod' => $paymentMethod['full_prepayment'],
                    'PaymentObject' => $paymentObject['commodity'],
                    'Tax' => $vats['none']
                );
            }

            $deliver_price = $this->orders_obj->result[0]['deliverPrice'];
            if ($deliver_price != 0) {
                $receiptItem[] = array(
                    "Name" => "Доставка",
                    "Price" => $deliver_price * 100,
                    "Quantity" => 1,
                    "Amount" => $deliver_price * 100,
                    'PaymentMethod' => $paymentMethod['full_prepayment'],
                    'PaymentObject' => $paymentObject['service'],
                    'Tax' => $vats['none']
                );
            }
            $isShipping = false;

            if (!empty($isShipping[2]['Name'] === 'shipping')) {
                $isShipping = true;
            }

            $receipt = [
                'Email' => $email,
                'Taxation' => $taxations['usn_income'],
                'Items' => $this->balanceAmount($isShipping, $receiptItem, $amount),
            ];

            $enabledTaxation = true;

            $params = [
                'OrderId' => $this->id,
                'Amount' => $amount,
                'DATA' => [
                    'Email' => $email,
                    'Connection_type' => 'example'
                ],
            ];

            if ($enabledTaxation) {
                $params['Receipt'] = $receipt;
            }
            $api->init($params);

            $this->orders_obj->chg_by_id(array("tinkoff_paymentId" => $api->paymentId, "tinkoff_paymentUrl" => $api->paymentUrl), $this->id);
            $payment_url = $api->paymentUrl;
        }
        if ($payment_url) {
            header("Location: " . $payment_url);
        } else {
            echo "error";
            exit();
        }

    }

    public function balanceAmount($isShipping, $items, $amount)
    {
        $itemsWithoutShipping = $items;

        if ($isShipping) {
            $shipping = array_pop($itemsWithoutShipping);
        }

        $sum = 0;

        foreach ($itemsWithoutShipping as $item) {
            $sum += $item['Amount'];
        }

        if (isset($shipping)) {
            $sum += $shipping['Amount'];
        }

        if ($sum != $amount) {
            $sumAmountNew = 0;
            $difference = $amount - $sum;
            $amountNews = [];

            foreach ($itemsWithoutShipping as $key => $item) {
                $itemsAmountNew = $item['Amount'] + floor($difference * $item['Amount'] / $sum);
                $amountNews[$key] = $itemsAmountNew;
                $sumAmountNew += $itemsAmountNew;
            }

            if (isset($shipping)) {
                $sumAmountNew += $shipping['Amount'];
            }

            if ($sumAmountNew != $amount) {
                $max_key = array_keys($amountNews, max($amountNews))[0];    // ключ макс значения
                $amountNews[$max_key] = max($amountNews) + ($amount - $sumAmountNew);
            }

            foreach ($amountNews as $key => $item) {
                $items[$key]['Amount'] = $amountNews[$key];
            }
        }

        return $items;
    }

    public function setDataSber() {
        $this->sber_login = "test-api";
        $this->sber_pass = "test";
        return $this;
    }
    public function getStatusSber() {
        $domen = $_SERVER['REQUEST_SCHEME']."://" . $_SERVER['HTTP_HOST'];
        $order_id = $this->param("id");
        $sber_id = $this->param("sber_id");
        $url = "https://3dsec.sberbank.ru/payment/rest/getOrderStatusExtended.do";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_REFERER, $domen);
        curl_setopt($ch, CURLOPT_VERBOSE, 1);
        curl_setopt($ch, CURLOPT_POST, 1);

        $array = array(
            "userName" => $this->sber_login,
            "password" => $this->sber_pass,
            "orderId" => $sber_id,
            "orderNumber" => $order_id,
        );
        curl_setopt($ch, CURLOPT_POSTFIELDS, $array);

        curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/4.0 (Windows; U; Windows NT 5.0; En; rv:1.8.0.2) Gecko/20070306 Firefox/1.0.0.4");
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $result = curl_exec($ch);
        $result = json_decode($result, 1);
        return $result;
    }

    public function paySber() {
        $formUrl = $this->param("formUrl");
        if ($formUrl == "") {
            $url = "https://3dsec.sberbank.ru/payment/rest/register.do";
            $sum = $this->sum();
            $sum = $sum * 100;
            $order_id = $this->param("id");
            $key = $this->mk_pay_hash($order_id);
            $domen = $_SERVER['REQUEST_SCHEME']."://" . $_SERVER['HTTP_HOST'];
            $returnUrl = $domen . "/busket/?order=" . $order_id . "&pay=" . $key . "&order_status=paid";
            //$returnUrl = "http://avtoprimer.compsit.ru/busket/?order=" . $order_id . "&key=" . $key . "&order_status=paid";
            $items = array();
            foreach ($this->orderData as $i => $item) {
                $items[$i]['positionId'] = $item['id'];
                $items[$i]['name'] = $item['name'];
                $items[$i]['quantity'] = array("value" => $item['col'], "measure" => "st");
                $items[$i]['itemCode'] = $item['code'];
                $items[$i]['itemAmount'] = round((($item['price'] * 100) * $item['col']), 2);
            }
            $orderBoundle = array(
                "cartItems" => array(
                    "items" => $items
                )
            );
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_REFERER, $domen);
            curl_setopt($ch, CURLOPT_VERBOSE, 1);
            curl_setopt($ch, CURLOPT_POST, 1);

            $array = array(
                "userName" => $this->sber_login,
                "password" => $this->sber_pass,
                "amount" => $sum,
                "returnUrl" => $returnUrl,
                "orderNumber" => $order_id,
                "orderBundle" => json_encode($orderBoundle)
            );
//echo "<pre>";print_r($array);exit();
            curl_setopt($ch, CURLOPT_POSTFIELDS, $array);
            //curl_setopt($ch, CURLOPT_POSTFIELDS, "userName=" . $this->sber_login . "&password=" . $this->sber_pass . "&amount=" . $sum . "&returnUrl=" . $returnUrl . "&orderNumber=" . $order_id);

            curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/4.0 (Windows; U; Windows NT 5.0; En; rv:1.8.0.2) Gecko/20070306 Firefox/1.0.0.4");
            curl_setopt($ch, CURLOPT_HEADER, 0);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            $result = curl_exec($ch);
            $result = json_decode($result, 1);
            if ($result['orderId'] && $result['formUrl']) {
                $filter = array("id" => $order_id);
                $data_chg = array("formUrl" => $result['formUrl'], "sber_id" => $result['orderId']);
                $this->orders_obj->setFilter($filter)->chg($data_chg);
                $formUrl = $result['formUrl'];
            } else {
                echo $result['errorMessage'];
                exit();
            }
        }
        return $formUrl;
    }
    static public function mk_pay_hash($id)
    {
        return md5($id + 100);
    }
}