<?php
class dbl_score extends db_lib{
    const TABLE_NAME = "score";

    static function add_score($user, $type){
        $bonus = self::get_bonus_by_code($type);
        if ($bonus){
            self::set_bonus($user, $bonus);
        }
    }
    static function set_bonus($user_id, $bonus){
        $user = new dbl_users();
        $user->setFilter(array("id"=>$user_id))->setSelectFields("score")->get();
        if (count($user->result)){
            $values = array("score" => $user->result[0]['score'] + $bonus);
            $user->chg($values);
        }
    }

    static function get_bonus_by_code($name){
        $score = array(
            "registrate" => 1,
            "referal_registrate" => 10,
            "like" => 7,
            "unlike" => 7,
            "visit" => 5,
            "otzyv" => 9,
            "quest" => 6,
            "answer" => 14
        );
        if ($score[$name]){
            $obj = new self;
            $obj->setFilter(array("id"=>$score[$name]))->setSelectFields("score")->get();
            $score = $obj->result[0]['score'];
            if ($name == "unlike"){
                $score = -$score;
            }
            return $score;
        }
        return 0;
    }
}