<?php
class dbl_clients extends db_lib{
    const TABLE_NAME = "clients";

    public function insert_local_table($values = array()){
        $result = parent::insert_local_table($values);
        $this->send_confirmation($values);
        return $result;
    }
    private function send_confirmation($params){
        if (isset($params['client_id']) && isset($params['firm_id'])){
            $mail = new mail();
            $mail->setTo($this->get_login($params['client_id']));

            $TXT = "<p>Компания <a href='https://expert.a-boss.ru/firms/?firm=".$params['firm_id']."'>".$this->get_fname($params['firm_id'])."</a> указала Вашу компанию  <a href='https://expert.a-boss.ru/firms/?firm=".$params['client_id']."'>".$this->get_fname($params['client_id'])."</a> в качестве клиента.</p>";
            $TXT .= "<p></p>";
            $TXT .= "<p>Вы можете принять пришлашение в <a href='https://expert.a-boss.ru/account/'>личном кабинете</a>. </p>";

            $mail->setTheme("Вашу компанию указали в качестве клиента");
            $mail->setTxt($TXT);
            $mail->send();
        }
    }

    private function get_login($id){
        $obj = new dbl_users();
        $filter = array(
            "IN=id" => " SELECT users FROM firm WHERE id = $id ",
        );
        $obj->setSelectFields("login")->setFilter($filter)->get();
        return $obj->result[0]['login'];
    }
    private function get_fname($id){
        $obj = new dbl_firm();
        $obj->setSelectFields("title")->setFilter(array('id'=>$id))->get();
        return $obj->result[0]['title'];
    }
}



