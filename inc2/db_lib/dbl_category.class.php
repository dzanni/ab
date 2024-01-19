<?php
class dbl_category extends db_lib{
    const TABLE_NAME = "coreDataCategory";

    static function get_by_id($id, $selected_fields = "id, title, parent"){
        $c = new self();
        $c->setFilter(array("id"=>$id))->setSelectFields($selected_fields)->get();
        if (count($c->result)){
            return $c->result[0];
        }
        return false;
    }

    static function get_path_root($id, $selected_fields = "id, title, parent"){
        $result = array();
        $index_err = 0;
        while ($parent = self::get_by_id($id, $selected_fields)){
            $result[] = $parent;
            $id = $parent['parent'];
            if ($index_err++ > 100){ /* предотвращаем потенциальное бесконечное зацикливание */
                return $result;
            }
        }
        return $result;
    }

    static function get_child_id_arr($curr, $result = array()){
        if (count($result) == 0){
            $result[] = $curr;
        }
        $obj = new dbl_category();
        $filter = array("parent" => $curr);
        $obj->setFilter($filter)->setSelectFields("id")->get();
        foreach ($obj->result as $v) {
            $result[] = $v["id"];
            $result = self::get_child_id_arr($v["id"], $result);
        }
        return $result;
    }
}