<?php
class GAK_role {
    static function get($role){
        $role = array(
            array("id"=>0, "title"=>"Пользователь"),
            array("id"=>4, "title"=>"Администратор"),
            array("id"=>10, "title"=>"Разработчик"),
        );
        $res = array();
        foreach ($role as $r){
            if ($role >= $r['id']){
                $res[] = $r;
            }
        }
        return $res;
    }
}