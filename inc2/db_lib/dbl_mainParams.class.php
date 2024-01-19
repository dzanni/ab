<?php
class dbl_mainParams extends db_lib{
    const TABLE_NAME = "mainParams";
    public $params_by_key = array();

    public function get()
    {
        $result = parent::get();
        $data = $this->result;

        for ($i = 0; $i < count($data); $i++) {
            $this->params_by_key[$data[$i]['param']] = $data[$i]['value'];
        }
        $host = $_SERVER['HTTP_HOST'];
        $host = str_replace("www.", "", $host);
        $this->params_by_key['SYS_HOST'] = $host;
        $this->params_by_key['SYS_PROTOKOL'] = "https://";
        return $result;
    }
}