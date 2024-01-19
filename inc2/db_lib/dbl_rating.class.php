<?php
class dbl_rating extends db_lib{
    const TABLE_NAME = "rating";

    public function update_rating($firm_id){

        $obj = new self;
        $obj->setFilter(array("firm_id" => $firm_id))->setSelectFields(" AVG(rating) AS rating ")->get();

        $firm = new dbl_firm();
        $firm->setFilter(array("id" => $firm_id))->chg(array("rating" => $obj->result[0]['rating']));

        return $obj->result[0]['rating'];
    }
}