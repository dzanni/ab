<?php
class dbl_remark extends db_lib{
    const TABLE_NAME = "remark";

    public function insert_local_table($values = array()){
        $result = parent::insert_local_table($values);
        $this->chg_data_search($values);
        return $result;
    }

    private function chg_data_search($params){
        if (isset($params['user_id'])){
            dbl_score::add_score($params['user_id'], "otzyv");
        }
    }
}