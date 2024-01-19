<?php
class dbl_answer extends db_lib{
    const TABLE_NAME = "answer";
    private $parents = array();

public function getParents($id){
    $this->setSelectFields("id, parent")->setFilter(array("id"=>$id));
    if ($this->col()){
        $this->get();
        $this->parents[] = $this->result[0]['parent'];
        $this->getParents($this->result[0]['parent']);
    }
     return $this->parents;
}

    static function get_child_id_arr($curr, $result = array()){
        if (count($result) == 0){
            $result[] = $curr;
        }
        $obj = new dbl_answer();
        $filter = array("parent" => $curr);
        $obj->setFilter($filter)->setSelectFields("id")->setCol(500)->get();
        foreach ($obj->result as $v) {
            $result[] = $v["id"];
            $result = self::get_child_id_arr($v["id"], $result);
        }
        return $result;
    }

// Не работает, убрали:
//    public function getChildren($id){
//
//    if (!is_array($id)){
//        $id =(array)$id;
//    }
//        $this->setSelectFields("id")->setFilter(array("IN=parent"=>implode(",", $id)))->setCol(500);
//        if ($this->col()){
//            $this->get();
//            foreach ($this->result as $res){
//                $this->children[] = $res['id'];
//            }
//           //$this->getChildren($this->children);
//        }
//        return $this->children;
//    }
}