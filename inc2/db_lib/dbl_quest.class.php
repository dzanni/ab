<?php
class dbl_quest extends db_lib{
    const TABLE_NAME = "quest";

    public function chg($values = array()){
        if (isset($values['title'])){
            $values["TXT_INDX"] = txt_search::clearText($values['title']);
        }
        $result = parent::chg($values);
        return $result;
    }


//    public function get(){
//        $result = parent::get();
//        $data = $this->result;
//        for($i=0;$i<count($data);$i++){
//            if (isset($data[$i]['title'])){
//                $data[$i]['title'] = viewer::render_txt($data[$i]['title']);
//            }
//        }
//        $this->result = $data;
//        return $result;
//    }

}