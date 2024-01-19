<?php
class PARAMS{
    protected static $_instance;

    private function __construct() {
        $params = new dbl_mainParams();
        $params->setCol(1000)->get(); // получаем все свойства
        $this->params = $params->params_by_key; // массив где параметр = ключ массива
    }

    public static function getInstance() {
        if (self::$_instance === null) {
            self::$_instance = new self;
        }

        return self::$_instance->params;
    }

    public static function get($param) {
        if (self::$_instance === null) {
            self::$_instance = new self;
        }
        return self::$_instance->params[$param];
    }
    public static function getAll(){
        if (self::$_instance === null) {
            self::$_instance = new self;
        }
        return self::$_instance->params;
    }

    private function __clone() {
    }

    private function __wakeup() {
    }
}