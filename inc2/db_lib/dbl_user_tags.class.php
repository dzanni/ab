<?php
class dbl_user_tags extends db_lib{
    const TABLE_NAME = "user_tags";

    public function insert_local_table($values = array()){
        $result = parent::insert_local_table($values);
        $this->chg_data_search($values);
        return $result;
    }

    public function delete(){
        $result = parent::delete();
        $this->chg_data_search($this->user_filter);
        return $result;
    }

    private function chg_data_search($params){
        if (isset($params['user_id'])){
            $obj = new self();
            $obj->setSelectFields("tag_id")->setGroupBy("tag_id")->setFilter(array('user_id'=>$params['user_id']))->setCol(1000)->setOrderBy(array("tag_id"))->get();
            $search = '~~';
            for ($i=0;$i<count($obj->result);$i++){
                $search.= $obj->result[$i]['tag_id']."~~";
            }
            $user = new dbl_users();
            $user->setFilter(array("id"=>$params['user_id']))->chg(array("search_tag"=>$search));
        }
    }
}



