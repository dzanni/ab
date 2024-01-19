<?php

class csv_reader {
    private $type;
    private $filename;
    public $data;
    public $listNames;
    private $maxRow = "notDefined";
    private $csv_razdelitel = "";
    private $csv_charset = "";
    private $startCSV;

    function __construct($filename, $startCSV = 0, $colCSV = 0, $csv_razdelitel = "", $csv_charset = "")
    {
        $this->setRazdelitel($csv_razdelitel);
        $this->setCharset($csv_charset);

        $this->filename = $filename;
            $this->startCSV = $startCSV;
            $this->colCSV = $colCSV;
            $this->data = $this->getCSV();
    }

    public function setRazdelitel($razdelitel){
        if ($razdelitel == "tab"){
            $razdelitel  = "	";
        }
        $this->csv_razdelitel = $razdelitel;
        return $this;
    }
    public function setCharset($charset){
        $this->csv_charset = $charset;
        return $this;
    }

    private function getCSV()
    {
        $i = 0; //количество записей
        $result = array();
        if (($handle_f = fopen($this->filename, "r")) !== false) {
            fseek($handle_f, $this->startCSV);
            $pr = false;
            while (!feof($handle_f)) {
                $line = fgets($handle_f, 4096);
                //$line = mb_convert_encoding($line,"UTF-8","Windows-1251");// TODO GET CHARS FROM SELLER
                if ($this->csv_charset <> "" && $this->csv_charset <> "UTF-8"){
                    $line = mb_convert_encoding($line,"UTF-8",$this->csv_charset);
                }
                $result[$i] = $this->parseSrt($line);
                if ($i >= $this->colCSV) {
                    $this->startCSV = ftell($handle_f);
                    return $result;
                }
                $i++;
            }
            if (!$pr) {
                $this->startCSV = "end";
            }
        }
        return $result;
    }
    public function getEnd(){
        return $this->startCSV;
    }
    private function parseSrt($line)
    {
        if ($this->csv_razdelitel <> ""){
            $razdelitel = $this->csv_razdelitel;
        }else{
            $razd = array(0 => ",", 1 => ";", 2 => "	");
            $index = 0;
            $colMax = 0;
            for($t = 0;$t < count($razd);$t++) {
                $colTmp = substr_count($line, $razd[$t]);
                if ($colTmp > $colMax) {
                    $colMax = $colTmp;
                    $index = $t;
                }
            }

            $razdelitel = $razd[$index];
        }
        $str = "";
        $array = array();
        $index = 0;
        $quuteStart = false;
        for($i = 0;$i < strlen($line);$i++) {
            if ($line[$i] <> $razdelitel && $line[$i] <> '"') {
                $str .= $line[$i];
            } else {
                if (!$quuteStart) {
                    if ($line[$i] == $razdelitel) {
                        $array[$index++] = $str;
                        $str = "";
                    } else {
                        $quuteStart = true;
                    }
                } else {
                    if ($line[$i] == '"') {
                        $quuteStart = false;
                    } else {
                        $str .= $line[$i];
                    }
                }
            }
        }
        $array[$index++] = trim($str);
        return $array;
    }

    private function count_list()
    {
        return count($this->listNames);
    }

    private function dimension($list){
        if ($this->maxRow <> "notDefined"){
            return array(count($this->data[$list][0]), $this->maxRow[$list]+25); // 25 это к-во пустых строк на всякий случай т.к. пустые строки не подсчитываются.
        }else{
            return array(count($this->data[$list][0]), count($this->data[$list]));
        }
    }

    private function get($list, $row, $col)
    {
        return $this->data[$list][$row][$col];
    }
}