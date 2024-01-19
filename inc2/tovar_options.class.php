<?php
class tovar_options extends db_lib{
    const TABLE_NAME = "data";

    function __construct(){
        parent::__construct();

        $this->setTableJoin("data, options", "data.options = options.id");
        $this->setSelectFields("options.*, data.text AS value");
    }

    public function get(){
        $result = parent::get();
        $this->parse_get_result($this->result); ;
        return $result;
    }

    protected function parse_get_result($data){
        for($i=0;$i<count($data);$i++){
            if ($data['output'] < 2 ){
                $data[$i]['value'] = $this->getOptionValuesNameById($data[$i]['value']);
            }
        }
        $this->result = $data;
        return $data;
    }

    protected function getOptionValuesNameById($id){
        $options_values = new dbl_options_values();
        $res = $options_values->setSelectFields("title")->getById($id); 
        if (isset($res['title'])){
            return $res['title'];
        }else{
            return $id;
        }
    }
}

