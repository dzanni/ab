<?php
require_once dirname(__FILE__)."/../modules/Lichniy-kabinet/inc/messages_lk.class.php";

class full_order extends dbl_orders{
    private $get_order_data = true;
    private $address_id = array();
    private $contact_id = array();
    private $payType = array();

    function __construct($dbh = 0){
        parent::__construct($dbh);
    }

    public function get(){
        $result = parent::get();

        $this->parse_get_result($this->result); ;
        return $result;
    }

    protected function parse_get_result($data){
        for($i=0;$i<count($data);$i++){
            $data[$i]['date_formatted'] = date("d.m.Y H:i", strtotime($data[$i]['date_']));
            if ($this->get_order_data){
                $obj = new full_order_data($data[$i]['id']);
                $data[$i]['data'] = $obj->return_obj();
            }
            if ($data[$i]['address_id'] > 0){
                $data[$i]['address'] = $this->get_addr_by_id($data[$i]['address_id']);

                //debug::d( $data[$i]['address'], 1);
            }
            if ($data[$i]['contact_id'] > 0){
                $data[$i]['contact'] = $this->get_contact_by_id($data[$i]['contact_id']);

                // debug::d($data[$i]['contact'], 1);
            }

            //debug::d($data[$i]['payType'], 1);
            $data[$i]['payType_txt'] = $this->get_payType_by_id($data[$i]['payType']);
            $data[$i]['order_status'] = $this->get_order_status_by_id($data[$i]['status']);
            $data[$i]['messages'] = $this->get_messages($data[$i]['id']);

            $data[$i]['sum'] = $data[$i]['data']->sum+$data[$i]['deliverPrice'];
        }
        $this->result = $data;
        return $data;
    }

    private function get_messages($id){
        $msg = new messages_lk();
        $filter = array("order_id"=>$id);
        $msg->setOrderBy(array(" date DESC "))->setFilter($filter)->setCol(200)->get();
        return $msg->render();
    }
    private function get_addr_by_id($id){
        if (isset($this->address_id[$id])){
            return $this->address_id[$id];
        }
        $obj = new dbl_userAddress;
        $obj->setFilter(array('id' => $id, 'user_id' => CURRENT_USER::getInstance()->id))->get();

        $result = $obj->result[0]['address'];
        $this->address_id[$id] = $result;

        return $result;

    }

    private function get_contact_by_id($id){
        if (isset($this->contact_id[$id])){
            return $this->contact_id[$id];
        }
        $obj = new dbl_userContacts;
        $obj->setFilter(array('id' => $id, 'user_id' => CURRENT_USER::getInstance()->id))->get();
            $result = $obj->result[0]['contact'];
        $this->contact_id[$id] = $result;
            return $result;
    }

    private function get_payType_by_id($id){
        if (isset($this->payType[$id])){
            return $this->payType[$id];
        }
        $obj = new dbl_PayType;
        $obj->setFilter(array('id' => $id))->get();

            $result = $obj->result[0]['title'];
               //debug::d($result, 1);
        $this->payType[$id] = $result;
            return $result;
    }

    private function get_order_status_by_id($id){
        foreach ($this->get_order_status() as $v){
            if ($v['id'] == $id)
                return $v['title'];
        }
    }


    public function get_order_status(){
        // copy from inc/order.php if change = change in order too
        $obj = new dbl_order_status();
        $obj->setOrderBy(array("position", "title"))->setCol(100)->get();
        $result = $obj->result;
        return $result;

        return array(
            array("id" => 1, "title" => "В обработке", "color" => "#e6ff00"),
            array("id" => 7, "title" => "Ожидаем оплату по заказу", "color" => "#a8d8ff"),
            array("id" => 9, "title" => "В заказ", "color" => "#a8d8ff"),
            array("id" => 2, "title" => "Принят в работу", "color" => "#c7ffba"),
            array("id" => 3, "title" => "На cкладе", "color" => "#a8d8ff"),
            array("id" => 4, "title" => "Cамовывоз", "color" => "#a8d8ff"),
            array("id" => 5, "title" => "Производится доставка", "color" => "#a8d8ff"),
            array("id" => 6, "title" => "Выполнен", "color" => "#e0ffab"),
            array("id" => 7, "title" => "Доступна онлайн оплата", "color" => "#e0ffab"),
            array("id" => -1, "title" => "Заказ анулирован", "color" => "#828282"),
            array("id" => 10, "title" => "Оформлен менеджером", "color" => "#828282"),
        );
    }
}

