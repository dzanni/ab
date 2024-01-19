<?php
class dbl_sellers_ws extends db_lib{
    const TABLE_NAME = "sellers_ws";

    public function get(){
        $result = parent::get();
        $data = $this->result;
        for($i=0;$i<count($data);$i++){
            if ($data[$i]['params'] == ""){
                $data[$i]['params'] = array();
            }else{
                $data[$i]['params'] = unserialize($data[$i]['params']);
            }
            $data[$i]["id"] = -$data[$i]["id"];
        }
        $this->result = $data;
        return $result;
    }
}