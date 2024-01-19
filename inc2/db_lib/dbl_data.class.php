<?php
class dbl_data extends db_lib{
    const TABLE_NAME = "data";

    static function insert_data_for_tovar($id_tovar, $id_options, $value)
    {
        $obj = new self;
        $filter = array("options" => $id_options, "tovar"=>$id_tovar, "text" => $value);
        if ($obj->setFilter($filter)->col() == 0) {
            return $obj->insert_local_table($filter);
        } else {
            $obj->setSelectFields("id")->get();
            return $obj->result[0]['id'];
        }
    }
}