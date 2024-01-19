<?php

class user_informer
{
    private $order;
    private $order_id = 0;
    private $order_status_id = 0;
    private $mail = '';
    private $tel = '';
    private $mail_admin = '';
    private $status_info = array();

    function __construct(){
        $smarty = SMARTY_GLOBAL::getInstance();
        $smarty->assign("viewer", new viewer());
    }

    public function set_order_id($id){
        $this->order_id = $id;
        return $this;
    }
    public function set_order_status_id($id){
        $this->order_status_id = $id;
        return $this;
    }

    public function order_notificate(){
        if ($this->order_id == 0 || $this->order_status_id == 0 ){
            return false;
        }else{
            $status = new dbl_order_status();
            $status->setFilter(array("id"=>$this->order_status_id));
            if ($status->col() == 0){
                return false;
            }
            $status->get();
            $status_val = $status->result[0];
            $this->status_info = $status_val;

            if ($status_val['send_SMS'] || $status_val['send_mail'] || $status_val['send_mail_admin'] ){
                $order = new full_order();
                $order->set_getDeliverAndPayNames(true);
                $order->setFilter(array("id"=>$this->order_id))->get();
                $this->order = $order->result[0];

                if ($status_val['send_SMS']){
                    $this->tel = $this->order['tel'];
                }
                if ($status_val['send_mail']){
                    $this->mail = $this->order['email'];
                }
                if ($status_val['send_mail_admin']){
                    $this->mail_admin = true;
                }
                $this->send_notifications_order();

            }else{
                return false;
            }
        }
    }

    private function send_notifications_order(){
        if ($this->mail || $this->mail_admin){
            $this->send_order_mail_request();
        }
        if ($this->tel){
            $this->send_order_SMS_request();
        }
    }

    private function send_order_SMS_request(){
        return SMS::send($this->tel, $this->parseData($this->status_info['sms_text']));
    }

    private function send_order_mail_request()
    {
        $mail = new mail();
        if ($this->mail){
            $mail->setTo($this->mail);
        }
        if ($this->mail_admin){
            $mail->setAdmin_copy(true);
        }

        // $mail->setTheme("Заказ №$this->id с сайта " . PARAMS::get('COMPANY_EXP'));
        $mail->setTheme($this->parseData($this->status_info['theme']));
        $mail->setTxt($this->parseData($this->status_info['mail_text']));

        if ($mail->send() == 1) {
            return true;
        } else {
            return false;
        }
    }

    private function parseData($str){
        $comment = "";
        if ($this->order['comment']){
            $comment = "Комментарий к заказу: ".$this->order['comment'];
        }
        $parse = array(
            array("code"=>"{ORDER_ID}","val"=>$this->order['id'], "title"=>"Ид заказа"),
            array("code"=>"{SUM}","val"=>$this->order['id'], "title"=>"Сумма заказа"),
            array("code"=>"{ORDER_TABLE}","val"=>$this->get_order_table(), "title"=>"Таблица с заказом"),
            array("code"=>"{DATE}","val"=>$this->order['date_formatted'], "title"=>"Дата заказа"),
            array("code"=>"{STATUS}","val"=>$this->order['order_status'], "title"=>"Статус заказа"),
            array("code"=>"{COMMENT}","val"=>$comment, "title"=>"Комментарий к заказу"),
            array("code"=>"{DELIVER}","val"=>$this->order['deliverName']['name'], "title"=>"Доставка"),
        );
        foreach ($parse as $p){
            $str = str_replace($p['code'], $p['val'], $str);
        }
        return $str;
    }

    private function get_order_table(){
        $smarty = SMARTY_GLOBAL::getInstance();
        $smarty->assign("params", PARAMS::getAll());
        $smarty->assign("order", $this->order);

        return $smarty->fetch(dirname(__FILE__) . "/../templates/mail/send_order_table.tpl");
    }

}