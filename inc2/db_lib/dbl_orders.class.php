<?php
class dbl_orders extends db_lib{
    const TABLE_NAME = "orders";
    private $getDeliverAndPayNames = false;
    private $filter_order_id = 0;

    public function set_getDeliverAndPayNames($v){
        $this->getDeliverAndPayNames = $v;
        return $this;
    }
    public function get(){
        $result = parent::get();
        $data = $this->result;

        if ($this->getDeliverAndPayNames == false){
            return $result;
        }

        if (count($data) > 0){

            $PayType = new dbl_PayType();
            $deliver = new dbl_deliver();

            $PayType->setCol(1000)->setFilter(array("isActiv" => 1))->setSelectFields("id, title")->get();
            $payTypeById = array();
            foreach ($PayType->result as $v){
                $payTypeById[$v['id']] = $v;
            }
            $deliver->setCol(1000)->setFilter(array("active" => 1))->setSelectFields("id, name")->get();
            $deliverById = array();
            foreach ($deliver->result as $v){
                $deliverById[$v['id']] = $v;
            }


            foreach ($data as &$d) {
                $d['payTypeName'] = $payTypeById[$d['payType']];
                $d['deliverName'] = $deliverById[$d['deliver']];
            }
        }
        $this->result = $data;
        return $result;

    }

    public function setFilter($filter)
    {
        if (isset($filter['id'])){
            $this->filter_order_id = $filter['id'];
        }else{
            $this->filter_order_id = 0;
        }
        return parent::setFilter($filter);
    }

    public function chg( $values = array() ){
        $res = parent::chg($values);
        if (isset($values['status']) && $this->filter_order_id > 0){ // если меняется статус заказа и у нас сохранен ИД заказа
            $user_informer = new user_informer();
            $user_informer->set_order_id($this->filter_order_id)->set_order_status_id($values['status'])->order_notificate();
        }
        return $res;
    }

}