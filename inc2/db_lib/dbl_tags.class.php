<?php
class dbl_tags extends db_lib{
    const TABLE_NAME = "tags";

    private $search_with_childs = false;

    public function set_search_with_childs($val){
        $this->search_with_childs = $val;
    }

    public function get(){
        $result = parent::get();
        $data = $this->result;

        if ($this->search_with_childs == false){
            return $result;
        }

        if (count($data) > 0){
            for ($i=0;$i<count($data);$i++){
                $tags = new dbl_tags();
                $tags->set_search_with_childs(true);
                $tags->setFilter(array("parent"=>$data[$i]['id']));
                $tags->setSelectFields("id, title, parent, position, to_show, is_multi")->setOrderBy(array("position", "title"))->setCol(1000)->get();
                $data[$i]['inner'] = $tags->result;
            }
        }
        $this->result = $data;

        return $result;
    }

    static function get_by_id($id, $selected_fields = "id, title, parent")
    {
        $c = new self();
        $c->setFilter(array("id" => $id))->setSelectFields($selected_fields)->get();
        if (count($c->result)) {
            return $c->result[0];
        }
        return false;
    }

    static function get_path_root($id, $selected_fields = "id, title, parent")
    {
        $result = array();
        $index_err = 0;
        while ($parent = self::get_by_id($id, $selected_fields)) {
            $result[] = $parent;
            $id = $parent['parent'];
            if ($index_err++ > 100) { /* предотвращаем потенциальное бесконечное зацикливание */
                return $result;
            }
        }
        return $result;

    }

    static function get_id_by_name_or_create($value)
    {
        $obj = new self;
        $filter = array("title" => $value);
        if ($obj->setFilter($filter)->col() == 0) {
            return $obj->insert_local_table($filter);
        } else {
            $obj->setSelectFields("id")->get();
            return $obj->result[0]['id'];
        }
    }

    static function delete_by_id($id)
    {
        if ($id == 1){
            return 0;
        }

        $c = new self();

        if ($c->setSelectFields("id")->setFilter(array("parent" => $id))->col()) {
            $c->get();
            foreach ($c->result as $res){
                self::delete_by_id($res['id']);
            }
        }

        if ($c->setFilter(array("id" => $id))->delete()){
            return 1;
        }else{
            return 0;
        }
    }

    static function getTags()
    {
        $obj = new self;
        $obj->set_search_with_childs(true);
        $obj->setFilter(array("parent"=>0));
        $obj->setSelectFields("id, title, parent, position")->setCol(1000)->get();
        $res = $obj->result;

        //debug::d($res,1);

        return $res;
    }

    static function getRegTags(){

        $states = self::getTags()[0]['inner'];
        $regions = array();
        foreach($states as $val){
            if ($val['inner'] != ""){
                foreach ($val['inner'] as $val1){
                    $regions[] = $val1;
                }
            }
        }

        usort($regions, function ($item1, $item2) {
            return $item1['title'] <=> $item2['title'];
        });
        //debug::d($regions,1);
        return $regions;
    }

    static function getStatesTags(){
        $obj = new self;
        $obj->setFilter(array("parent"=>1));
        if (!$obj->col()){
            return false;
        }
        $obj->setSelectFields("id")->setCol(200)->get();
        $arr_states = array();
        foreach ($obj->result as $res)
        {
            $arr_states[] = $res['id'];
        }
        return $arr_states;
    }

    static function getRegTagsSimpleArr(){

        $states = self::getTags()[0]['inner'];
        $regions = array();
        foreach($states as $val){
            if ($val['inner'] != ""){
                foreach ($val['inner'] as $val1){
                    $regions[] = $val1['id'];
                }
            }
        }
        sort($regions);
        return $regions;
    }


}