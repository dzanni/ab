<?php
class SMARTY_GLOBAL{
    protected static $_instance;
    protected $smarty;

    static public function get(){
        $smarty = new Smarty();
        $smarty->compile_check = true;
        $smarty->debugging = false;
        return $smarty;
    }
    function __construct(){
        $this->smarty = $this->get();
    }

    public static function getInstance() {
        if (self::$_instance === null) {
            self::$_instance = new self;
        }

        return self::$_instance->smarty;
    }
    private function __clone() {
    }

    private function __wakeup() {
    }
}