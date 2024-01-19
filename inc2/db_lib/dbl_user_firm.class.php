<?php
class dbl_user_firm extends db_lib{
    const TABLE_NAME = "user_firm";

    public function insert_local_table($values = array()){
        $result = parent::insert_local_table($values);
        $this->send_confirmation($values);
        return $result;
    }
    private function send_confirmation($params){
        if (isset($params['user_id']) && isset($params['firm_id'])){
            if (isset($params['firm_agree']) && $params['firm_agree'] == 1){

                $mail = new mail();
                $mail->setTo($this->get_login($params['user_id']));

                $TXT = "<p>Компания <a href='https://expert.a-boss.ru/firms/?firm=".$params['firm_id']."'>".$this->get_fname($params['firm_id'])."</a> указала Вас в качестве сотрудника.</p>";
                $TXT .= "<p></p>";
                $TXT .= "<p>Вы можете принять пришлашение в <a href='https://expert.a-boss.ru/account/'>личном кабинете</a>. </p>";

                $mail->setTheme("Вас указали в качестве сотрудника");
                $mail->setTxt($TXT);
                $mail->send();

            } elseif (isset($params['agree'])){

                    $mail = new mail();
                    $mail->setTo($this->get_firm_mail($params['firm_id']));

                    $TXT = "<p>Пользователь <a href='https://expert.a-boss.ru/users/?user=".$params['user_id']."'>".$this->get_name($params['user_id'])."</a> запрашивает Вашу компанию ".$this->get_fname($params['firm_id'])." принять его в качестве сотрудника.</p>";
                    $TXT .= "<p></p>";
                    $TXT .= "<p>Вы можете принять пришлашение на  <a href='https://expert.a-boss.ru/users/?user=".$params['user_id']."'>странице пользователя</a>, нажав на кнопку &laquo;добавить в сотрудники&raquo;. </p>";

                    $mail->setTheme("Пользователь запрашивает возможность стать сотрудником компании");
                    $mail->setTxt($TXT);
                    $mail->send();

            }
        }
    }

    private function get_login($id){
        $obj = new dbl_users();
        $obj->setSelectFields("login")->setFilter(array('id'=>$id))->get();
        return $obj->result[0]['login'];
    }
    private function get_name($id){
        $obj = new dbl_users();
        $obj->setSelectFields("name, family_name ")->setFilter(array('id'=>$id))->get();
        return $obj->result[0]['family_name']." ".$obj->result[0]['name'];
    }
    private function get_fname($id){
        $obj = new dbl_firm();
        $obj->setSelectFields("title")->setFilter(array('id'=>$id))->get();
        return $obj->result[0]['title'];
    }
    private function get_firm_mail($id){
        $obj = new dbl_users();
        $filter = array(
            "IN=id" => " SELECT users FROM firm WHERE id = $id ",
        );
        $obj->setSelectFields("login")->setFilter($filter)->get();
        return $obj->result[0]['login'];
    }

}



