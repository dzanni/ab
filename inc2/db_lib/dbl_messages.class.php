<?php
class dbl_messages extends db_lib{
    const TABLE_NAME = "messages";

    public function get(){
        $result = parent::get();
        $data = $this->result;
        for($i=0;$i<count($data);$i++){
            if ($data[$i]['files_json'] == ""){
                $data[$i]['files_json'] = array();
            }else{
                $data[$i]['files_json'] = json_decode($data[$i]['files_json']);
            }
        }
        $this->result = $data;
        return $result;
    }
}