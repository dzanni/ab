<?php
class dbl_options extends db_lib{
    const TABLE_NAME = "options";

    static function get_id_by_name_or_create($name){
        $obj = new self;
        if ($obj->setFilter(array("title"=>$name))->col() == 0){
            $insert = array(
                "title"=>$name,
                "main"=>1,
            );
            return $obj->insert_local_table($insert);
        }else{
            $obj->setSelectFields("id")->get();
            return $obj->result[0]['id'];
        }
    }
}