<?php
class APP{
    protected static $_instance;

    public $user;
    public $route;
    public $order;
    public $seo;
    public $content;
    public $menu;
    public $css;
    public $js;
    public $LB_edit = false;

    public static function getInstance (){
        if (self::$_instance === null) {
            self::$_instance = new self();
            $smarty = SMARTY_GLOBAL::getInstance();
            $smarty->assign("viewer", new viewer());
        }

        return self::$_instance;
    }
    private function __clone() {
    }

    private function __wakeup() {
    }

    public static function add_css($css){
        if (self::$_instance === null) {
            self::$_instance = new self;
        }
        self::$_instance->css[] = $css;
    }
    public static function add_js($js){
        if (self::$_instance === null) {
            self::$_instance = new self;
        }
        self::$_instance->js[] = $js;
    }

    public function getHeaderVariants(){
        $header = PARAMS::get("HEADER");
        $selected = 1; // dafault
        $h = array(
            1 => array("ver"=>1, "selected"=>0, "id"=>"1"),
            2 => array("ver"=>2, "selected"=>0, "id"=>"2"),
            3 => array("ver"=>3, "selected"=>0, "id"=>"3"),
            4 => array("ver"=>4, "selected"=>0, "id"=>"4"),
            5 => array("ver"=>5, "selected"=>0, "id"=>"5"),
            6 => array("ver"=>4, "selected"=>0, "id"=>"6"),
        );
        if (isset($h[$header])) {
            $selected = $header;
        }
        $h[$selected]['selected'] = "1";

        if ($this->user->role_GAK >= 4 && isset($_GET["chg_header_footer"])){
            foreach ($h as &$v){
                $v['chg'] = true;
            }
            return $h;
        }else{
            return array($h[$selected]);
        }
    }

    public function getFooterVariants(){
        $footer = PARAMS::get("FOOTER");
        $selected = 1; // dafault
        $h = array(
            1 => array("ver"=>1, "selected"=>0, "id"=>"1"),
            2 => array("ver"=>2, "selected"=>0, "id"=>"2"),
            3 => array("ver"=>3, "selected"=>0, "id"=>"3"),
            4 => array("ver"=>4, "selected"=>0, "id"=>"4"),
            5 => array("ver"=>5, "selected"=>0, "id"=>"5"),
            6 => array("ver"=>3, "selected"=>0, "id"=>"6"),
        );
        if (isset($h[$footer])) {
            $selected = $footer;
        }
        $h[$selected]['selected'] = "1";
        if ($this->user->role_GAK >= 4 && isset($_GET["chg_header_footer"])){
            foreach ($h as &$v){
                $v['chg'] = true;
            }
            return $h;
        }else{
            return array($h[$selected]);
        }
    }
}