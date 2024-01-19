<?php
class dbl_users extends db_lib{
    const TABLE_NAME = "users";
    private $avtoboss_status = array();

    public function chg($values = array()){
        $result = parent::chg($this->check_values($values));
        return $result;
    }

    public function get(){
        $result = parent::get();
        $data = $this->result;
        for($i=0;$i<count($data);$i++){
            if (isset($data[$i]['data_json'])){
                $data[$i]['data_json_parsed'] = $this->get_data_json($data[$i]['data_json']);
            }
            $data[$i]['ab_status_txt'] = $this->get_status($data[$i]['score']);
            if (isset($data[$i]['success'])){
                $data[$i]['success_txt'] = $this->parse_list($data[$i]['success'], "br");
            }
            if (isset($data[$i]['education'])){
                $data[$i]['education_txt'] = $this->parse_list($data[$i]['education']);
            }
            if (isset($data[$i]['is_duty'])){
                $data[$i]['is_duty_txt'] = $this->parse_list($data[$i]['is_duty'], "br");
            }
            if (isset($data[$i]['about'])){
                $data[$i]['about_txt'] = $this->parse_list($data[$i]['about'], "br");
            }
            if (isset($data[$i]['my_publications'])){
                $data[$i]['my_publications_txt'] = $this->parse_list($data[$i]['my_publications'], "br");
            }

        }
        $this->result = $data;

        return $result;
    }

    private function parse_list($txt, $type = 'li'){

        $txt = viewer::render_txt($txt);
        $txt = trim($txt);
        $txt = nl2br($txt, false);
        if (substr_count($txt, "<br>") < 2){
            return $txt;
        }
        if ($type == 'br') return $txt;
        $txt = str_replace("<br>","</li><li>", $txt);
        return "<ul><li>$txt</li></ul>";
    }

    private function get_status($score){
        if (!($this->avtoboss_status)){
            $autoboss_status = new dbl_autoboss_status();
            $autoboss_status->setOrderBy(array("score DESC"))->get();
            $this->avtoboss_status = $autoboss_status->result;
        }
        foreach ($this->avtoboss_status as $res) {
            if ($score >= $res['score']) {
                return $res['title'];
            }
        }
        return '';
    }

    public function get_data_json($data_json){
        $data = json_decode($data_json, true);
        $res = $this->get_json();
        $html = '';
        foreach ($res as $k => $v){
            if (isset($data[$k])){
                $html.="<p>".$v['title'].":&nbsp;".$data[$k]." </p>";
            }
        }
        return $html;
    }

    static function getLoginById($id){
        $user = new dbl_users();
        $user->setFilter(array("id"=>$id));
        if ($user->col()){
            $user->setSelectFields("login")->get();
            return $user->result[0]['login'];
        }
        return '';
    }

    static function getNameById($id){
        $user = new dbl_users();
        $user->setFilter(array("id"=>$id));
        if ($user->col()){
            $user->setSelectFields("name, family_name")->get();
            return $user->result[0]['name']." ".$user->result[0]['family_name'];
        }
        return '';
    }


    static function gen_password($length = 6){
        $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        return substr(str_shuffle($chars), 0, $length);
    }

    static function get_json(){
        return array(
            "type" => array("type"=>"select","ness"=>true,"title"=>"Вид","class"=>"notEmpty", "v"=>array(
                array("id"=>"Частное лицо", "title"=>"Частное лицо"),
                array("id"=>"ИП", "title"=>"ИП"),
                array("id"=>"ООО", "title"=>"ООО"),
                array("id"=>"ЗАО", "title"=>"ЗАО"),
            )),
            "addr" => array("type"=>"input","ness"=>true,"title"=>"Адрес","class"=>"notEmpty"),
            "www" => array("type"=>"input","ness"=>false,"title"=>"Адрес сайта","class"=>""),
        );
    }

    static function get_registration_fields(){
        $regions = new dbl_GAK_regions();
        $regions->setCol(400)->setOrderBy(array("title"))->get();

        $res = array(
            //"tel" => array("type"=>"input","ness"=>true,"title"=>"Телефон","class"=>"notEmpty"),
            "tel" => array("type"=>"input","ness"=>false,"title"=>"Телефон","class"=>"notEmpty"),
            //"login" => array("type"=>"input","ness"=>true,"title"=>"E-mail","class"=>"notEmpty email"),
            "login" => array("type"=>"input","ness"=>false,"title"=>"E-mail","class"=>""),

            "family_name" => array("type"=>"input","ness"=>true,"title"=>"Фамилия","class"=>"notEmpty"),
            "name" => array("type"=>"input","ness"=>true,"title"=>"Имя","class"=>"notEmpty"),
            "pwd" => array("type"=>"input","ness"=>true,"title"=>"Пароль","class"=>"notEmpty"),
            //"GAK_region" => array("type"=>"select","ness"=>true,"title"=>"Регион","class"=>"notEmpty", "v"=>$regions->result),
        );
        /*$etra = self::get_json();
        foreach ($etra as $k => $v){
            $res["data-".$k] = $v;
        }*/

        return $res;
    }



    private function check_values($values){
        $fields = array("is_course_autoboss", "is_course_other", "is_speaker","is_author");
        foreach ($fields as $f){
            if (isset($values[$f])){
                $values['send_moderation_info'] = 1;
                $values['moderation_txt'] = " $f ".date("d.m.Y H:i");
            }
        }

        return $values;
    }

}