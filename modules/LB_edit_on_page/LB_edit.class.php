<?php
require_once dirname(__FILE__).'/../../core/inc/category.class.php';
class LB_edit{
    private $category;
    private $db;
    private $elements;
    private $current;
    private $element_pos;
    private $firm;
    private $firmpage;

    function __construct($dbh, $category, $current = 0, $firm, $firmpage)
    {
        $this->db = $dbh;
        $this->category = preg_replace("/[^0-9-]/","",$category);
        $this->firm = preg_replace("/[^0-9]/","",$firm);
        $this->firmpage = preg_replace("/[^0-9]/","",$firmpage);
        $this->current = preg_replace("/[^0-9]/","",$current);
        $this->getElements();
    }
    private function getElements(){
        $category = new category();
        $category->id = $this->category;
        $category->get($this->db);
        $this->elements = $category->pageData;
        if ($this->current){
            for($i=0;$i<count($this->elements);$i++){
                if ($this->elements[$i]['id'] == $this->current){
                    $this->element_pos = $i;
                }
            }
        }
        return $this;
    }
    public function getById($id){
        for($i=0;$i<count($this->elements);$i++){
            if ($this->elements[$i]['id'] == $id){
                return $this->elements[$i];
            }
        }
        return false;
    }
    public function insert($LB_id, $insert_type){
        $landing_block = array();
        if ($LB_id == "clipboard"){
            if(isset($_SESSION['copy_to_clip'])) {
                $txtBlock = category::getTxtBlock($this->db, $_SESSION['copy_to_clip']);
                $LB_id = $txtBlock['landing_block_type_id'];
                $copy_id = $txtBlock['id'];
                $landing_block = $txtBlock['landing_block'];
            }else{
                return false;
            }
        }
        $landing_block_json = json_encode($landing_block);
        $landing_block = serialize($landing_block);

        if ($LB_id == "default"){
            $LB_id = 0;
        }
        $position = $this->getPos($insert_type);

        $stml = $this->db->prepare("INSERT INTO coreDataTable (landing_block_type_id, `position`, coreDataCategory, landing_block, firm, firmpage) VALUES (?,?,?,?,?,?)");
        if($stml->execute(array($LB_id, $position, $this->category, $landing_block, $this->firm, $this->firmpage))){
            $id = $this->db->lastInsertId();
            if (isset($copy_id)){
                $this->copyFiles($copy_id, $id);

                $landing_block = str_replace("files\/land\/$copy_id\/","files\/land\/$id\/", $landing_block_json);
                txt::edit($this->db, "landing_block", json_decode($landing_block,true), $id);
                //unset($_SESSION['copy_to_clip']);
            }
            $this->getElements();
            return $id;
        }else{
            return 0;
        }
    }
    public function copyFiles($from, $to){
        $path = dirname(__FILE__).'/../../files/land/';
        $pathFrom = $path.$from;
        $pathTo = $path.$to;
        if(!(file_exists($pathTo) && is_dir($pathTo))){
            mkdir($pathTo, 0777);
        }
        if ($handle = opendir($pathFrom)) {
            while (false !== ($file = readdir($handle))) {
                if ($file != "." && $file != "..") {
                     copy($pathFrom."/$file",$pathTo."/$file");
                }
            }
            closedir($handle);
        }
        return 1;
    }
    private function getPos($type){
        if (!$this->current){
            return 0;
        }
        if ($type == "before"){
            if ($this->element_pos == 0){
                return $this->elements[$this->element_pos]['position']-2;
            }
            return ($this->elements[$this->element_pos]['position']+$this->elements[$this->element_pos-1]['position'])/2;
        }else{
            if (!isset($this->elements[$this->element_pos+1])){
                return $this->elements[$this->element_pos]['position']+2;
            }
            return ($this->elements[$this->element_pos]['position']+$this->elements[$this->element_pos+1]['position'])/2;
        }
    }
}