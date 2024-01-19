<?php
class dbl_orderData extends db_lib
{
    const TABLE_NAME = "orderData";
    private $getImg = false;

    public function setGetImg($v)
    {
        $this->getImg = $v;
        return $this;
    }

    public function get(){
        $result = parent::get();
        $data = $this->result;

        if ($this->getImg == true){
           return $result;
        }

        if (count($data) > 0){
            foreach ($data as &$d) {
                $img = $this->getImgByTovarId($d['tovarId']);
                if ($img) {
                    $d['data_img'] = $img;
                }else{
                    $tovar = new dbl_tovar();
                    $tovar->setFilter(array("id"=>$d['tovarId']))->setSelectFields("tovar")->get();
                    if ($tovar->result[0]['tovar'] > 0){
                        $img = $this->getImgByTovarId($tovar->result[0]['tovar']);
                        if ($img) {
                            $d['data_img'] = $img;
                        }
                    }
                }
            }
        }
        $this->result = $data;
        return $result;
    }

    private function getImgByTovarId($id){
        $timages = new dbl_timages();
        $timages->setFilter(array("tovar" => $id, "position" => 0));
        if ($timages->col()) {
            $timages->get();
            return $timages->result[0]['filename'];
        }
        return false;
    }

}