<?php
class dbl_quest_tags extends db_lib{
    const TABLE_NAME = "quest_tags";

    public function insert_local_table($values = array()){
        $result = parent::insert_local_table($values);
        $this->chg_relationsips($values);
        return $result;
    }

    public function delete(){
        $result = parent::delete();
        $this->chg_relationsips($this->user_filter);
        return $result;
    }

    private function get_tags_in_row($params){
        if (isset($params['quest_id'])){
            $obj = new self();
            $obj->setSelectFields("tag_id")->setGroupBy("tag_id")->setFilter(array('quest_id'=>$params['quest_id']))->setCol(1000)->setOrderBy(array("tag_id"))->get();
            $search = '%';
            for ($i=0;$i<count($obj->result);$i++){
                $search.= "~".$obj->result[$i]['tag_id']."~%";
            }
            return $search;
        }
        return '';
    }
    private function chg_relationsips($params){

        $obj = new dbl_relative_questions();
        $obj->setFilter(array("quest"=>$params['quest_id']))->delete();

        $search = $this->get_tags_in_row($params);
        if ($search){
            $users = new dbl_users();
            $filter = array(
                "LIKE=search_tag" => "$search",
            );
            $users->setFilter($filter)->setCol(500)->setSelectFields("id");

            for ($i=1;$i<500;$i++){
                $users->setPage($i)->get();
                if (count ($users->result) == 0){
                    return true;
                }
                foreach ($users->result as $item) {
                    $values = array(
                        "quest"=>$params['quest_id'],
                        "users"=>$item['id'],
                    );
                    $obj->insert_local_table($values);
                }
            }

        }
        return false;
    }
}



