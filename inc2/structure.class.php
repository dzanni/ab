<?php
class structure{
    static public function createURL($id){
        $cat = self::getPath($id);
        $url = "/";
        foreach($cat as $key => $value) {
            $url .= $value['enURL'] . "/";
        }
        return $url;
    }
    static public function getPath($id){
        $result = array();
        $i = 0;
        while ($id > 0) {
            $result[++$i] = self::getParent($id);
            $id = $result[$i]["parent"];
        }
        return array_reverse($result);
    }
    static public function getParent($id)
    {
        $cat = new dbl_category();
        $cat->setFilter(array("id"=>$id))->setSelectFields("title, enURL, parent")->get();
        if (count($cat->result)){
            return $cat->result[0];
        }else{
            return 0;
        }
    }
}