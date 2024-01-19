<?php
class catalogTovarInner extends catalog{
    const TABLE_NAME = "tovarInner";

    function __construct($dbh = 0){
        parent::__construct($dbh);

        $this->setTableJoin("tovarInner, tovar, firm, sellers", "tovarInner.tovar = tovar.id AND tovar.firm = firm.id AND tovarInner.sellers = sellers.id");
        $this->setSelectFields("tovarInner.*, tovar.title as tName, tovar.enName as tovarEnName,tovar.category as tovar_category, firm.title AS fName, sellers.title AS sTitle");
    }

    protected function tovarInnerChg($data){
        $Trans = array_flip(get_html_translation_table());
        $data['tName'] = strtr($data['tName'], $Trans);
        $data['title'] = $data['fName']." ".$data['tName']." ".$data['casheTitle']." ".$data['casheIndex']." ".$data['casheRFXL'];
        $data['parentURL'] = structure::createURL($data['tovar_category']).$data['tovarEnName']."-".$data['tovar'].".html";
        $data['inner'] = true;

        return $data;
    }

    protected function createURL($data){
        return structure::createURL($data['tovar_category']).$data['tovarEnName']."-".$data['tovar']."-tip_".$data['tiporazmer_url'].".html";
    }
    protected function getPhoto($data){
        $obj = new dbl_timages();
        $filter = array("tovar" => $data['tovar']);
        $obj->setFilter($filter)->setOrderBy(array("main", "id DESC"))->setCol(1)->get();
        $img = $obj->result[0]['filename'];
        if ($img){
            $img = $this->pict_url . $img;
        }else{
            $img = "images/no_image.png";
        }
        return $img;
    }

    protected function getAllPhoto($data){
        $obj = new dbl_timages();
        $filter = array("tovar" => $data['tovar']);
        $obj->setFilter($filter)->setOrderBy(array("main", "id DESC"))->setCol(100)->get();
        foreach ($obj->result as &$v) {
            $v['filename'] = $this->pict_url . $v['filename'];
        }
        $img = $obj->result;
        return $img;
    }


}