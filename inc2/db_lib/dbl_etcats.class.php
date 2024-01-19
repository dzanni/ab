<?php
class dbl_etcats extends db_lib{
    const TABLE_NAME = "et_cats";
    public $opisanie = "";

    public function getIdByVal($val){
        $this->opisanie = '';
        $val = explode("\n", $val);
        $res = array();
        for($i=0;$i<count($val);$i++){
            $val[$i] = explode("|",$val[$i]);
            $parent = 0;
            if (count($val[$i]) == 3){
                foreach ($val[$i] as $k => $v){
                    $parent = $this->getId($v,$parent);
                }
                $res[] = $parent;
            }else{
                $this->opisanie .= implode("|",$val[$i])."<br>\n";
            }
        }
        return $res;
    }
    public function getId($title,$parent){
        $tmp = new dbl_etcats($this->db);
        $title = trim($title);
        $filter = array(
            "=parent"=> $parent,
            "=title"=>$title
        );
        $tmp->setFilter($filter)->get();
        if (isset($tmp->result[0]['id'])){
            return $tmp->result[0]['id'];
        }else{
            return dbl_etcats::insert(array(
                "parent"=>$parent,
                "title"=>$title
                )
            );
        }
    }

    public function getPath($id){
        $result = array();
        $tmp = new dbl_etcats($this->db);
        $tmp->setFilter(array("=id"=> $id))->get();
        $result[2] = $tmp->result[0];
        $tmp->setFilter(array("=id"=> $tmp->result[0]['parent']))->get();
        $result[1] = $tmp->result[0];
        $tmp->setFilter(array("=id"=> $tmp->result[0]['parent']))->get();
        $result[0] = $tmp->result[0];
        return array($result[0],$result[1],$result[2]);
    }
}