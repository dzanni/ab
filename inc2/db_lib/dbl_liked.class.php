<?php
class dbl_liked extends db_lib{
    const TABLE_NAME = "liked";

    static function getLikesByObj($obj_name, $obj_id, $user_id = 0){
        $obj = new self;
        $filter = array(
            "obj" => $obj_name,
            "obj_id" => $obj_id,
        );
        if ($user_id > 0){
            $filter['user_id'] = $user_id;
        }
        return $obj->setFilter($filter)->col();
    }

    public function insert_local_table($values = array()){
        $result = parent::insert_local_table($values);
        $this->chg_data_search($values);
        return $result;
    }

    public function delete(){
        $result = parent::delete();
        $this->chg_data_search_unlike($this->user_filter);
        return $result;
    }

    private function chg_data_search($params){
        if (isset($params['user_id'])){
            dbl_score::add_score($params['user_id'], "like");
        }
    }
    private function chg_data_search_unlike($params){
        if (isset($params['user_id'])){
            dbl_score::add_score($params['user_id'], "unlike");
        }
    }
}