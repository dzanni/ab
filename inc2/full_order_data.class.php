<?php
class full_order_data extends dbl_orderData {
    private $order_id;
    public $col = 0;
    public $sum = 0;
    public $sum_formatted = 0;

    function __construct($order_id){
        parent::__construct();
        $this->order_id = $order_id;
        $this->setFilter(array("orders"=>$this->order_id))->get();
    }

    public function get(){
        $result = parent::get();
        $this->parse_get_result($this->result);
        return $result;
    }

    protected function parse_get_result($data){
        $Trans = array_flip(get_html_translation_table());
        for($i=0;$i<count($data);$i++){
            $data[$i]['sum'] = $data[$i]['price'] * $data[$i]['col'];
            $this->col+=$data[$i]['col'];
            $this->sum+=$data[$i]['sum'];
            $data[$i]['otkaz_txt'] = $this->get_otkaz_txt($data[$i]['otkaz_status']);
            $data[$i]['sum_formatted'] = str_replace(" ", "&nbsp;", number_format($data[$i]['sum'], PARAMS::get("ROUND_PRICE"), '.', " "));
        }
        $this->sum_formatted = str_replace(" ", "&nbsp;", number_format($this->sum, PARAMS::get("ROUND_PRICE"), '.', " "));
        $this->result = $data;
        return $data;
    }

    public function return_obj(){
        $obj = new stdClass();
        $obj->result = $this->result;
        $obj->sum = $this->sum;
        $obj->col = $this->col;
        return $obj;
    }

    private function get_otkaz_txt($id){
        foreach ($this::get_otkaz_status() as $v){
            if ($v['id'] == $id) return $v['title'];
        }
        return '';
    }

    static function get_otkaz_status(){
        return array(
            array("id" => 1, "title" => "В обработке"),
            array("id" => 2, "title" => "Принят"),
            array("id" => 3, "title" => "Не принят"),
        );
    }
}

