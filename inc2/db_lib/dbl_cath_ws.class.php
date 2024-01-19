<?php
class dbl_cath_ws extends db_lib{
    const TABLE_NAME = "cath_ws";

    public function get(){
        $result = parent::get();
        $data = $this->result;
        for($i=0;$i<count($data);$i++){
            if (isset($data[$i]['result'])){
                $data[$i]['result'] = unserialize($data[$i]['result']);
            }
        }
        $this->result = $data;
        return $result;
    }
}