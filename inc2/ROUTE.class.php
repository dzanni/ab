<?php
class ROUTE{
    protected static $_instance;

    public $url;
    public $values;
    private $db;
    public $path;
    public $path_category;
    public $mainPage = false;
    public $modules = array();
    public $mainModule = false;
    public $subCats = array();
    public $category = 0;
    public $tovar = 0;
    public $tovarInnerCol = 0;
    public $tire_disk = 0;
    public $firmPage = false;
    public $right_block = false;
    public $white_back = false;

    public function __construct()
    {
        $this->url = $_SERVER['REQUEST_URI'];
        $this->db = DB::getInstance();
        $this->parse_url();
    }
    public static function getInstance() {
        if (self::$_instance === null) {
            self::$_instance = new self;
        }

        return self::$_instance;
    }
    private function __clone() {
    }

    private function __wakeup() {
    }


    public function getSubCats(){
        if ($this->category <= 0 ) return array();
        $category = new dbl_category();
        $category->setSelectFields("id, title, enURL");
        $category->setFilter(array("parent"=>$this->category))->get();
        $res = $category->result;
        foreach ($res as &$r){
            $r["URL"] = $this->path_category.$r['enURL']."/";
        }
        return $res;
    }


    private function parse_url(){
        $this->path_category = explode("?",$this->url)[0];

        if ($this->path_category == "/"){
            $this->mainPage = true;
            $this->category = 0;

            return;
        }
        $this->values = explode("/", preg_replace("~(^/|/$)~","",$this->path_category));
        $this->parse_path_module();

        // Страницу фирмы повесим на флаг ROUTE
        if ($this->mainModule['id'] == 23 && isset($_GET['firm']) /*&& isset($_GET['firmpage'])*/){
            $firm  = preg_replace("/[^0-9]/", "", $_GET['firm']);
            if (isset($_GET['firmpage'])){
                $firmpage = preg_replace("/[^0-9]/", "", $_GET['firmpage']);
            }else{
                $firmpage = 0;
            }

            if (dbl_firm_pages::pageExist($firm, $firmpage)){
                $this->firmPage = true;
                $this->right_block = db_lib::get_field_by_table_and_id('firm_pages', 'right_block', $firmpage);
                $this->white_back = db_lib::get_field_by_table_and_id('firm_pages', 'white_back', $firmpage);
            }
        }
    }
    private function parse_path_module(){
        $modules = new dbl_modules();
        $modules->setSelectFields("id,title,titleEN,enURL");
        if($modules->setFilter(array("enURL"=>"", "status"=>1, "category" => 0))->col()) {
            $modules->get();
            $this->modules = $modules->result;
        }
        if($modules->setFilter(array("enURL"=>$this->values[0], "!=enURL"=>"", "status"=>1, "category" => 0))->col()){
            $modules->get();
            $this->modules[] = $modules->result[0];
            $this->mainModule = $modules->result[0];
        }else{
            $this->parse_path_category();
        }
    }

    public function add_path($array){
        $this->path[] = $array;
    }
    private function parse_path_category(){
        $category = new dbl_category();
            $category->setSelectFields("id, title, enURL");
            $parent = 0;
            $URL = "/";
            if (isset($this->values[0]) && $this->values[0] == "modules"){
                return false;
            }
            foreach ($this->values as $v) {
                $URL .= "$v/";
                if ($category->setFilter(array("enURL" => $v, "parent" => $parent))->col()) {
                    $category->get();
                    $category->result[0]['URL'] = $URL;
                    $parent = $category->result[0]['id'];
                    $this->path[] = $category->result[0];
                    $this->category = $category->result[0]['id'];
                    if ($category->result[0]['id'] == PARAMS::get('TYRES_CAT') || $category->result[0]['id'] == PARAMS::get('DISK_CAT') ||  $category->result[0]['id'] == PARAMS::get('TYRE_SEARCH_ID_CAT')  ){
                        $this->tire_disk = true;
                    }
                } else {
                    if (!$this->get_tovar_id($v)){
                        $this->setError(404);
                    }
                }
            }
    }

    private function get_tovar_id($url){
        $tovar_url = preg_replace("/\.html/","",$url);
        if ($url == $tovar_url){
            return 0;
        }
        $tovarInnerUrl = '';
        $tovar_url = explode("-tip_", $tovar_url);
        if (count($tovar_url) == 2){ // tovarInner
            $tovarInnerUrl = $tovar_url[1];
        }
        $tovar_url = explode("-",$tovar_url[0]);
        $catalog = new dbl_tovar();
        $id = $tovar_url[count($tovar_url)-1];
        unset($tovar_url[count($tovar_url)-1]);
        $enName = implode("-", $tovar_url);

        $filter = array(
            "category"=> $this->category,
            "enName"=> $enName,
            "id"=> $id,
        );
        if($catalog->setFilter($filter)->col()){
            $this->tovar = $id;
            if ($tovarInnerUrl != ''){
                $tInnerId = array();
                $filter = array(
                    "tovar"=> $this->tovar,
                    "tiporazmer_url"=> $tovarInnerUrl,
                );
                if (PARAMS::get("SHOW_IF_NOT_COL") == 1){
                    $filter[">showUser"] = 0;
                }else{
                    $filter["showUser"] = 1;
                }
                if($catalog->setFilter($filter)->col()){
                    $catalog->get();
                    foreach ($catalog->result as $res){
                        $tInnerId[] = $res['id'];
                    }
                }

                if (count($tInnerId)){
                    $this->tovar = $tInnerId;
                    $this->tovarInnerCol = count($tInnerId);
                }else{
                    $this->tovar = 0;
                }
            }
            return $this->tovar;
        }
        return 0;
    }

    public function setError($code){
        if ($code == 404){
            header("HTTP/1.1 404 Not Found");
            header("Status: 404 Not Found");
            $smarty = SMARTY_GLOBAL::getInstance();
            $smarty->display("404.tpl");
            exit();
        }
    }

    public function render_path(){
        return viewer::render_path($this->path);
    }

    public function get_url_with_params($vars = array()){
        /* $vars = array("page"=>2, "var_x"=>2, );*/
        $result = $this->path_category;
        $search = array();
        foreach ($_GET as $key => $g){
            if (!isset($vars[$key])){
                if (!is_array($g)){
                    $search[]=$key."=".$g;
                }else{
                    foreach ($g as $k1 => $g1){
                        if (!is_array($g1)){
                            $search[]=$key."[$k1]=".$g1;
                        }else{
                            foreach ($g1 as $k2 => $g2){
                                $search[]=$key."[$k1][$k2]=".$g2;
                            }
                        }
                    }
                }
            }else{
                $search[]=$key."=".$vars[$key];
            }
        }
        foreach ($vars as $key => $g){
            if (!isset($_GET[$key])){
                $search[]=$key."=".$vars[$key];
            }
        }
        $search = implode("&", $search);
        $search = preg_replace("/[\"<>]/","",$search);
        if ($search != ''){
            $result.="?$search";
        }
        return $result;
    }
}