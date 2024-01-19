<?php
class dbl_firm extends db_lib{
    const TABLE_NAME = "firm";

    public function get(){
        $result = parent::get();
        $data = $this->result;
        for($i=0;$i<count($data);$i++){
            if (isset($data[$i]['description'])){
                $data[$i]['description_txt'] = $this->parse_list($data[$i]['description']);
            }
        }
        $this->result = $data;

        return $result;
    }

    private function parse_list($txt){
        $txt = trim($txt);
        $txt = nl2br($txt, false);
        if (substr_count($txt, "<br>") < 2){
            return $txt;
        }
        $txt = str_replace("<br>","</li><li>", $txt);
        return "<ul><li>$txt</li></ul>";
    }

    public static function checkUserTarif(){
        $dbh = DB::getInstance();
        $sql = "SELECT id FROM firm WHERE tarif > 0 AND users =" . CURRENT_USER::getInstance()->id;
        $result = $dbh->query($sql);
        $data = $result->fetchAll(PDO::FETCH_ASSOC);
        $arr_firm = array();
        if ($data){
           foreach($data as $d){
               $arr_firm[] = $d['id'];
           }
        }

        return $arr_firm;
    }
}